// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';

// // class ViewProduct extends StatelessWidget {
// //   const ViewProduct({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title:const Text("View Product",style: TextStyle(color: Colors.white),),
// //         centerTitle: true,
// //         backgroundColor: Colors.green,
// //       ),
// //       body: Padding(
// //                   padding: EdgeInsets.all(10.w),
// //                   child: SingleChildScrollView(
// //                     scrollDirection: Axis.vertical,
// //                     child: SingleChildScrollView(
// //                       scrollDirection: Axis.horizontal,
// //                       child: DataTable(
// //                         headingRowColor: WidgetStateProperty.all(Colors.green),
// //                         headingTextStyle: TextStyle(
// //                           color: Colors.white,
// //                           fontWeight: FontWeight.bold,
// //                           fontSize: 14.sp,
// //                         ),
// //                         columnSpacing: 25.w,
// //                         border: TableBorder.all(color: Colors.grey.shade200),
// //                         columns: const [
// //                           DataColumn(label: Text('Sl.No')),
// //                           DataColumn(label: Text('Code')),
// //                           DataColumn(label: Text('Date')),
// //                           DataColumn(label: Text('Product Name')),
// //                           DataColumn(label: Text('Category')),
// //                           DataColumn(label: Text('Unit')),
// //                           DataColumn(label: Text('Rate')),
// //                         ],
// //                         rows: provider.viewProductStockList
// //                             .asMap()
// //                             .entries
// //                             .map((entry) {
// //                           final index = entry.key;
// //                           final item = entry.value;
// //                           final bool isIn =
// //                               item.mode.toLowerCase().contains("in");
// //                           return DataRow(
// //                             color: WidgetStateProperty.all(index % 2 != 0
// //                                 ? Colors.grey.shade50
// //                                 : Colors.white),
// //                             cells: [
// //                               DataCell(Text((index + 1).toString())),
// //                               DataCell(Text(item.productCode)),
// //                             DataCell(Text(
// //                                 DateFormat('dd-MM-yyyy').format(item.addedDate))),
// //                             DataCell(Text(item.invoiceNo)),
// //                             DataCell(
// //                               Container(
// //                                 padding: EdgeInsets.symmetric(
// //                                     horizontal: 8.w, vertical: 4.h),
// //                                 decoration: BoxDecoration(
// //                                   color: isIn
// //                                       ? Colors.green.withOpacity(0.1)
// //                                       : Colors.red.withOpacity(0.1),
// //                                   borderRadius: BorderRadius.circular(4),
// //                                 ),
// //                                 child: Text(
// //                                   item.mode,
// //                                   style: TextStyle(
// //                                     color: isIn ? Colors.green : Colors.red,
// //                                     fontWeight: FontWeight.bold,
// //                                   ),
// //                                 ),
// //                               ),
// //                             ),
// //                             // DataCell(Text(
// //                             //   isIn ? "${item.qty}" : "-",
// //                             //   style: TextStyle(
// //                             //       color: isIn ? Colors.green : Colors.black,
// //                             //       fontWeight: isIn ? FontWeight.bold : null),
// //                             // )),
// //                             DataCell(Text(
// //                               !isIn ? "${item.qty}" : "-",
// //                               style: TextStyle(
// //                                   color: !isIn ? Colors.red : Colors.black,
// //                                   fontWeight: !isIn ? FontWeight.bold : null),
// //                             )),
// //                             DataCell(Text("${item.salesRate ?? '0'}")),
// //                           ],
// //                         );
// //                       }
// //                       ).toList(),
// //                     ),
// //                   ),
// //                 ),
// //               ),
// //     );
// //   }
// // }




// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';

// class ViewProduct extends StatelessWidget {
//   const ViewProduct({super.key});

//   @override
//   Widget build(BuildContext context) {

//     /// 🔹 DUMMY DATA (Replace later with API)
//     final List<Map<String, dynamic>> productList = [
//       {
//         "code": "P001",
//         "date": DateTime.now(),
//         "name": "Rice",
//         "category": "Grocery",
//         "unit": "Kg",
//         "rate": 50,
//       },
//       {
//         "code": "P002",
//         "date": DateTime.now(),
//         "name": "Shirt",
//         "category": "Clothing",
//         "unit": "Nos",
//         "rate": 800,
//       },
//       {
//         "code": "P003",
//         "date": DateTime.now(),
//         "name": "Mobile",
//         "category": "Electronics",
//         "unit": "Nos",
//         "rate": 15000,
//       },
//     ];

