// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stock_manager/screens/stock/add_stock.dart';

// class StockScreen extends StatefulWidget {
//   const StockScreen({super.key});

//   @override
//   State<StockScreen> createState() => _StockScreenState();
// }

// class _StockScreenState extends State<StockScreen> {
//   List<Map<String, dynamic>> addedStocks = [

//   ];
//   // DateTime? fromDate;
//   // DateTime? toDate;

//   DateTime fromDate = DateTime.now();
//   DateTime toDate = DateTime.now();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         title: Text('Stock',style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),),
//       ),
//       body: Column(
//         children: [
//           Row(
//             children: [
//               Padding(
//                   padding: const EdgeInsets.all(15),
//                   child: InkWell(
//                     onTap: () async {
//                       final result = await Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => const AddStock()),
//                       );
//                       if (result != null && result is List<Map<String, dynamic>>) {
//                         setState(() {
//                           addedStocks.addAll(result);
//                         });
//                       }
//                     },
//                     child: Container(
//                       padding: EdgeInsets.all(8),
//                       width: 100.w,
//                       alignment: Alignment.center,
//                       decoration: BoxDecoration(
//                         color: Colors.green,
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                       child: Text(
//                         "Add Stock",
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 15.sp,
//                             fontWeight: FontWeight.w500),
//                       ),
//                     ),
//                   ),
//                 ),
//             ],
//           ),
//           SizedBox(height: 10.h,),
//           Row(
//           children: [
//             // Padding(
//             //   padding: const EdgeInsets.all(15),
//             //   child: InkWell(
//             //     onTap: () async {
//             //       final result = await Navigator.push(
//             //         context,
//             //         MaterialPageRoute(builder: (context) => const AddStock()),
//             //       );
//             //       if (result != null && result is List<Map<String, dynamic>>) {
//             //         setState(() {
//             //           addedStocks.addAll(result);
//             //         });
//             //       }
//             //     },
//             //     child: Container(
//             //       padding: EdgeInsets.all(8),
//             //       width: 100.w,
//             //       alignment: Alignment.center,
//             //       decoration: BoxDecoration(
//             //         color: Colors.green,
//             //         borderRadius: BorderRadius.circular(8),
//             //       ),
//             //       child: Text(
//             //         "Add Stock",
//             //         style: TextStyle(
//             //             color: Colors.white,
//             //             fontSize: 15.sp,
//             //             fontWeight: FontWeight.w500),
//             //       ),
//             //     ),
//             //   ),
//             // ),

//             /// ✅ THIS FIXES YOUR ERROR
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 10),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: InkWell(
//                         onTap: () async {
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: fromDate ?? DateTime.now(),
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
//                           child: Text(
//                             fromDate == null
//                                 ? "From"
//                                 : "${fromDate!.day}-${fromDate!.month}-${fromDate!.year}",
//                           ),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(width: 8),
//                     Expanded(
//                       child: InkWell(
//                         onTap: () async {
//                           final picked = await showDatePicker(
//                             context: context,
//                             initialDate: toDate ?? DateTime.now(),
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
//                           child: Text(
//                             toDate == null
//                                 ? "To"
//                                 : "${toDate!.day}-${toDate!.month}-${toDate!.year}",
//                           ),
//                         ),
//                       ),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.clear),
//                       onPressed: () {
//                         setState(() {
//                           fromDate = null;
//                           toDate = null;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//           10.verticalSpace,
//            if (addedStocks.isNotEmpty) ...[
//               20.verticalSpace,
//               Text(
//                 'Added Stocks',
//                   style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
//                       ),
//                       10.verticalSpace,
//                       ListView.builder(
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                         itemCount: addedStocks.length,
//                         itemBuilder: (context, index) {
//                           final stock = addedStocks[index];
//                           return Padding(
//                             padding: const EdgeInsets.all(15),
//                             child: Container(
//                               margin: const EdgeInsets.only(bottom: 10),
//                               padding: const EdgeInsets.all(10),
//                               decoration: BoxDecoration(
//                                 border: Border.all(color: Colors.grey),
//                                 borderRadius: BorderRadius.circular(8),
//                               ),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Row(
//                                     children: [
//                                       Text('Product: ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
//                                       Text('${stock['product']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 5,),
//                                   Row(
//                                     children: [
//                                       Text('Supplier: ',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
//                                       Text('${stock['supplier']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
//                                     ],
//                                   ),
//                                   const SizedBox(height: 5,),
//                                   Text('${stock['category']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
//                                   const SizedBox(height: 5,),
//                                   Text('${stock['unit']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
//                                   const SizedBox(height: 5,),
//                                   Text('Qty: ${stock['qty']}  |  Rate: ${stock['rate']}',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.w500),),
//                                 ],
//                               ),
//                             ),
//                           );
//                         },
//                       ),
//                     ],
//         ],
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_manager/screens/stock/add_stock.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  List<Map<String, dynamic>> addedStocks = [];

  // ✅ Default = Today
  DateTime fromDate = DateTime.now();
  DateTime toDate = DateTime.now();

  String formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}-"
        "${date.month.toString().padLeft(2, '0')}-"
        "${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    // ✅ FILTER LOGIC
    List<Map<String, dynamic>> filteredStocks = addedStocks.where((stock) {
      final stockDate = stock['date'] as DateTime;

      return !stockDate.isBefore(
              DateTime(fromDate.year, fromDate.month, fromDate.day)) &&
          !stockDate.isAfter(
              DateTime(toDate.year, toDate.month, toDate.day, 23, 59, 59));
    }).toList();

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
          /// ✅ TOP SECTION (Button + Date Filter)
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                /// Add Stock Button
                Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () async {
                      final result = await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddStock(),
                        ),
                      );

                      if (result != null &&
                          result is List<Map<String, dynamic>>) {
                        setState(() {
                          addedStocks.addAll(result);
                        });
                      }
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

                10.verticalSpace,

                /// ✅ DATE FILTER ROW
                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: fromDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            setState(() {
                              fromDate = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("From: ${formatDate(fromDate)}"),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () async {
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: toDate,
                            firstDate: DateTime(2020),
                            lastDate: DateTime(2100),
                          );

                          if (picked != null) {
                            setState(() {
                              toDate = picked;
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text("To: ${formatDate(toDate)}"),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        setState(() {
                          fromDate = DateTime.now();
                          toDate = DateTime.now();
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),

          /// ✅ STOCK LIST
          if (filteredStocks.isNotEmpty) ...[
            Text(
              'Added Stocks',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            10.verticalSpace,
            Expanded(
              child: ListView.builder(
                itemCount: filteredStocks.length,
                itemBuilder: (context, index) {
                  final stock = filteredStocks[index];

                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      // child: Column(
                      //   crossAxisAlignment: CrossAxisAlignment.start,
                      //   children: [
                      //     Text("Product: ${stock['product']}"),
                      //     Text("Supplier: ${stock['supplier']}"),
                      //     Text("Category: ${stock['category']}"),
                      //     Text("Unit: ${stock['unit']}"),
                      //     Text(
                      //         "Qty: ${stock['qty']} | Rate: ${stock['rate']}"),
                      //     Text(
                      //         "Date: ${formatDate(stock['date'] as DateTime)}"),
                      //   ],
                      // ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                'Product: ',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${stock['product']}',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Supplier: ',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${stock['supplier']}',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Category: ',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${stock['category']}',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              Text(
                                'Unit: ',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${stock['unit']}',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Qty: ${stock['qty']}  |  Rate: ${stock['rate']}',
                            style: TextStyle(
                                fontSize: 15.sp, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ] else ...[
            const Expanded(
              child: Center(
                child: Text("No stocks available"),
              ),
            )
          ]
        ],
      ),
    );
  }
}
