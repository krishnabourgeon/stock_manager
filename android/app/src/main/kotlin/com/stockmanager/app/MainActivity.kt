package com.stockmanager.app

import android.graphics.Bitmap
import android.graphics.Canvas
import android.graphics.Color
import android.graphics.Paint
import android.graphics.Typeface
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import com.cloudpos.POSTerminal
import com.cloudpos.printer.PrinterDevice

class MainActivity : FlutterActivity() {

    private val CHANNEL = "cloudpos/printer"
    private val PRINT_WIDTH = 384

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
                            val total = safeDouble(call.argument<Any>("total"))
                            val billdate = call.argument<String>("billdate") ?: ""
                            val billtime = call.argument<String>("billtime") ?: ""
                            val cgst = call.argument<Double>("cgst") ?: 0.0
                            val sgst = call.argument<Double>("sgst") ?: 0.0
                            val gst = call.argument<Double>("gst") ?: 0.0
                            val discountInput = call.argument<Double>("discountInput") ?: 0.0
                            val discountType = call.argument<String>("discountType") ?: "flat"
                            val subTotal = call.argument<Double>("subTotal") ?: 0.0

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
                                shop, shopaddress, shopaddress2, items, mode, bill,
                                billdate, billtime, total, cgst, sgst, gst,
                                discountValue, discountLabel, subTotal
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

    private fun safeDouble(value: Any?): Double {
        return when (value) {
            is Double -> value
            is Int -> value.toDouble()
            is Long -> value.toDouble()
            is String -> value.toDoubleOrNull() ?: 0.0
            else -> 0.0
        }
    }

    private fun hasNonAscii(text: String): Boolean = text.any { it.code > 127 }

    private fun padEnd(text: String, width: Int): String {
        return if (text.length >= width) text.substring(0, width)
        else text + " ".repeat(width - text.length)
    }