//     return Scaffold(
//       appBar: AppBar(
//         title: const Text(
//           "View Product",
//           style: TextStyle(color: Colors.white),
//         ),
//         centerTitle: true,
//         backgroundColor: Colors.green,
//       ),

//       body: Padding(
//         padding: EdgeInsets.all(10.w),
//         child: SingleChildScrollView(
//           scrollDirection: Axis.vertical,
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,

//             /// 🔹 DATA TABLE
//             child: DataTable(
//               headingRowColor:
//                   MaterialStateProperty.all(Colors.green),
//               headingTextStyle: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 14.sp,
//               ),
//               columnSpacing: 25.w,
//               border: TableBorder.all(color: Colors.grey.shade200),

//               columns: const [
//                 DataColumn(label: Text('Sl.No')),
//                 DataColumn(label: Text('Code')),
//                 DataColumn(label: Text('Date')),
//                 DataColumn(label: Text('Product Name')),
//                 DataColumn(label: Text('Category')),
//                 DataColumn(label: Text('Unit')),
//                 DataColumn(label: Text('Rate')),
//               ],

//               rows: productList.asMap().entries.map((entry) {
//                 final index = entry.key;
//                 final item = entry.value;

//                 return DataRow(
//                   color: MaterialStateProperty.all(
//                     index % 2 != 0
//                         ? Colors.grey.shade50
//                         : Colors.white,
//                   ),
//                   cells: [
//                     DataCell(Text((index + 1).toString())),
//                     DataCell(Text(item['code'])),

//                     DataCell(Text(
//                       DateFormat('dd-MM-yyyy')
//                           .format(item['date']),
//                     )),

//                     DataCell(Text(item['name'])),
//                     DataCell(Text(item['category'])),
//                     DataCell(Text(item['unit'])),
//                     DataCell(Text(item['rate'].toString())),
//                   ],
//                 );
//               }).toList(),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  void initState() {
    super.initState();

    /// 🔹 CALL API
    Future.microtask(() {
      Provider.of<StockProvider>(context, listen: false)
          .getAllProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "View Product",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),

      body: Padding(
        padding: EdgeInsets.all(10.w),

        /// 🔹 CONSUMER
        child: Consumer<StockProvider>(
          builder: (context, provider, child) {
            final productList = provider.allProductList;

            /// 🔹 LOADING
            if (provider.loaderState == LoaderState.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            /// 🔹 EMPTY STATE
            if (productList.isEmpty) {
              return const Center(child: Text("No Products Found"));
            }

            /// 🔹 DATA TABLE
            return SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  headingRowColor:
                      MaterialStateProperty.all(Colors.green),

                  headingTextStyle: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                  ),

                  columnSpacing: 25.w,
                  border:
                      TableBorder.all(color: Colors.grey.shade200),

                  columns: const [
                    DataColumn(label: Text('Sl.No')),
                    DataColumn(label: Text('Code')),
                    DataColumn(label: Text('Date')),
                    DataColumn(label: Text('Product Name')),
                    DataColumn(label: Text('Category')),
                    DataColumn(label: Text('Unit')),
                    DataColumn(label: Text('Rate')),
                  ],

                  rows: productList.asMap().entries.map((entry) {
                    final index = entry.key;
                    final item = entry.value;

                    return DataRow(
                      color: MaterialStateProperty.all(
                        index % 2 != 0
                            ? Colors.grey.shade50
                            : Colors.white,
                      ),
                      cells: [
                        /// 🔹 SL NO
                        DataCell(Text((index + 1).toString())),

                        /// 🔹 CODE
                        DataCell(Text(item.code.toString())),

                        /// 🔹 DATE
                        DataCell(Text(
                          DateFormat('dd-MM-yyyy')
                              .format(item.created),
                        )),

                        /// 🔹 NAME
                        DataCell(Text(item.name)),

                        /// 🔹 CATEGORY (ID for now)
                        DataCell(Text(item.catname.toString())),

                        /// 🔹 UNIT (ID for now)
                        DataCell(Text(item.unit.toString())),

                        /// 🔹 PRICE
                        DataCell(Text(item.price)),
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}