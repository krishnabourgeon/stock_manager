// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/models/supplier_model.dart';
// import 'package:stock_manager/providers/stock_provider.dart';
// import 'package:stock_manager/screens/stock/add_stock.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';
// import 'package:stock_manager/services/shared_preference_helper.dart';

// class StockScreen extends StatefulWidget {
//   const StockScreen({super.key});

//   @override
//   State<StockScreen> createState() => _StockScreenState();
// }

// class _StockScreenState extends State<StockScreen> {

//   int? selectedSupplierId; // supplier filter

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) async {
//       await SharedPreferenceHelper.getStoreID();
//       if (mounted) {
//         context.read<StockProvider>().getStockList();
//         context.read<StockProvider>().getSuppliers();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final stockProvider = context.watch<StockProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text(
//           'Stock',
//           style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
//         ),
//       ),

//       body: Column(
//         children: [

//           /// 🔹 ADD STOCK BUTTON
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: InkWell(
//                 onTap: () async {
//                   await Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const AddStock(),
//                     ),
//                   );

//                   context.read<StockProvider>().getStockList();
//                 },
//                 child: Container(
//                   padding: EdgeInsets.all(10),
//                   width: 120.w,
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: Colors.green,
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Text(
//                     "Add Stock",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 15.sp,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),

//           /// 🔹 DOWNLOAD PDF
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             child: Align(
//               alignment: Alignment.centerRight,
//               child: ElevatedButton(
//                 onPressed: () {
//                   generatePdf(context.read<StockProvider>());
//                 },
//                 child: const Text("Download PDF"),
//               ),
//             ),
//           ),

//           /// 🔹 FILTER + TABLE
//           Expanded(
//             child: Column(
//               children: [

//                 /// 🔹 DATE FILTER
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: InkWell(
//                           onTap: () async {
//                             final date = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2020),
//                               lastDate: DateTime(2100),
//                             );
//                             if (date != null) {
//                               stockProvider.setFromDate(date);
//                             }
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               stockProvider.fromDate == null
//                                   ? "From Date"
//                                   : stockProvider.formatDate(stockProvider.fromDate!),
//                             ),
//                           ),
//                         ),
//                       ),

//                       SizedBox(width: 10.w),

//                       Expanded(
//                         child: InkWell(
//                           onTap: () async {
//                             final date = await showDatePicker(
//                               context: context,
//                               initialDate: DateTime.now(),
//                               firstDate: DateTime(2020),
//                               lastDate: DateTime(2100),
//                             );
//                             if (date != null) {
//                               stockProvider.setToDate(date);
//                             }
//                           },
//                           child: Container(
//                             padding: const EdgeInsets.all(12),
//                             decoration: BoxDecoration(
//                               color: Colors.grey[200],
//                               borderRadius: BorderRadius.circular(8),
//                             ),
//                             child: Text(
//                               stockProvider.toDate == null
//                                   ? "To Date"
//                                   : stockProvider.formatDate(stockProvider.toDate!),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),

//                 /// 🔹 SUPPLIER FILTER
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   child: DropdownButtonFormField<int>(
//                     decoration: InputDecoration(
//                       labelText: "Select Supplier",
//                       border: const OutlineInputBorder(),

//                       prefixIcon: stockProvider.loaderState == LoaderState.loading
//                           ? const Padding(
//                               padding: EdgeInsets.all(12.0),
//                               child: SizedBox(
//                                 width: 20,
//                                 height: 20,
//                                 child: CircularProgressIndicator(strokeWidth: 2),
//                               ),
//                             )
//                           : null,
//                     ),

//                     value: stockProvider.supplierList
//                             .any((e) => e.id == selectedSupplierId)
//                         ? selectedSupplierId
//                         : null,

//                     items: stockProvider.supplierList.isEmpty
//                         ? const [
//                             DropdownMenuItem<int>(
//                               value: null,
//                               child: Text("No suppliers available"),
//                             )
//                           ]
//                         : stockProvider.supplierList
//                             .fold<List<Data>>([], (prev, item) {
//                               if (!prev.any((e) => e.id == item.id)) {
//                                 prev.add(item);
//                               }
//                               return prev;
//                             })
//                             .map((item) => DropdownMenuItem<int>(
//                                   value: item.id,
//                                   child: Text(item.name ?? ''),
//                                 ))
//                             .toList(),

//                     onChanged: (value) {
//                       setState(() {
//                         selectedSupplierId = value;
//                       });

//                       print("Selected Supplier ID: $value");
//                     },
//                   ),
//                 ),

//                 /// 🔹 APPLY BUTTON (UI ONLY)
//                 // Padding(
//                 //   padding: const EdgeInsets.symmetric(horizontal: 16),
//                 //   child: ElevatedButton(
//                 //     onPressed: () {
//                 //       print("Apply Filter:");
//                 //       print("Supplier: $selectedSupplierId");
//                 //       print("From: ${stockProvider.fromDate}");
//                 //       print("To: ${stockProvider.toDate}");
//                 //     },
//                 //     child: const Text("Apply Filter"),
//                 //   ),
//                 // ),

//                 SizedBox(height: 10.h),

//                 /// 🔹 TABLE
//                 Expanded(
//                   child: Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 16.w),
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         border: TableBorder.all(color: Colors.grey),
//                         columnSpacing: 100,
//                         headingRowColor:
//                             MaterialStateProperty.all(Colors.green),
//                         columns: const [
//                           DataColumn(
//                             label: Text("Product",
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                           DataColumn(
//                             label: Text("Total",
//                                 style: TextStyle(color: Colors.white)),
//                           ),
//                         ],
//                         rows: stockProvider.stockList.map((stock) {
//                           return DataRow(cells: [
//                             DataCell(Text(stock.name ?? '')),
//                             DataCell(Text(stock.total.toString())),
//                           ]);
//                         }).toList(),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   /// 🔹 PDF GENERATION
//   Future<void> generatePdf(StockProvider stockProvider) async {
//     final pdf = pw.Document();

//     pdf.addPage(
//       pw.Page(
//         build: (context) {
//           return pw.Column(
//             children: [
//               pw.Text("Stock Report",
//                   style: pw.TextStyle(
//                       fontSize: 18, fontWeight: pw.FontWeight.bold)),
//               pw.SizedBox(height: 10),
//               pw.Table(
//                 border: pw.TableBorder.all(),
//                 children: [
//                   pw.TableRow(
//                     children: [
//                       pw.Text("Product"),
//                       pw.Text("Total"),
//                     ],
//                   ),
//                   ...stockProvider.stockList.map((stock) {
//                     return pw.TableRow(children: [
//                       pw.Text(stock.name ?? ''),
//                       pw.Text(stock.total.toString()),
//                     ]);
//                   })
//                 ],
//               ),
//             ],
//           );
//         },
//       ),
//     );

//     await Printing.layoutPdf(
//       onLayout: (format) async => pdf.save(),
//     );
//   }
// }

import 'dart:io';
import 'package:share_plus/share_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/screens/stock/add_stock.dart';
import 'package:stock_manager/screens/stock/purchase_details_screen.dart';
import 'package:stock_manager/screens/stock/view_stock.dart';
import 'package:stock_manager/services/provider_helper_class.dart';
import 'package:stock_manager/services/shared_preference_helper.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  int? selectedSupplierId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await SharedPreferenceHelper.getStoreID();

      if (mounted) {
        final provider = context.read<StockProvider>();
        provider.getStockList(); // 🔹 initial load
        provider.getSuppliers(); // 🔹 supplier list
      }
    });
  }

  ///  COMMON METHOD (AUTO FILTER)
  void fetchStock() {
    final provider = context.read<StockProvider>();

    if (selectedSupplierId == null &&
        provider.fromDate == null &&
        provider.toDate == null) {
      provider.getStockList(); // no filter
    } else {
      provider.getStockList(
        fromDate: provider.fromDate != null
            ? provider.formatDate(provider.fromDate!)
            : null,
        toDate: provider.toDate != null
            ? provider.formatDate(provider.toDate!)
            : null,
        supplierId: selectedSupplierId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final stockProvider = context.watch<StockProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Stock',
          style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
        ),
      ),
      body: Column(
        children: [
          /// 🔹 ADD STOCK
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ViewStock(),
                        ),
                      );
                      context.read<StockProvider>().getStockList();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 120.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "View Purchase",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddStock(),
                        ),
                      );
                      context.read<StockProvider>().getStockList();
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 120.w,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "Add Purchase",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {
                  generatePdf(context.read<StockProvider>());
                },
                child: const Text("Download  Report"),
              ),
            ),
          ),

          /// 🔹 DATE FILTER
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            child: Row(
              children: [
                /// FROM DATE
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );

                      if (date != null) {
                        stockProvider.setFromDate(date);
                        fetchStock(); //  AUTO FILTER
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        stockProvider.fromDate == null
                            ? "From Date"
                            : stockProvider.formatDate(stockProvider.fromDate!),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 10.w),

                /// TO DATE
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      final date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2100),
                      );

                      if (date != null) {
                        stockProvider.setToDate(date);
                        fetchStock(); // AUTO FILTER
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        stockProvider.toDate == null
                            ? "To Date"
                            : stockProvider.formatDate(stockProvider.toDate!),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // /// 🔹 SUPPLIER FILTER
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16),
          //   child: DropdownButtonFormField<int>(
          //     decoration: const InputDecoration(
          //       labelText: "Select Supplier",
          //       border: OutlineInputBorder(),
          //     ),
          //     value: stockProvider.supplierList
          //             .any((e) => e.id == selectedSupplierId)
          //         ? selectedSupplierId
          //         : null,
          //     items: stockProvider.supplierList.map((item) {
          //       return DropdownMenuItem<int>(
          //         value: item.id,
          //         child: Text(item.name ?? ''),
          //       );
          //     }).toList(),
          //     onChanged: (value) {
          //       setState(() {
          //         selectedSupplierId = value;
          //       });

          //       fetchStock(); //  AUTO FILTER
          //     },
          //   ),
          // ),

          SizedBox(height: 10.h),

          /// 🔹 TABLE
          Expanded(
            child: stockProvider.loaderState == LoaderState.loading
                ? const Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
                      border: TableBorder.all(color: Colors.grey),
                      columnSpacing: 70,
                      headingRowColor: MaterialStateProperty.all(Colors.green),
                      columns: const [
                        DataColumn(
                          label: SizedBox(
                            width: 30,
                            child: Text("Sl No",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 40,
                            child: Text("Code",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: Text("Product",
                              style: TextStyle(color: Colors.white)),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 30,
                            child: Text("Total",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 30,
                            child: Text("Unit",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                        DataColumn(
                          label: SizedBox(
                            width: 30,
                            child: Text("Action",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ],
                      rows:
                          stockProvider.stockList.asMap().entries.map((entry) {
                        int index = entry.key;
                        var stock = entry.value;
                        return DataRow(cells: [
                          DataCell(Text((index + 1).toString())),
                          DataCell(Text(stock.code)),
                          DataCell(Text(stock.name)),
                          DataCell(Text(stock.total.toString())),
                          DataCell(Text(stock.unitName)),
                          DataCell(InkWell(
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
                              child: Text(
                                "View",
                                style: TextStyle(color: Colors.blue),
                              )))
                        ]);
                      }).toList(),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  /// 🔹 PDF GENERATION
  Future<void> generatePdf(StockProvider stockProvider) async {
    final pdf = pw.Document();

    // 🔹 Get selected supplier name
    // String supplierName = "All";
    // if (selectedSupplierId != null) {
    //   final supplier = stockProvider.supplierList.firstWhere(
    //     (e) => e.id == selectedSupplierId,
    //     orElse: () => stockProvider.supplierList.first,
    //   );
    //   supplierName = supplier.name ?? "All";
    // }

    // // 🔹 Format dates
    // String fromDate = stockProvider.fromDate != null
    //     ? stockProvider.formatDate(stockProvider.fromDate!)
    //     : "All";

    // String toDate = stockProvider.toDate != null
    //     ? stockProvider.formatDate(stockProvider.toDate!)
    //     : "All";

    final temple = stockProvider.viewStockModel?.temple;

    pdf.addPage(
      pw.Page(
        build: (context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              /// 🔹 TITLE
              pw.Text(
                "Report",
                style: pw.TextStyle(
                  fontSize: 18,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),

              pw.SizedBox(height: 10),

              pw.SizedBox(height: 10),
              pw.Text("Name: ${temple?.name}(${temple?.nameMal})",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.normal)),
              pw.SizedBox(height: 10),
              pw.Text(
                  "Address: ${temple?.addressLine1},${temple?.addressLine2}",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.normal)),
              pw.SizedBox(height: 10),
              pw.Text("Phone: ${temple?.phone}",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.normal)),
              pw.SizedBox(height: 10),
              pw.Text("Email: ${temple?.email}",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.normal)),
              pw.SizedBox(height: 10),
              pw.Text("Website: ${temple?.website}",
                  style: pw.TextStyle(
                      fontSize: 18, fontWeight: pw.FontWeight.normal)),
              pw.SizedBox(height: 10),
              pw.SizedBox(height: 15),

              /// 🔹 FILTER DETAILS (NEW )
              // pw.Text("Name: $supplierName"),
              // pw.Text("From Date: $fromDate"),
              // pw.Text("To Date: $toDate"),

              pw.SizedBox(height: 15),

              /// 🔹 TABLE
              pw.Table(
                border: pw.TableBorder.all(),
                columnWidths: {
                  0: const pw.FlexColumnWidth(0.5), // Sl No
                  1: const pw.FlexColumnWidth(1), // Code
                  2: const pw.FlexColumnWidth(2.5), // Product
                  3: const pw.FlexColumnWidth(1), // Total
                  4: const pw.FlexColumnWidth(1), // Unit
                },
                children: [
                  /// HEADER
                  pw.TableRow(
                    decoration: pw.BoxDecoration(
                      color: PdfColors.green,
                    ),
                    children: [
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          "Sl No",
                          style: pw.TextStyle(color: PdfColors.white),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          "Code",
                          style: pw.TextStyle(color: PdfColors.white),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          "Product",
                          style: pw.TextStyle(color: PdfColors.white),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          "Total",
                          style: pw.TextStyle(color: PdfColors.white),
                        ),
                      ),
                      pw.Padding(
                        padding: const pw.EdgeInsets.all(8),
                        child: pw.Text(
                          "Unit",
                          style: pw.TextStyle(color: PdfColors.white),
                        ),
                      ),
                    ],
                  ),

                  /// DATA
                  ...stockProvider.stockList.asMap().entries.map((entry) {
                    int index = entry.key;
                    var stock = entry.value;
                    return pw.TableRow(
                      children: [
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text((index + 1).toString()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(stock.code ?? ''),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(stock.name ?? ''),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(stock.total.toString()),
                        ),
                        pw.Padding(
                          padding: const pw.EdgeInsets.all(8),
                          child: pw.Text(stock.unitName),
                        ),
                      ],
                    );
                  }).toList(),
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

// // inside your _StockScreenState class
// Future<void> generatePdf(StockProvider stockProvider) async {
//   final pdf = pw.Document();
//   final temple = stockProvider.viewStockModel?.temple;

//   String supplierName = "All";
//   if (selectedSupplierId != null) {
//     final supplier = stockProvider.supplierList.firstWhere(
//       (e) => e.id == selectedSupplierId,
//       orElse: () => stockProvider.supplierList.first,
//     );
//     supplierName = supplier.name ?? "All";
//   }

//   pdf.addPage(
//     pw.Page(
//       build: (context) {
//         return pw.Column(
//           crossAxisAlignment: pw.CrossAxisAlignment.start,
//           children: [
//             pw.Text("Stock Report",
//                 style: pw.TextStyle(
//                     fontSize: 18, fontWeight: pw.FontWeight.bold)),
//             pw.SizedBox(height: 10),
//             pw.Text("Name: ${temple?.name}(${temple?.nameMal})",
//                 style: pw.TextStyle(
//                     fontSize: 18, fontWeight: pw.FontWeight.normal)),
//                     pw.SizedBox(height: 10),
//              pw.Text("Address: ${temple?.addressLine1},${temple?.addressLine2}",
//                 style: pw.TextStyle(
//                     fontSize: 18, fontWeight: pw.FontWeight.normal)),
//                     pw.SizedBox(height: 10),
//              pw.Text("Phone: ${temple?.phone}",
//                 style: pw.TextStyle(
//                     fontSize: 18, fontWeight: pw.FontWeight.normal)),
//                     pw.SizedBox(height: 10),
//              pw.Text("Email: ${temple?.email}",
//                 style: pw.TextStyle(
//                     fontSize: 18, fontWeight: pw.FontWeight.normal)),
//                     pw.SizedBox(height: 10),
//                      pw.Text("Website: ${temple?.website}",
//                 style: pw.TextStyle(
//                     fontSize: 18, fontWeight: pw.FontWeight.normal)),
//                     pw.SizedBox(height: 10),
//             pw.SizedBox(height: 15),
//             pw.Table(
//               border: pw.TableBorder.all(),
//               columnWidths: {
//                 0: const pw.FlexColumnWidth(2),
//                 1: const pw.FlexColumnWidth(1),
//               },
//               children: [
//                 pw.TableRow(
//                   decoration: pw.BoxDecoration(color: PdfColors.green),
//                   children: [
//                     pw.Padding(
//                         padding: const pw.EdgeInsets.all(8),
//                         child: pw.Text("Product",
//                             style: pw.TextStyle(color: PdfColors.white))),
//                     pw.Padding(
//                         padding: const pw.EdgeInsets.all(8),
//                         child: pw.Text("Total",
//                             style: pw.TextStyle(color: PdfColors.white))),
//                   ],
//                 ),
//                 ...stockProvider.stockList.map((stock) {
//                   return pw.TableRow(children: [
//                     pw.Padding(
//                         padding: const pw.EdgeInsets.all(8),
//                         child: pw.Text(stock.name ?? '')),
//                     pw.Padding(
//                         padding: const pw.EdgeInsets.all(8),
//                         child: pw.Text(stock.total.toString())),
//                   ]);
//                 }).toList()
//               ],
//             ),
//           ],
//         );
//       },
//     ),
//   );

//   // 🔹 Request permission for storage
//   //if (await Permission.storage.request().isGranted) {
//     // 🔹 Save file
//     // final dir = await getExternalStorageDirectory();
//     // final path = '${dir!.path}/stock_report_${DateTime.now().millisecondsSinceEpoch}.pdf';
//     // final file = File(path);
//     // await file.writeAsBytes(await pdf.save());
//     final dir = Directory('/storage/emulated/0/Download');

// final path =
//     '${dir.path}/stock_report_${DateTime.now().millisecondsSinceEpoch}.pdf';

// final file = File(path);
// await file.writeAsBytes(await pdf.save());
//     // 🔹 Share via WhatsApp (or other apps)
//     //await Share.shareFiles([file.path], text: "Here is the stock report PDF");
//     await Share.shareXFiles(
//       [XFile(file.path)],
//       text: "Here is the stock report PDF",
//     );

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("PDF saved and ready to share!")),
//     );
//   // } else {
//   //   ScaffoldMessenger.of(context).showSnackBar(
//   //     SnackBar(content: Text("Storage permission denied")),
//   //   );
//   // }
// }
}
