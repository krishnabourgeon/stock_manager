// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:stock_manager/screens/stock/add_stock.dart';

// // class StockScreen extends StatefulWidget {
// //   const StockScreen({super.key});

// //   @override
// //   State<StockScreen> createState() => _StockScreenState();
// // }

// // class _StockScreenState extends State<StockScreen> {
// //   List<Map<String, dynamic>> addedStocks = [

// //   ];
// //   // DateTime? fromDate;
// //   // DateTime? toDate;

// //   DateTime fromDate = DateTime.now();
// //   DateTime toDate = DateTime.now();
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         centerTitle: true,
// //         title: Text('Stock',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),),
// //       ),
// //       body: Column(
// //         children: [
// //           Row(
// //             children: [
// //               Padding(
// //                   padding: const EdgeInsets.all(15),
// //                   child: InkWell(
// //                     onTap: () async {
// //                       final result = await Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => const AddStock()),
// //                       );
// //                       if (result != null && result is List<Map<String, dynamic>>) {
// //                         setState(() {
// //                           addedStocks.addAll(result);
// //                         });
// //                       }
// //                     },
// //                     child: Container(
// //                       padding: EdgeInsets.all(8),
// //                       width: 100.w,
// //                       alignment: Alignment.center,
// //                       decoration: BoxDecoration(
// //                         color: Colors.green,
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                       child: Text(
// //                         "Add Stock",
// //                         style: TextStyle(
// //                             color: Colors.white,
// //                             fontSize: 15.sp,
// //                             fontWeight: FontWeight.w500),
// //                       ),
// //                     ),
// //                   ),
// //                 ),
// //             ],
// //           ),
// //           SizedBox(height: 10.h,),
// //           Row(
// //           children: [
// //             // Padding(
// //             //   padding: const EdgeInsets.all(15),
// //             //   child: InkWell(
// //             //     onTap: () async {
// //             //       final result = await Navigator.push(
// //             //         context,
// //             //         MaterialPageRoute(builder: (context) => const AddStock()),
// //             //       );
// //             //       if (result != null && result is List<Map<String, dynamic>>) {
// //             //         setState(() {
// //             //           addedStocks.addAll(result);
// //             //         });
// //             //       }
// //             //     },
// //             //     child: Container(
// //             //       padding: EdgeInsets.all(8),
// //             //       width: 100.w,
// //             //       alignment: Alignment.center,
// //             //       decoration: BoxDecoration(
// //             //         color: Colors.green,
// //             //         borderRadius: BorderRadius.circular(8),
// //             //       ),
// //             //       child: Text(
// //             //         "Add Stock",
// //             //         style: TextStyle(
// //             //             color: Colors.white,
// //             //             fontSize: 15.sp,
// //             //             fontWeight: FontWeight.w500),
// //             //       ),
// //             //     ),
// //             //   ),
// //             // ),

// //             /// ✅ THIS FIXES YOUR ERROR
// //             Expanded(
// //               child: Padding(
// //                 padding: const EdgeInsets.symmetric(horizontal: 10),
// //                 child: Row(
// //                   children: [
// //                     Expanded(
// //                       child: InkWell(
// //                         onTap: () async {
// //                           final picked = await showDatePicker(
// //                             context: context,
// //                             initialDate: fromDate ?? DateTime.now(),
// //                             firstDate: DateTime(2020),
// //                             lastDate: DateTime(2100),
// //                           );

// //                           if (picked != null) {
// //                             setState(() {
// //                               fromDate = picked;
// //                             });
// //                           }
// //                         },
// //                         child: Container(
// //                           padding: const EdgeInsets.all(10),
// //                           decoration: BoxDecoration(
// //                             border: Border.all(color: Colors.grey),
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                           child: Text(
// //                             fromDate == null
// //                                 ? "From"
// //                                 : "${fromDate!.day}-${fromDate!.month}-${fromDate!.year}",
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     const SizedBox(width: 8),
// //                     Expanded(
// //                       child: InkWell(
// //                         onTap: () async {
// //                           final picked = await showDatePicker(
// //                             context: context,
// //                             initialDate: toDate ?? DateTime.now(),
// //                             firstDate: DateTime(2020),
// //                             lastDate: DateTime(2100),
// //                           );

// //                           if (picked != null) {
// //                             setState(() {
// //                               toDate = picked;
// //                             });
// //                           }
// //                         },
// //                         child: Container(
// //                           padding: const EdgeInsets.all(10),
// //                           decoration: BoxDecoration(
// //                             border: Border.all(color: Colors.grey),
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                           child: Text(
// //                             toDate == null
// //                                 ? "To"
// //                                 : "${toDate!.day}-${toDate!.month}-${toDate!.year}",
// //                           ),
// //                         ),
// //                       ),
// //                     ),
// //                     IconButton(
// //                       icon: const Icon(Icons.clear),
// //                       onPressed: () {
// //                         setState(() {
// //                           fromDate = null;
// //                           toDate = null;
// //                         });
// //                       },
// //                     )
// //                   ],
// //                 ),
// //               ),
// //             ),
// //           ],
// //         ),
// //           10.verticalSpace,
// //            if (addedStocks.isNotEmpty) ...[
// //               20.verticalSpace,
// //               Text(
// //                 'Added Stocks',
// //                   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
// //                       ),
// //                       10.verticalSpace,
// //                       ListView.builder(
// //                         shrinkWrap: true,
// //                         physics: const NeverScrollableScrollPhysics(),
// //                         itemCount: addedStocks.length,
// //                         itemBuilder: (context, index) {
// //                           final stock = addedStocks[index];
// //                           return Padding(
// //                             padding: const EdgeInsets.all(15),
// //                             child: Container(
// //                               margin: const EdgeInsets.only(bottom: 10),
// //                               padding: const EdgeInsets.all(10),
// //                               decoration: BoxDecoration(
// //                                 border: Border.all(color: Colors.grey),
// //                                 borderRadius: BorderRadius.circular(8),
// //                               ),
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   Row(
// //                                     children: [
// //                                       Text('Product: ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
// //                                       Text('${stock['product']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
// //                                     ],
// //                                   ),
// //                                   const SizedBox(height: 5,),
// //                                   Row(
// //                                     children: [
// //                                       Text('Supplier: ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
// //                                       Text('${stock['supplier']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
// //                                     ],
// //                                   ),
// //                                   const SizedBox(height: 5,),
// //                                   Text('${stock['category']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
// //                                   const SizedBox(height: 5,),
// //                                   Text('${stock['unit']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
// //                                   const SizedBox(height: 5,),
// //                                   Text('Qty: ${stock['qty']}  |  Rate: ${stock['rate']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
// //                                 ],
// //                               ),
// //                             ),
// //                           );
// //                         },
// //                       ),
// //                     ],
// //         ],
// //       ),
// //     );
// //   }
// // }

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stock_manager/screens/stock/add_stock.dart';

// class StockScreen extends StatefulWidget {
//   const StockScreen({super.key});

//   @override
//   State<StockScreen> createState() => _StockScreenState();
// }

// class _StockScreenState extends State<StockScreen> {
//   List<Map<String, dynamic>> addedStocks = [];

//   // ✅ Default = Today
//   DateTime fromDate = DateTime.now();
//   DateTime toDate = DateTime.now();

//   String formatDate(DateTime date) {
//     return "${date.day.toString().padLeft(2, '0')}-"
//         "${date.month.toString().padLeft(2, '0')}-"
//         "${date.year}";
//   }

//   @override
//   Widget build(BuildContext context) {
//     // ✅ FILTER LOGIC
//     List<Map<String, dynamic>> filteredStocks = addedStocks.where((stock) {
//       final stockDate = stock['date'] as DateTime;

//       return !stockDate.isBefore(
//               DateTime(fromDate.year, fromDate.month, fromDate.day)) &&
//           !stockDate.isAfter(
//               DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59));
//     }).toList();

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
//           /// ✅ TOP SECTION (Button + Date Filter)
//           Padding(
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               children: [
//                 /// Add Stock Button
//                 Align(
//                   alignment: Alignment.centerRight,
//                   child: InkWell(
//                     onTap: () async {
//                       final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const AddStock(),
//                         ),
//                       );

//                       if (result != null &&
//                           result is List<Map<String, dynamic>>) {
//                         setState(() {
//                           addedStocks.addAll(result);
//                         });
//                       }
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(10),
//                       width: 120.w,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         "Add Stock",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 15.sp,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),

//                 10.verticalSpace,

//                 /// ✅ DATE FILTER ROW
//                 Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         onTap: () async {
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: fromDate,
//                             firstDate: DateTime(2020),
//                             lastDate: DateTime(2100),
//                           );

//                           if (picked != null) {
//                             setState(() {
//                               fromDate = picked;
//                             });
//                           }
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text("From: ${formatDate(fromDate)}"),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     Expanded(
//                       child: InkWell(
//                         onTap: () async {
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: toDate,
//                             firstDate: DateTime(2020),
//                             lastDate: DateTime(2100),
//                           );

//                           if (picked != null) {
//                             setState(() {
//                               toDate = picked;
//                             });
//                           }
//                         },
//                         child: Container(
//                           padding: const EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(8),
//                           ),
//                           child: Text("To: ${formatDate(toDate)}"),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.refresh),
//                       onPressed: () {
//                         setState(() {
//                           fromDate = DateTime.now();
//                           toDate = DateTime.now();
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           /// ✅ STOCK LIST
//           if (filteredStocks.isNotEmpty) ...[
//             Text(
//               'Added Stocks',
//               style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//             ),
//             10.verticalSpace,
//             Expanded(
//               child: ListView.builder(
//                 itemCount: filteredStocks.length,
//                 itemBuilder: (context, index) {
//                   final stock = filteredStocks[index];

//                   return Padding(
//                     padding: const EdgeInsets.all(10),
//                     child: Container(
//                       padding: const EdgeInsets.all(10),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey),
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       // child: Column(
//                       //   crossAxisAlignment: CrossAxisAlignment.start,
//                       //   children: [
//                       //     Text("Product: ${stock['product']}"),
//                       //     Text("Supplier: ${stock['supplier']}"),
//                       //     Text("Category: ${stock['category']}"),
//                       //     Text("Unit: ${stock['unit']}"),
//                       //     Text(
//                       //         "Qty: ${stock['qty']} | Rate: ${stock['rate']}"),
//                       //     Text(
//                       //         "Date: ${formatDate(stock['date'] as DateTime)}"),
//                       //   ],
//                       // ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Row(
//                             children: [
//                               Text(
//                                 'Product: ',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '${stock['product']}',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Supplier: ',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '${stock['supplier']}',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Category: ',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '${stock['category']}',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Row(
//                             children: [
//                               Text(
//                                 'Unit: ',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 '${stock['unit']}',
//                                 style: TextStyle(
//                                     fontSize: 15.sp,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             'Qty: ${stock['qty']}  |  Rate: ${stock['rate']}',
//                             style: TextStyle(
//                                 fontSize: 15.sp, fontWeight: FontWeight.w500),
//                           ),
//                         ],
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           ] else ...[
//             const Expanded(
//               child: Center(
//                 child: Text("No stocks available"),
//               ),
//             )
//           ]
//         ],
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/screens/stock/add_stock.dart';
import 'package:stock_manager/services/provider_helper_class.dart';
import 'package:stock_manager/services/shared_preference_helper.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      // Ensure storeId is loaded from SharedPreferences before the API call
      await SharedPreferenceHelper.getStoreID();
      if (mounted) {
        context.read<StockProvider>().getStockList();
      }
    });
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

          ///  ADD STOCK BUTTON
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

                  //  Refresh after adding
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
                  child: Text(
                    "Add Stock",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
//           Padding(
//   padding: const EdgeInsets.symmetric(horizontal: 10),
//   child: Column(
//     children: [
//       ///  DATE FILTER
//       Row(
//         children: [
//           Expanded(
//             child: InkWell(
//               onTap: () async {
//                 final date = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2020),
//                   lastDate: DateTime(2100),
//                 );
//                 if (date != null) {
//                   stockProvider.setFromDate(date);
//                 }
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   stockProvider.fromDate == null
//                       ? "From Date"
//                       : stockProvider.formatDate(stockProvider.fromDate!),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Expanded(
//             child: InkWell(
//               onTap: () async {
//                 final date = await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2020),
//                   lastDate: DateTime(2100),
//                 );
//                 if (date != null) {
//                   stockProvider.setToDate(date);
//                 }
//               },
//               child: Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.grey),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: Text(
//                   stockProvider.toDate == null
//                       ? "To Date"
//                       : stockProvider.formatDate(stockProvider.toDate!),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),

//       SizedBox(height: 10.h),

//       /// 🔘 APPLY FILTER
//       Row(
//         children: [
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 stockProvider.applyFilters();
//               },
//               child: const Text("Apply Filter"),
//             ),
//           ),
//           SizedBox(width: 10.w),
//           Expanded(
//             child: ElevatedButton(
//               onPressed: () {
//                 stockProvider.clearFilters();
//               },
//               child: const Text("Clear"),
//             ),
//           ),
//         ],
//       ),
//     ],
//   ),
// ),
//           ///  LOADING
//           if (stockProvider.loaderState == LoaderState.loading)
//             const Expanded(
//               child: Center(child: CircularProgressIndicator()),
//             )

//           ///  STOCK LIST
//           else if (stockProvider.stockList.isNotEmpty)
//             Expanded(
//               child:
//               //  ListView.builder(
//               //   itemCount: stockProvider.stockList.length,
//               //   itemBuilder: (context, index) {
//               //     final stock = stockProvider.stockList[index];

//               //     return Padding(
//               //       padding: const EdgeInsets.all(20),
//               //       child: Container(
//               //         height: 100,
//               //         padding: const EdgeInsets.all(15),
//               //         decoration: BoxDecoration(
//               //           color: Colors.grey[200],
//               //           border: Border.all(color: Colors.grey),
//               //           borderRadius: BorderRadius.circular(8),
//               //         ),
//               //         child: Column(
//               //           crossAxisAlignment: CrossAxisAlignment.start,
//               //           children: [
//               //             Text("Product: ${stock.name}",
//               //                 style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18)),
//               //             Text("Total: ${stock.total}",style: TextStyle(fontSize: 15)),
//               //             // Text("Unit: ${stock.unit ?? ''}"),
//               //             // Text("Qty: ${stock.qty ?? ''}"),
//               //             // Text("Rate: ${stock.rate ?? ''}"),


//               //           ],
//               //         ),
//               //       ),
//               //     );
//               //   },
//               // ),

//               DataTable(
//                   columnSpacing: constraints.maxWidth / 2.7,
//                   decoration: BoxDecoration(color: ColorPalette.primaryColor),
//                   border: TableBorder.symmetric(
//                     outside: BorderSide(color: Colors.grey, width: .5.w),
//                   ),
//                   columns: const [
//                     DataColumn(
//                         label: Text(
//                       'Payment Mode',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                     DataColumn(
//                         label: Text(
//                       'Total',
//                       style: TextStyle(color: Colors.white),
//                     )),
//                   ],
//                   rows: List.generate(
//                       counterWiseSummaryProvider?.tempCounterWiseData.length ??
//                           0, (index) {
//                     return DataRow(
//                         color: index % 2 == 0
//                             ? MaterialStateProperty.all<Color>(Colors.white)
//                             : MaterialStateProperty.all<Color>(
//                                 Colors.grey.shade100),
//                         cells: [
//                           DataCell(Text(counterWiseSummaryProvider
//                                   ?.tempCounterWiseData[index].paymentMode ??
//                               '')),
//                           DataCell(Center(
//                             child: Text(
//                               counterWiseSummaryProvider
//                                       ?.tempCounterWiseData[index].totalAmount
//                                       .toString() ??
//                                   '0',
//                             ),
//                           )),
//                         ]);
//                   }),
//                 ),
//             )

            Stack(
  children: [
    /// 🔹 DATE PICKERS (TOP)
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

    /// 🔹 TABLE (LIKE YOUR SECOND DESIGN)
    Padding(
      padding: EdgeInsets.only(top: 70.h,left:30.w),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: 
        // DataTable(
        //   columnSpacing: 100,
        //   headingRowColor:
        //       MaterialStateProperty.all(Colors.green),
        //   columns: const [
        //     DataColumn(
        //       label: Text("Product",
        //           style: TextStyle(color: Colors.white)),
        //     ),
        //     DataColumn(
        //       label: Text("Total",
        //           style: TextStyle(color: Colors.white)),
        //     ),
        //   ],
        //   rows: stockProvider.stockList.map((stock) {
        //     return DataRow(cells: [
        //       DataCell(Text(stock.name ?? '')),
        //       DataCell(Text(stock.total.toString())),
        //     ]);
        //   }).toList(),
        // ),
        DataTable(
        border: TableBorder.all(
          color: Colors.grey,
          width: 1,
        ),
        columnSpacing: 100,
        headingRowColor: MaterialStateProperty.all(Colors.green),
        columns: const [
          DataColumn(
            label: Text("Product",
                style: TextStyle(color: Colors.white)),
          ),
          DataColumn(
            label: Text("Total",
                style: TextStyle(color: Colors.white)),
          ),
        ],
        rows: stockProvider.stockList.map((stock) {
          return DataRow(cells: [
            DataCell(Text(stock.name ?? '')),
            DataCell(Text(stock.total.toString())),
          ]);
        }).toList(),
      )
      ),
    ),
  ],
)

          // ///  EMPTY STATE
          // else
          //   const Expanded(
          //     child: Center(
          //       child: Text("No stocks available"),
          //     ),
          //   ),
        ],
      ),
    );
  }
}