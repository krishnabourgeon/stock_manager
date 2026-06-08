package com.stockmanager.app

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.cloudpos.POSTerminal
import com.cloudpos.printer.PrinterDevice

class MainActivity : FlutterActivity() {

    private val CHANNEL = "cloudpos/printer"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->

                when (call.method) {

                    "printReceipt" -> {
                        try {
                            val shop = call.argument<String>("shop") ?: ""
                            val shopaddress = call.argument<String>("shopaddress") ?: ""
                            val shopaddress2 = call.argument<String>("shopaddress2") ?: ""

                            val items = call.argument<List<Map<String, Any>>>("items") ?: listOf()

                            val mode = call.argument<String>("mode") ?: ""

                            val bill = safeInt(call.argument<Any>("bill"))
                            val total = safeInt(call.argument<Any>("total"))

                            val billdate = call.argument<String>("billdate") ?: ""
                            val billtime = call.argument<String>("billtime") ?: ""

                            // GST Values
                            val cgst = call.argument<Double>("cgst") ?: 0.0
                            val sgst = call.argument<Double>("sgst") ?: 0.0
                            val gst = call.argument<Double>("gst") ?: 0.0

                            // ✅ Discount fields
                            val discountInput = call.argument<Double>("discountInput") ?: 0.0
                            val discountType = call.argument<String>("discountType") ?: "flat"
                            val subTotal = call.argument<Double>("subTotal") ?: 0.0

                            // Compute actual discount rupee value
                            val discountValue: Double
                            val discountLabel: String
                            if (discountInput > 0) {
                                if (discountType == "percentage") {
                                    discountValue = subTotal * discountInput / 100
                                    discountLabel = "Discount (${discountInput.toInt()}%)"
                                } else {
                                    discountValue = discountInput
                                    discountLabel = "Discount"
                                }
                            } else {
                                discountValue = 0.0
                                discountLabel = ""
                            }

                            printReceipt(
                                shop,
                                shopaddress,
                                shopaddress2,
                                items,
                                mode,
                                bill,
                                billdate,
                                billtime,
                                total,
                                cgst,
                                sgst,
                                gst,
                                discountValue,
                                discountLabel,
                                subTotal
                            )

                            result.success("Printed")

                        } catch (e: Exception) {
                            result.error("PRINT_ERROR", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
            }
    }

    private fun safeInt(value: Any?): Int {
        return when (value) {
            is Int -> value
            is Long -> value.toInt()
            is Double -> value.toInt()
            is String -> value.toIntOrNull() ?: 0
            else -> 0
        }
    }

    private fun printReceipt(
        shop: String,
        address: String,
        address2: String,
        items: List<Map<String, Any>>,
        mode: String,
        bill: Int,
        billdate: String,
        billtime: String,
        total: Int,
        cgst: Double,
        sgst: Double,
        gst: Double,
        discountValue: Double,         // ✅ actual rupee amount deducted
        discountLabel: String,         // ✅ "Discount" or "Discount (10%)"
        subTotal: Double,              // ✅ pre-discount subtotal
    ) {
        try {
            val printer = POSTerminal.getInstance(this)
                .getDevice("cloudpos.device.printer") as PrinterDevice

            printer.open()

            val builder = StringBuilder()

            builder.append(centerText(shop))
            builder.append(centerText(address))
            builder.append(centerText(address2))

            builder.append("--------------------------------\n")
            if (bill != 0) {
                builder.append(leftRightAlign("Bill No : $bill", "$billdate"))
            } else {
                builder.append(rightAlign("$billdate"))
            }
            builder.append(rightAlign("$billtime\n"))

            for ((index, item) in items.withIndex()) {
                val type = item["type"]?.toString()
                if (!type.isNullOrEmpty() && type != "null") {
                    builder.append("${index + 1}. $type\n")
                }

                val name = item["name"].toString()
                val qty = (item["qty"] as? Number)?.toInt()
                    ?: item["qty"]?.toString()?.toIntOrNull()
                    ?: 0
                val rate = (item["rate"] as? Number)?.toInt()
                    ?: item["rate"]?.toString()?.toIntOrNull()
                    ?: 0
                val unit = item["unit"] as? String

                builder.append(formatItem(item["type"], name, qty, rate, unit))
            }

            builder.append("--------------------------------\n")

            // ✅ Show subtotal only when there's a discount so the deduction is clear
            if (discountValue > 0 && subTotal > 0) {
                builder.append(leftRightAlign("Sub Total", "Rs %.2f".format(subTotal)))
                builder.append(leftRightAlign(discountLabel, "- Rs %.2f".format(discountValue)))
            }

            if (cgst > 0) {
                builder.append(leftRightAlign("CGST", "Rs %.2f".format(cgst)))
            }
            if (sgst > 0) {
                builder.append(leftRightAlign("SGST", "Rs %.2f".format(sgst)))
            }
            if (gst > 0) {
                builder.append(leftRightAlign("GST Total", "Rs %.2f".format(gst)))
            }

            builder.append("--------------------------------\n")

            if (mode.isNotEmpty() && mode != "null") {
                builder.append(leftRightAlign("Mode: $mode", "TOTAL: Rs $total"))
            } else {
                if (total != 0) {
                    builder.append(rightAlign("TOTAL: Rs $total\n"))
                }
            }

            if (total != 0) {
                builder.append("--------------------------------\n")
            }
            builder.append(centerText("THANK YOU"))
            builder.append("\n\n")

            printer.printText(builder.toString())
            printer.printText("\n\n\n")
            printer.close()

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun centerText(text: String, width: Int = 32): String {
        val padding = (width - text.length) / 2
        return " ".repeat(if (padding > 0) padding else 0) + text + "\n"
    }

    private fun rightAlign(text: String, width: Int = 32): String {
        val padding = width - text.length
        return " ".repeat(if (padding > 0) padding else 0) + text
    }

    private fun formatItem(itemName: Any?, name: String, qty: Int, rate: Any?, unit: String?): String {
        return if (itemName == "" || itemName == null || itemName == "null") {
            if (rate == 0 || rate == "0") {
                if (unit != null && unit != "null" && unit != "") {
                    "$name $qty$unit\n\n"
                } else {
                    "$name $qty\n\n"
                }
            } else {
                "$name $qty x $rate\n\n"
            }
        } else {
            "   $name $qty x $rate\n\n"
        }
    }

    private fun leftRightAlign(left: String, right: String, width: Int = 32): String {
        val space = width - (left.length + right.length)
        return left + " ".repeat(if (space > 0) space else 1) + right + "\n"
    }
}
