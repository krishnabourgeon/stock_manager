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

    // Thermal paper print width in pixels (576 for 80mm, 384 for 58mm)
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
println("Shop: $discountValue")
println("Shop: $discountLabel")
  println("$subTotal....")
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

    // Checks if a string contains any characters outside the ASCII range
    // (Malayalam, Arabic, Devanagari, etc. all fall outside ASCII)
    private fun hasNonAscii(text: String): Boolean {
        return text.any { it.code > 127 }
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
        discountValue: Double,
        discountLabel: String,
        subTotal: Double,
    ) {
        try {
            val printer = POSTerminal.getInstance(this)
                .getDevice("cloudpos.device.printer") as PrinterDevice

            printer.open()

            // Collect receipt as a list of lines for bitmap rendering
            // Each entry: Pair(text, alignment) where alignment is "left"/"center"/"right"
            // or Pair("---DIVIDER---", "") for separator lines
            data class ReceiptLine(val text: String, val align: String = "left", val bold: Boolean = false)

            val lines = mutableListOf<ReceiptLine>()

            if (shop.isNotEmpty()) {
    lines.add(
        ReceiptLine(
            shop.trim(),
            "center",
            bold = true
        )
    )
}
            if (address.isNotEmpty()) lines.add(ReceiptLine(address, "center"))
            if (address2.isNotEmpty()) lines.add(ReceiptLine(address2, "center"))

            lines.add(ReceiptLine("--------------------------------", "center"))

            if (bill != 0) {
                lines.add(ReceiptLine("Bill No : $bill", "left"))
                lines.add(ReceiptLine(billdate, "right"))
            } else {
                lines.add(ReceiptLine(billdate, "right"))
            }
            lines.add(ReceiptLine(billtime, "right"))

            for (item in items) {
                val type = item["type"]?.toString()
                val name = item["name"].toString()
                val qty = (item["qty"] as? Number)?.toInt()
                    ?: item["qty"]?.toString()?.toIntOrNull() ?: 0
                val rate = (item["rate"] as? Number)?.toInt()
                    ?: item["rate"]?.toString()?.toIntOrNull() ?: 0
                val unit = item["unit"] as? String

                val lineText = buildItemLine(type, name, qty, rate, unit)
                lines.add(ReceiptLine(lineText, "left"))
                lines.add(ReceiptLine("", "left")) // blank line between items
            }

            lines.add(ReceiptLine("--------------------------------", "center"))

            if (discountValue > 0 && subTotal > 0) {
                println("successs....")
                lines.add(ReceiptLine("Sub Total         Rs %.2f".format(subTotal), "left"))
                lines.add(ReceiptLine("$discountLabel", "left"))
                 lines.add(ReceiptLine("Disc.Amt     Rs %.2f".format(discountValue), "left"))
                
            }else{
                  println("fail...$discountValue..$subTotal")
            }
            if (cgst > 0) lines.add(ReceiptLine("CGST              Rs %.2f".format(cgst), "left"))
            if (sgst > 0) lines.add(ReceiptLine("SGST              Rs %.2f".format(sgst), "left"))
            if (gst > 0) lines.add(ReceiptLine("GST Total         Rs %.2f".format(gst), "left"))

            lines.add(ReceiptLine("--------------------------------", "center"))

            if (mode.isNotEmpty() && mode != "null") {
                lines.add(ReceiptLine("Mode: $mode", "left"))
            }
            if (total != 0) {
                lines.add(ReceiptLine("TOTAL: Rs $total", "right", bold = true))
                lines.add(ReceiptLine("--------------------------------", "center"))
            }
            lines.add(ReceiptLine("THANK YOU", "center", bold = true))
            lines.add(ReceiptLine(""))
            lines.add(ReceiptLine(""))

            // Render all lines to a single bitmap so Unicode (Malayalam etc.) prints correctly
            val bitmap = renderReceiptToBitmap(lines.map { Triple(it.text, it.align, it.bold) })
            printer.printBitmap(bitmap)
            printer.close()

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    private fun buildItemLine(type: Any?, name: String, qty: Int, rate: Any?, unit: String?): String {
        return if (type == "" || type == null || type == "null") {
            if (rate == 0 || rate == "0") {
                if (unit != null && unit != "null" && unit != "") "$name $qty$unit"
                else "$name $qty"
            } else {
                "$name $qty x $rate"
            }
        } else {
            "  $name $qty x $rate"
        }
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

    // First pass: wrap all lines and calculate height
    val preparedLines = mutableListOf<Triple<String, String, Boolean>>()

    for ((text, align, bold) in lines) {

        paint.typeface =
            if (bold) Typeface.DEFAULT_BOLD
            else Typeface.DEFAULT

        if (text.isBlank()) {
            preparedLines.add(Triple("", align, bold))
            continue
        }

        var currentLine = ""

        text.split(" ").forEach { word ->

            val testLine =
                if (currentLine.isEmpty()) word
                else "$currentLine $word"

            if (paint.measureText(testLine) <= maxWidth) {
                currentLine = testLine
            } else {

                if (currentLine.isNotEmpty()) {
                    preparedLines.add(
                        Triple(currentLine, align, bold)
                    )
                }

                currentLine = word
            }
        }

        if (currentLine.isNotEmpty()) {
            preparedLines.add(
                Triple(currentLine, align, bold)
            )
        }
    }

    val totalHeight =
        (preparedLines.size * lineHeight) + (padding * 2)

    val bitmap = Bitmap.createBitmap(
        PRINT_WIDTH,
        totalHeight,
        Bitmap.Config.ARGB_8888
    )

    val canvas = Canvas(bitmap)
    canvas.drawColor(Color.WHITE)

    var y = padding - fm.ascent

    for ((text, align, bold) in preparedLines) {

        paint.typeface =
            if (bold) Typeface.DEFAULT_BOLD
            else Typeface.DEFAULT

      paint.textAlign = when (align) {
    "center" -> Paint.Align.CENTER
    "right" -> Paint.Align.RIGHT
    else -> Paint.Align.LEFT
}

val x = when (align) {
    "center" -> PRINT_WIDTH / 2f
    "right" -> (PRINT_WIDTH - padding).toFloat()
    else -> padding.toFloat()
}

canvas.drawText(text, x, y, paint)

        y += lineHeight
    }

    return bitmap
}
}
