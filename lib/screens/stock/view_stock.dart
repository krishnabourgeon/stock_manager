// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/providers/stock_provider.dart';

// class ViewStock extends StatefulWidget {
//   const ViewStock({super.key});

//   @override
//   State<ViewStock> createState() => _ViewStockState();
// }

// class _ViewStockState extends State<ViewStock> {
//   @override
//   void initState() {
//     super.initState();

//     Future.microtask(() {
//       final provider = context.read<StockProvider>();
//       provider.getViewPurchases();
//       provider.resetPurchaseSelection(); //  Clear old selections
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<StockProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: const Text(
//           "Purchase List",
//           style: TextStyle(fontWeight: FontWeight.bold),
//         ),
//         centerTitle: true,
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           children: [

//             // ///  SUPPLIER DROPDOWN
//             // DropdownButtonFormField<int>(
//             //   value: provider.selectedSupplierId,
//             //   decoration: InputDecoration(
//             //     labelText: "Select Supplier",
//             //     border: OutlineInputBorder(
//             //       borderRadius: BorderRadius.circular(12),
//             //     ),
//             //   ),
//             //   items: provider.supplierIds.map((id) {
//             //     return DropdownMenuItem(
//             //       value: id,
//             //       child: Text(purchase.),
//             //     );
//             //   }).toList(),
//             //   onChanged: (value) {
//             //     provider.setSupplier(value);
//             //   },
//             // ),

//             DropdownButtonFormField<int>(
//               value: provider.selectedSupplierId,
//               decoration: InputDecoration(
//                 labelText: "Select Supplier",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),

//               items: provider.uniqueSuppliers.map((supplier) {
//                 return DropdownMenuItem<int>(
//                   value: supplier.id,
//                   child: Text(supplier.name ?? "Unknown"),
//                 );
//               }).toList(),

//               onChanged: (value) {
//                 provider.setSupplier(value);
//               },
//             ),

//             const SizedBox(height: 16),

//             ///  INVOICE DROPDOWN
//             DropdownButtonFormField<int>(
//               value: provider.selectedPurchaseId,
//               decoration: InputDecoration(
//                 labelText: "Select Invoice",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               items: provider.filteredInvoices.map((purchase) {
//                 return DropdownMenuItem(
//                   value: purchase.id,
//                   child: Text(purchase.invoiceNo ?? ""),
//                 );
//               }).toList(),
//               onChanged: (value) {
//                 final selectedPurchase = provider.filteredInvoices
//                     .firstWhere((e) => e.id == value);

//                 provider.setInvoice(selectedPurchase);
//               },
//             ),

//             const SizedBox(height: 16),

//             ///  INVOICE DATE
//             TextFormField(
//               readOnly: true,
//               decoration: InputDecoration(
//                 labelText: "Invoice Date",
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//               ),
//               controller: TextEditingController(
//                 text: provider.selectedInvoiceDate != null
//                     ? provider.formatDate(provider.selectedInvoiceDate!)
//                     : "",
//               ),
//             ),

//             const SizedBox(height: 20),

//             ///  PURCHASE DETAILS LIST
//             Expanded(
//               child: provider.purchasedetailList.isEmpty
//                   ? const Center(child: Text("No Data"))
//                   : ListView.builder(
//                       itemCount: provider.purchasedetailList.length,
//                       itemBuilder: (context, index) {
//                         final item = provider.purchasedetailList[index];

//                         return Container(
//                           margin: const EdgeInsets.only(bottom: 12),
//                           padding: const EdgeInsets.all(12),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(12),
//                             border: Border.all(color: Colors.grey.shade300),
//                           ),
//                           child: Row(
//                             children: [

//                               /// DETAILS
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "Code : ${item.product?.code ?? '1'}",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     Text(
//                                       "Product : ${item.product?.name ?? 'Unknown'}",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     const SizedBox(height: 4),
//                                     Text("Qty: ${item.qty}"),
//                                     const SizedBox(height: 4),
//                                     Text("Total: ${item.subTot}"),
//                                   ],
//                                 ),
//                               ),

//                               // /// DELETE
//                               // IconButton(
//                               //   onPressed: () {
//                               //     provider.purchasedetailList
//                               //         .removeAt(index);
//                               //     provider.notifyListeners();
//                               //   },
//                               //   icon: const Icon(
//                               //     Icons.delete,
//                               //     color: Colors.red,
//                               //   ),
//                               // )
//                               // IconButton(
//                               //   onPressed: () {
//                               //     final provider = context.read<StockProvider>();
//                               //     final item = provider.purchasedetailList[index];

//                               //     provider.deletePurchaseItem(
//                               //       id: item.id.toString(), //  important
//                               //       index: index,
//                               //     );
//                               //   },
//                               //   icon: const Icon(
//                               //     Icons.delete,
//                               //     color: Colors.red,
//                               //   ),
//                               // ),
//                               IconButton(
//                                 onPressed: () {
//                                   showDialog(
//                                     context: context,
//                                     builder: (context) => AlertDialog(
//                                       title: const Text("Delete Item"),
//                                       content: const Text(
//                                           "Are you sure you want to delete this item?"),
//                                       actions: [
//                                         TextButton(
//                                           onPressed: () =>
//                                               Navigator.pop(context),
//                                           child: const Text("Cancel"),
//                                         ),
//                                         TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                             final provider =
//                                                 context.read<StockProvider>();
//                                             final item = provider
//                                                 .purchasedetailList[index];

//                                             provider.deletePurchaseItem(
//                                               id: item.id.toString(),
//                                               productId:
//                                                   item.productId.toString(),
//                                               index: index,
//                                             );
//                                           },
//                                           style: TextButton.styleFrom(
//                                               foregroundColor: Colors.red),
//                                           child: const Text("Delete"),
//                                         ),
//                                       ],
//                                     ),
//                                   );
//                                 },
//                                 icon: const Icon(
//                                   Icons.delete,
//                                   color: Colors.red,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         );
//                       },
//                     ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/screens/stock/purchase_details_screen.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class ViewStock extends StatefulWidget {
  const ViewStock({super.key});

  @override
  State<ViewStock> createState() => _ViewStockState();
}

class _ViewStockState extends State<ViewStock> {

  @override
  void initState() {
    super.initState();

    ///  LOAD DATA
    Future.microtask(() {
      context.read<StockProvider>().getStockList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = context.watch<StockProvider>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("View Stock",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: Column(
        children: [
          
          ///  PDF BUTTON
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      generatePdf(stockProvider);
                    },
                    child: const Text("Download Report"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      printStockReport(stockProvider);
                    },
                    child: const Text("Print Report"),
                  ),
                ),
              ),
            ],
          ),

          ///  TABLE
          Expanded(
            child: stockProvider.loaderState == LoaderState.loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: Colors.grey),
                      headingRowColor:
                          MaterialStateProperty.all(Colors.green),

                      columns: const [
                        DataColumn(label: Text("Sl No", style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text("Code", style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text("Product", style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text("Total", style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text("Unit", style: TextStyle(color: Colors.white))),
                        DataColumn(label: Text("Action", style: TextStyle(color: Colors.white))),
                      ],

                      rows: stockProvider.stockList
                          .asMap()
                          .entries
                          .map((entry) {

                        int index = entry.key;
                        var stock = entry.value;

                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(stock.code)),
                          DataCell(Text(stock.name)),
                          DataCell(Text(stock.total.toString())),
                          DataCell(Text(stock.unitName)),

                          ///  VIEW DETAILS
                          DataCell(
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        PurchaseDetailsScreen(
                                      productId: stock.id.toString(),
                                      productName: stock.name,
                                    ),
                                  ),
                                );
                              },
                              child: const Text(
                                "View",
                                style: TextStyle(color: Colors.blue),
                              ),
                            ),
                          ),
                        ]);
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  ///  PDF GENERATION
  Future<void> generatePdf(StockProvider stockProvider) async {
    final pdf = pw.Document();

    final temple = stockProvider.viewStockModel?.temple;

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [

              pw.Text("Stock Report",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.bold)),

              pw.SizedBox(height: 10),

              pw.Text("Name: ${temple?.name} (${temple?.nameMal})"),
              pw.Text("Phone: ${temple?.phone}"),
              pw.Text("Email: ${temple?.email}"),

              pw.SizedBox(height: 20),

              ///  TABLE
              pw.Table(
                border: pw.TableBorder.all(),
                children: [

                  /// HEADER
                  pw.TableRow(
                    decoration: const pw.BoxDecoration(
                      color: PdfColors.green,
                    ),
                    children: [
                      cell("Sl No", isHeader: true),
                      cell("Code", isHeader: true),
                      cell("Product", isHeader: true),
                      cell("Total", isHeader: true),
                      cell("Unit", isHeader: true),
                    ],
                  ),

                  /// DATA
                  ...stockProvider.stockList
                      .asMap()
                      .entries
                      .map((entry) {

                    int index = entry.key;
                    var stock = entry.value;

                    return pw.TableRow(children: [
                      cell((index + 1).toString()),
                      cell(stock.code),
                      cell(stock.name),
                      cell(stock.total.toString()),
                      cell(stock.unitName),
                    ]);
                  }),
                ],
              ),
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => pdf.save(),
    );
  }

  pw.Widget cell(String text, {bool isHeader = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.all(8),
      child: pw.Text(
        text,
        style: pw.TextStyle(
          color: isHeader ? PdfColors.white : PdfColors.black,
        ),
      ),
    );
  }


static const platform = MethodChannel('cloudpos/printer');
Future<void> printStockReport(StockProvider stockProvider) async {
  try {
    DateTime dateTime = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(dateTime);
    String formattedTime = DateFormat('hh:mm a').format(dateTime);

    /// 🔹 Convert stock list to items
    List<Map<String, dynamic>> itemsList =
        stockProvider.stockList.map((e) {
      return {
        "type": null,
        "name": e.name,
        "code": e.code,
        "total": e.total,
        "unit": e.unitName,
      };
    }).toList();

    await platform.invokeMethod('printReceipt', {
      ///  HEADER
      "shop": stockProvider.viewStockModel?.temple.name,
      "shopaddress": stockProvider.viewStockModel?.temple.addressLine1,
      "shopaddress2": stockProvider.viewStockModel?.temple.addressLine2,

      ///  FULL LIST
      "items": itemsList,

      ///  EXT
      "totalItems": stockProvider.stockList.length,

      "billdate": formattedDate,
      "billtime": formattedTime,
      "mode": null,
      "bill": null,
    });
  } catch (e) {
    print("Print Error: $e");
  }
}
}