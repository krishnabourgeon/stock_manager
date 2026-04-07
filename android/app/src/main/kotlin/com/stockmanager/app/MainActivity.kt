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
                            val bill = call.argument<Int>("bill") ?: 0
                             val total = call.argument<Int>("total") ?: 0
                            val billdate = call.argument<String>("billdate") ?: ""
                          val billtime = call.argument<String>("billtime") ?: ""
                             printReceipt(shop, shopaddress,shopaddress2, items, mode, bill, billdate,billtime,total)

                            result.success("Printed")

                        } catch (e: Exception) {
                            result.error("PRINT_ERROR", e.message, null)
                        }
                    }

                    else -> result.notImplemented()
                }
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
        total:Any,
       
    ) {
        try {
           
            val printer = POSTerminal.getInstance(this)
                .getDevice("cloudpos.device.printer") as PrinterDevice

            printer.open()

            val builder = StringBuilder()
    
            // ✅ CENTER SHOP NAME (manual)
            builder.append(centerText(shop))
 
            // ✅ CENTER ADDRESS
            builder.append(centerText(address))
             builder.append(centerText(address2))
           


            builder.append("--------------------------------\n")
            if (bill != null&&bill != 0  ) {
    builder.append(leftRightAlign("Bill No : $bill", "$billdate"));
} else {
    builder.append(rightAlign( "$billdate"));
}
             builder.append(rightAlign("$billtime\n"))
              

           
           for ((index, item) in items.withIndex()) {
            if (item["type"] != null&&  item["type"] != "null"&&item["type"] !="") {
    builder.append("${index + 1}. ${item["type"].toString()}\n");
} else {
    
}
                
                val name = item["name"].toString()
                val qty = (item["qty"] as? Number)?.toInt()
    ?: item["qty"]?.toString()?.toIntOrNull()
    ?: 0

val rate = (item["rate"] as? Number)?.toInt()
    ?: item["rate"]?.toString()?.toIntOrNull()
    ?: 0
   val unit = item["unit"] as? String

 

builder.append(formatItem(item["type"],name, qty, rate,unit))
            }

            builder.append("--------------------------------\n")

            
          if (mode != null&&mode != "null"&& mode!="" ) {
    builder.append(leftRightAlign("Mode: $mode", "TOTAL: Rs $total"));
} else {
    if(total==0){

    }else{
    builder.append(rightAlign("TOTAL: Rs $total\n"));}
}

if(total!=0){


            builder.append("--------------------------------\n")}
             builder.append(centerText("THANK YOU"))
           
            builder.append("\n\n")

            printer.printText(builder.toString())
            printer.printText("\n\n\n")
            printer.close()

        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    // 🔥 CENTER TEXT FUNCTION
    private fun centerText(text: String, width: Int = 32): String {
        val padding = (width - text.length) / 2
        return " ".repeat(if (padding > 0) padding else 0) + text + "\n"
    }

    // 🔥 RIGHT ALIGN FUNCTION
    private fun rightAlign(text: String, width: Int = 32): String {
        val padding = width - text.length
        return " ".repeat(if (padding > 0) padding else 0) + text
    }

    // 🔥 ITEM FORMAT  
    private fun formatItem(itemName: Any?, name: String, qty: Int, rate: Any?,unit:String?): String {

    return if (itemName ==""||itemName==null||itemName=="null") {
        if(rate==0||rate=="0"){
            if(unit!=null||unit!="null"||unit!=""){
            return  "$name $qty$unit\n\n"  
      }else{
         return  "$name $qty\n\n"
      }  }else{  
        "$name $qty x $rate\n\n"   // 👈 no leading spaces
   } } else {
        "   $name $qty x $rate\n\n" // 👈 with spaces
    }
}

//in row
    private fun leftRightAlign(left: String, right: String, width: Int = 32): String {
    val space = width - (left.length + right.length)
    return left + " ".repeat(if (space > 0) space else 1) + right + "\n"
}
 
}