    private fun padStart(text: String, width: Int): String {
        return if (text.length >= width) text.substring(0, width)
        else " ".repeat(width - text.length) + text
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
        total: Double,
        cgst: Double,
        sgst: Double,
        gst: Double,
        discountValue: Double,
        discountLabel: String,
        subTotal: Double,
    ) {
        try {
            val printer = POSTerminal.getInstance(this)
                .getDevice("cloudpos.device.printer") as PrinterDevice
            printer.open()

            data class ReceiptLine(val text: String, val align: String = "left", val bold: Boolean = false)

            val lines = mutableListOf<ReceiptLine>()

            // ── Shop header ──────────────────────────────────────────────
            if (shop.isNotEmpty()) lines.add(ReceiptLine(shop.trim(), "center", bold = true))
            if (address.isNotEmpty()) lines.add(ReceiptLine(address, "center"))
            if (address2.isNotEmpty()) lines.add(ReceiptLine(address2, "center"))

            lines.add(ReceiptLine("--------------------------------", "center"))

            // ── #BillNo + Date on one line ───────────────────────────────
            if (bill != 0) {
                val billStr = "#$bill"
                val gap = 32 - billStr.length - billdate.length
                val spaces = if (gap > 0) " ".repeat(gap) else "  "
                lines.add(ReceiptLine("$billStr$spaces$billdate", "left"))
            } else {
                lines.add(ReceiptLine(billdate, "right"))
            }
            if (billtime.isNotEmpty()) lines.add(ReceiptLine(billtime, "right"))

            lines.add(ReceiptLine("--------------------------------", "center"))

            // ── Table header ─────────────────────────────────────────────
            val colItem = 16
            val colQtyRate = 10
            val colAmt = 6
            val header = padEnd("Item", colItem) + padEnd("Qty x Rate", colQtyRate) + padStart("Amt", colAmt)
            lines.add(ReceiptLine(header, "left", bold = true))
            lines.add(ReceiptLine("--------------------------------", "center"))

            // ── Item rows ────────────────────────────────────────────────
            for (item in items) {
                val type = item["type"]?.toString()
                val name = item["name"].toString()
                val qty = (item["qty"] as? Number)?.toDouble()
                    ?: item["qty"]?.toString()?.toDoubleOrNull() ?: 0.0
                val rate = (item["rate"] as? Number)?.toDouble()
                    ?: item["rate"]?.toString()?.toDoubleOrNull() ?: 0.0

                val qtyStr = if (qty % 1.0 == 0.0) qty.toInt().toString() else "%.2f".format(qty)
                val rateStr = if (rate % 1.0 == 0.0) rate.toInt().toString() else "%.2f".format(rate)
                val amt = qty * rate
                val amtStr = if (amt % 1.0 == 0.0) amt.toInt().toString() else "%.2f".format(amt)
                val qtyRateStr = "$qtyStr x $rateStr"

                if (name.length > colItem - 1) {
                    // Long name: name on its own line, numbers indented below
                    lines.add(ReceiptLine(name, "left"))
                    lines.add(ReceiptLine(
                        padEnd("", colItem) + padEnd(qtyRateStr, colQtyRate) + padStart(amtStr, colAmt),
                        "left"
                    ))
                } else {
                    lines.add(ReceiptLine(
                        padEnd(name, colItem) + padEnd(qtyRateStr, colQtyRate) + padStart(amtStr, colAmt),
                        "left"
                    ))
                }
            }

            lines.add(ReceiptLine("--------------------------------", "center"))

            // ── Discount — bold, aligned to table columns ────────────────
            if (discountValue > 0 && subTotal > 0) {
                lines.add(ReceiptLine(
                    padEnd("Sub Total", colItem + colQtyRate) + padStart("\u20b9%.2f".format(subTotal), colAmt),
                    "left", bold = true
                ))
                lines.add(ReceiptLine(
                    padEnd(discountLabel, colItem + colQtyRate) + padStart("-\u20b9%.2f".format(discountValue), colAmt),
                    "left", bold = true
                ))
            }

// ── GST — bold, aligned to table columns ─────────────────────
            if (cgst > 0) lines.add(ReceiptLine(
                padEnd("CGST", colItem + colQtyRate) + padStart("\u20b9%.2f".format(cgst), colAmt),
                "left", bold = true
            ))
            if (sgst > 0) lines.add(ReceiptLine(
                padEnd("SGST", colItem + colQtyRate) + padStart("\u20b9%.2f".format(sgst), colAmt),
                "left", bold = true
            ))
            if (gst > 0) lines.add(ReceiptLine(
                padEnd("GST Total", colItem + colQtyRate) + padStart("\u20b9%.2f".format(gst), colAmt),
                "left", bold = true
            ))

            lines.add(ReceiptLine("--------------------------------", "center"))

            // ── Mode & Total ─────────────────────────────────────────────
            if (mode.isNotEmpty() && mode != "null") lines.add(ReceiptLine("Mode: $mode", "left"))
            if (total != 0.0) {
                lines.add(ReceiptLine("TOTAL: \u20b9%.2f".format(total), "right", bold = true))
                lines.add(ReceiptLine("--------------------------------", "center"))
            }

            lines.add(ReceiptLine("THANK YOU", "center", bold = true))
            lines.add(ReceiptLine(""))
            lines.add(ReceiptLine(""))

            val bitmap = renderReceiptToBitmap(lines.map { Triple(it.text, it.align, it.bold) })
            printer.printBitmap(bitmap)
            printer.close()

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    // "Label                    ₹value" — full width ~32 chars
    private fun labelValue(label: String, value: String): String {
        val total = 32
        val gap = total - label.length - value.length
        val spaces = if (gap > 0) " ".repeat(gap) else "  "
        return "$label$spaces$value"
    }

    private fun renderReceiptToBitmap(
        lines: List<Triple<String, String, Boolean>>
    ): Bitmap {
        val textSize = 28f
        val lineSpacing = 10f
        val padding = 16

        val paint = Paint(Paint.ANTI_ALIAS_FLAG).apply {
            color = Color.BLACK
            this.textSize = textSize
            typeface = Typeface.DEFAULT
        }

        val fm = paint.fontMetrics
        val lineHeight = (fm.descent - fm.ascent + lineSpacing).toInt()
        val maxWidth = PRINT_WIDTH - (padding * 2)

        val preparedLines = mutableListOf<Triple<String, String, Boolean>>()

        for ((text, align, bold) in lines) {
            paint.typeface = if (bold) Typeface.DEFAULT_BOLD else Typeface.DEFAULT
            if (text.isBlank()) {
                preparedLines.add(Triple("", align, bold))
                continue
            }
            var currentLine = ""
            text.split(" ").forEach { word ->
                val testLine = if (currentLine.isEmpty()) word else "$currentLine $word"
                if (paint.measureText(testLine) <= maxWidth) {
                    currentLine = testLine
                } else {
                    if (currentLine.isNotEmpty()) preparedLines.add(Triple(currentLine, align, bold))
                    currentLine = word
                }
            }
            if (currentLine.isNotEmpty()) preparedLines.add(Triple(currentLine, align, bold))
        }

        val totalHeight = (preparedLines.size * lineHeight) + (padding * 2)
        val bitmap = Bitmap.createBitmap(PRINT_WIDTH, totalHeight, Bitmap.Config.ARGB_8888)
        val canvas = Canvas(bitmap)
        canvas.drawColor(Color.WHITE)

        var y = padding - fm.ascent

        for ((text, align, bold) in preparedLines) {
            paint.typeface = if (bold) Typeface.DEFAULT_BOLD else Typeface.DEFAULT
            paint.textAlign = when (align) {
                "center" -> Paint.Align.CENTER
                "right"  -> Paint.Align.RIGHT
                else     -> Paint.Align.LEFT
            }
            val x = when (align) {
                "center" -> PRINT_WIDTH / 2f
                "right"  -> (PRINT_WIDTH - padding).toFloat()
                else     -> padding.toFloat()
            }
            canvas.drawText(text, x, y, paint)
            y += lineHeight
        }

        return bitmap
    }
}