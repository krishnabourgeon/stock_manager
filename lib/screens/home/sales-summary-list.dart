// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/common/color_palette.dart';
// import 'package:stock_manager/common/common_functions.dart';
// import 'package:stock_manager/common/date_picker.dart';
// import 'package:stock_manager/providers/pooja_summary_provider.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';

// class PoojaListTable extends StatefulWidget {
//   const PoojaListTable({Key? key}) : super(key: key);
//   @override
//   State<PoojaListTable> createState() => _PoojaListTableState();
// }

// class _PoojaListTableState extends State<PoojaListTable> {
//   PoojaSummaryProvider? poojaSummaryProvider;
//   @override
//   void initState() {
//     poojaSummaryProvider = PoojaSummaryProvider();
//     final DateFormat formatter = DateFormat('y-MM-dd');
//     poojaSummaryProvider?.updateFromDate(formatter.format(DateTime.now()));
//     poojaSummaryProvider?.updateToDate(formatter.format(DateTime.now()));
//     CommonFunctions.afterInit(() {
//       poojaSummaryProvider?.getPoojaSummary();
//     });
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0,
//         leading: Center(
//           child: InkWell(
//             onTap: (() => Navigator.pop(context)),
//             child: SizedBox(
//                 height: 25.h,
//                 width: 25.h,
//                 child: Image.asset("assets/image/backIcon.png")),
//           ),
//         ),
//         systemOverlayStyle: const SystemUiOverlayStyle(
//           statusBarColor: Colors.white,
//           statusBarIconBrightness: Brightness.dark,
//           statusBarBrightness: Brightness.light,
//         ),
//         title: const Text(
//           "Sales Summary List",
//           style: TextStyle(color: Colors.black),
//         ),
//         actions: [
//           Padding(
//               padding: const EdgeInsets.all(10),
//               child: IconButton(
//                   onPressed: () async {
//                     try {
//                       DateTime dateTime = DateTime.now();
//                       String formattedDate =
//                           DateFormat('dd-MM-yyyy').format(dateTime);
//                       String formattedTime =
//                           DateFormat('hh:mm a').format(dateTime);

//                       List<Map<String, dynamic>> itemsList =
//                           poojaSummaryProvider?.poojaSummaryResponse?.data
//                                   ?.asMap()
//                                   .entries
//                                   .map((entry) {
//                                 int index = entry.key;
//                                 var e = entry.value;

//                                 return {
//                                   "type": null,
//                                   "name": "${index + 1}. ${e.poojaName}",
//                                   "qty": e.poojaCount ?? 0,
//                                   "rate": e.totalRate ?? 0,
//                                 };
//                               }).toList() ??
//                               [];

//                       await platform.invokeMethod('printReceipt', {
//                         "shop": poojaSummaryProvider
//                             ?.poojaSummaryResponse?.temple?.name,
//                         "shopaddress": poojaSummaryProvider
//                             ?.poojaSummaryResponse?.temple?.addressLine1,
//                         "shopaddress2": poojaSummaryProvider
//                             ?.poojaSummaryResponse?.temple?.addressLine2,

//                         "items": itemsList, //  ALL ITEMS

//                         "total": int.parse(poojaSummaryProvider
//                             ?.poojaSummaryResponse?.grossTotal),

//                         "billdate": formattedDate,
//                         "billtime": formattedTime,
//                         "mode": null,
//                         "bill": null,
//                       });
//                     } catch (e) {
//                       print("Error: $e");
//                     }
//                   },
//                   icon: Icon(Icons.print))),
//         ],
//       ),
//       body: ChangeNotifierProvider.value(
//         value: poojaSummaryProvider,
//         child: Consumer<PoojaSummaryProvider>(
//             builder: (context, value, child) =>
//                 _switchView(poojaSummaryProvider)),
//       ),
//     );
//   }

//   static const platform = MethodChannel('cloudpos/printer');

//   _switchView(PoojaSummaryProvider? poojaSummaryProvider) {
//     Widget child = const SizedBox.shrink();
//     switch (poojaSummaryProvider?.loaderState) {
//       case LoaderState.initial:
//         break;
//       case LoaderState.loaded:
//         child = PageView.builder(
//             onPageChanged: (value) =>
//                 poojaSummaryProvider?.updateCurrentIndex(value),
//             physics: const NeverScrollableScrollPhysics(),
//             controller: poojaSummaryProvider?.pageController,
//             itemBuilder: (context, index) {
//               return _pageView(poojaSummaryProvider);
//             });
//         break;
//       case LoaderState.loading:
//         child = const LinearProgressIndicator();
//         break;
//       case LoaderState.error:
//         break;
//       case LoaderState.networkErr:
//         child = const Center(
//           child: Text('Network Error !'),
//         );
//         break;
//       case LoaderState.noData:
//         child = Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               child: Row(
//                 children: [
//                   Flexible(
//                     child: PunnyamDatePicker(
//                       isEndDate: true,
//                       isFirstDate: true,
//                       title: poojaSummaryProvider?.fromDate
//                               ?.split('-')
//                               .reversed
//                               .join('-') ??
//                           "From Date",
//                       onChanged: (date) => poojaSummaryProvider
//                         ?..updateFromDate(date)
//                         // ..updateCurrentIndex(0)
//                         ..getPoojaSummary(),
//                     ),
//                   ),
//                   5.horizontalSpace,
//                   Flexible(
//                     child: PunnyamDatePicker(
//                       isEndDate: true,
//                       isFirstDate: true,
//                       title: poojaSummaryProvider?.toDate
//                               ?.split('-')
//                               .reversed
//                               .join('-') ??
//                           "To Date",
//                       onChanged: (date) => poojaSummaryProvider
//                         ?..updateToDate(date)
//                         ..getPoojaSummary(),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             const Expanded(
//               child: Align(
//                 alignment: Alignment.center,
//                 child: Center(
//                   child: Text('No Data Found !'),
//                 ),
//               ),
//             )
//           ],
//         );
//         break;
//     }
//     return child;
//   }

//   _pageView(PoojaSummaryProvider? poojaSummaryProvider) {
//     return Stack(
//       children: [
//         Align(
//           alignment: Alignment.topCenter,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Row(
//               children: [
//                 Flexible(
//                   child: PunnyamDatePicker(
//                     isEndDate: true,
//                     isFirstDate: true,
//                     title: poojaSummaryProvider?.fromDate
//                             ?.split('-')
//                             .reversed
//                             .join('-') ??
//                         "From Date",
//                     onChanged: (date) => poojaSummaryProvider
//                       ?..updateFromDate(date)
//                       ..getPoojaSummary(),
//                   ),
//                 ),
//                 5.horizontalSpace,
//                 Flexible(
//                   child: PunnyamDatePicker(
//                     isEndDate: true,
//                     isFirstDate: true,
//                     title: poojaSummaryProvider?.toDate
//                             ?.split('-')
//                             .reversed
//                             .join('-') ??
//                         "To Date",
//                     onChanged: (date) => poojaSummaryProvider
//                       ?..updateToDate(date)
//                       ..updateCurrentIndex(0)
//                       ..getPoojaSummary(),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),

//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 60.h),
//           child: SingleChildScrollView(
//             scrollDirection: Axis.horizontal,
//             physics: const BouncingScrollPhysics(),
//             child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               physics: const BouncingScrollPhysics(),
//               child: DataTable(
//                 headingRowHeight: 45.h,
//                 dataRowMinHeight: 50.h,
//                 dataRowMaxHeight: 50.h,
//                 decoration: BoxDecoration(color: ColorPalette.primaryColor),
//                 border: TableBorder.symmetric(
//                   outside: BorderSide(color: Colors.grey, width: .5.w),
//                 ),
//                 // columnSpacing: 6,
//                 columns: const [
//                   DataColumn(
//                       label: Text(
//                     'Product Name',
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     'Product Count',
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   )),
//                   DataColumn(
//                       label: Text(
//                     'Total',
//                     style: TextStyle(color: Colors.white, fontSize: 12),
//                   )),
//                 ],
//                 rows: List.generate(
//                     poojaSummaryProvider?.poojaSummaryResponse?.data?.length ??
//                         0, (index) {
//                   // List<PoojaSummaryData>? element=poojaSummaryProvider?.tempPoojaDataList[poojaSummaryProvider.currentIndex??0];
//                   return DataRow(
//                       color: index % 2 == 0
//                           ? MaterialStateProperty.all<Color>(Colors.white)
//                           : MaterialStateProperty.all<Color>(
//                               Colors.grey.shade100),
//                       cells: [
//                         DataCell(SizedBox(
//                           width: 185.w,
//                           child: Text(
//                               poojaSummaryProvider?.poojaSummaryResponse
//                                       ?.data![index].poojaName ??
//                                   '',
//                               strutStyle: StrutStyle(height: 1.5.h)),
//                         )),
//                         DataCell(Center(
//                           child: Text(
//                               "${poojaSummaryProvider?.poojaSummaryResponse?.data![index].poojaCount ?? ''}"),
//                         )),
//                         DataCell(Center(
//                           child: Text(
//                               "${poojaSummaryProvider?.poojaSummaryResponse?.data![index].totalRate ?? ''}"),
//                         )),
//                       ]);
//                 }),
//               ),
//             ),
//           ),
//         ),
//         // Padding(
//         //   padding: EdgeInsets.only(bottom: 60.h, right: 10.w),
//         //   child: Align(
//         //     alignment: Alignment.bottomRight,
//         //     child: Row(
//         //       mainAxisAlignment: MainAxisAlignment.end,
//         //       children: [
//         //         FloatingActionButton(
//         //           heroTag: 1,
//         //           onPressed: () {
//         //             // print("count..${poojaSummaryProvider?.pageCount}");
//         //             if (poojaSummaryProvider?.currentIndex != 0 &&
//         //                 (!poojaSummaryProvider!.paginationLoader)) {
//         //               // print("frst");
//         //               // print("2nd");
//         //               poojaSummaryProvider.loadless().then((value) {
//         //                 poojaSummaryProvider.pageController.animateToPage(
//         //                     (poojaSummaryProvider.pageCount) - 1,
//         //                     duration: const Duration(milliseconds: 200),
//         //                     curve: Curves.easeIn);
//         //               });
//         //               if ((poojaSummaryProvider.tempPoojaDataList.length ?? 0) >
//         //                   1) {
//         //                 if (kDebugMode) {
//         //                   print("count...${poojaSummaryProvider.pageCount}");
//         //                 }
//         //               }
//         //             } else {
//         //               Helpers.successToast('There is no previous page');
//         //             }
//         //           },
//         //           child: (poojaSummaryProvider?.left ?? false)
//         //               ? SizedBox(
//         //                   height: 20.h,
//         //                   width: 20.w,
//         //                   child: CircularProgressIndicator(
//         //                     strokeWidth: 2.w,
//         //                     color: Colors.white,
//         //                   ),
//         //                 )
//         //               : Icon(
//         //                   Icons.arrow_left_outlined,
//         //                   size: 45.h,
//         //                 ),
//         //         ),
//         //         20.horizontalSpace,
//         //         FloatingActionButton(
//         //             heroTag: 2,
//         //             onPressed: () async {
//         //               // print("count...${poojaSummaryProvider?.pageCount}");
//         //               if ((poojaSummaryProvider?.currentIndex ?? 0) + 1 !=
//         //                       poojaSummaryProvider?.totalPageLength &&
//         //                   !(poojaSummaryProvider?.paginationLoader ?? false)) {
//         //                 // print("frst");
//         //                 poojaSummaryProvider
//         //                     ?.loadMorePoojaSummary()
//         //                     .then((value) {
//         //                   // print(
//         //                   //     "....${(poojaSummaryProvider.currentIndex) + 1}");
//         //                   // print("2nd");
//         //                   poojaSummaryProvider.pageController.animateToPage(
//         //                       (poojaSummaryProvider.currentIndex) + 1,
//         //                       duration: const Duration(milliseconds: 200),
//         //                       curve: Curves.easeIn);
//         //                 });
//         //               } else {
//         //                 Helpers.successToast('There is no next page');
//         //               }
//         //             },
//         //             child: (poojaSummaryProvider?.right ?? false)
//         //                 ? SizedBox(
//         //                     height: 20.h,
//         //                     width: 20.w,
//         //                     child: CircularProgressIndicator(
//         //                       strokeWidth: 2.w,
//         //                       color: Colors.white,
//         //                     ),
//         //                   )
//         //                 : Icon(
//         //                     Icons.arrow_right_outlined,
//         //                     size: 45.h,
//         //                   ))
//         //       ],
//         //     ),
//         //   ),
//         // ),
//         Align(
//           alignment: Alignment.bottomCenter,
//           child: Container(
//             color: Colors.green,
//             width: double.infinity,
//             height: 50.h,
//             padding: EdgeInsets.symmetric(horizontal: 20.w),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Text(
//                       'Gross Total :',
//                       style: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14.sp),
//                     ),
//                     10.horizontalSpace,
//                     Text(
//                         poojaSummaryProvider?.poojaSummaryResponse?.grossTotal
//                                 .toString() ??
//                             '0',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp)),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/common/color_palette.dart';
import 'package:stock_manager/common/common_functions.dart';
import 'package:stock_manager/common/date_picker.dart';
import 'package:stock_manager/providers/pooja_summary_provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class PoojaListTable extends StatefulWidget {
  const PoojaListTable({Key? key}) : super(key: key);

  @override
  State<PoojaListTable> createState() => _PoojaListTableState();
}

class _PoojaListTableState extends State<PoojaListTable> {
  PoojaSummaryProvider? poojaSummaryProvider;

  // ── Filter state ─────────────────────────────────────────────────────────
  int? _selectedCategoryId;
  String? _selectedCategoryName;

  int? _selectedProductId;
  String? _selectedProductName;

  // ── Helpers ───────────────────────────────────────────────────────────────
  void _onCategoryChanged(int? catId, String? catName, StockProvider sp) {
    setState(() {
      _selectedCategoryId = catId;
      _selectedCategoryName = catName;
      _selectedProductId = null;
      _selectedProductName = null;
    });
    if (catId != null) {
      sp.getProducts(categoryId: catId);
    }
    _refreshSummary();
  }

  void _onProductChanged(int? productId, String? productName) {
    setState(() {
      _selectedProductId = productId;
      _selectedProductName = productName;
    });
    _refreshSummary();
  }

  void _refreshSummary() {
    // Re-fetch summary — extend getPoojaSummary if you need to pass filters
    poojaSummaryProvider?.getPoojaSummary(
      categoryId: _selectedCategoryId,
      productId: _selectedProductId,
    );
  }

  void _clearAllFilters(StockProvider sp) {
    setState(() {
      _selectedCategoryId = null;
      _selectedCategoryName = null;
      _selectedProductId = null;
      _selectedProductName = null;
    });
    sp.getProducts(); // reload all products
    _refreshSummary();
  }

  // ── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    poojaSummaryProvider = PoojaSummaryProvider();
    final DateFormat formatter = DateFormat('y-MM-dd');
    poojaSummaryProvider?.updateFromDate(formatter.format(DateTime.now()));
    poojaSummaryProvider?.updateToDate(formatter.format(DateTime.now()));
    CommonFunctions.afterInit(() {
      poojaSummaryProvider?.getPoojaSummary();
      // Load categories and all products for dropdowns
      context.read<StockProvider>().getCategories();
      context.read<StockProvider>().getProducts();
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Center(
          child: InkWell(
            onTap: () => Navigator.pop(context),
            child: SizedBox(
              height: 25.h,
              width: 25.h,
              child: Image.asset("assets/image/backIcon.png"),
            ),
          ),
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: const Text(
          "Sales Summary List",
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: IconButton(
              onPressed: () async {
                try {
                  DateTime dateTime = DateTime.now();
                  String formattedDate =
                      DateFormat('dd-MM-yyyy').format(dateTime);
                  String formattedTime = DateFormat('hh:mm a').format(dateTime);

                  List<Map<String, dynamic>> itemsList = poojaSummaryProvider
                          ?.poojaSummaryResponse?.data
                          ?.asMap()
                          .entries
                          .map((entry) {
                        int index = entry.key;
                        var e = entry.value;
                        return {
                          "type": null,
                          "name": "${index + 1}. ${e.poojaName}",
                          "qty": e.poojaCount ?? 0,
                          "rate": e.totalRate ?? 0,
                        };
                      }).toList() ??
                      [];

                  await platform.invokeMethod('printReceipt', {
                    "shop": poojaSummaryProvider
                        ?.poojaSummaryResponse?.temple?.name,
                    "shopaddress": poojaSummaryProvider
                        ?.poojaSummaryResponse?.temple?.addressLine1,
                    "shopaddress2": poojaSummaryProvider
                        ?.poojaSummaryResponse?.temple?.addressLine2,
                    "items": itemsList,
                    "total": double.parse(poojaSummaryProvider
                            ?.poojaSummaryResponse?.grossTotal
                            .toString() ??
                        '0'),
                    "billdate": formattedDate,
                    "billtime": formattedTime,
                    "mode": null,
                    "bill": null,
                  });
                } catch (e) {
                  print("Error: $e");
                }
              },
              icon: const Icon(Icons.print),
            ),
          ),
        ],
      ),

      // ── Body ───────────────────────────────────────────────────────────────
      body: Consumer<StockProvider>(
        builder: (context, stockProvider, _) {
          return ChangeNotifierProvider.value(
            value: poojaSummaryProvider,
            child: Consumer<PoojaSummaryProvider>(
              builder: (context, value, child) => Column(
                children: [
                  // ── Category + Product filter row ──────────────────────
                  _FilterSection(
                    stockProvider: stockProvider,
                    selectedCategoryId: _selectedCategoryId,
                    selectedCategoryName: _selectedCategoryName,
                    selectedProductId: _selectedProductId,
                    selectedProductName: _selectedProductName,
                    onCategoryChanged: (id, name) =>
                        _onCategoryChanged(id, name, stockProvider),
                    onProductChanged: _onProductChanged,
                    onClear: () => _clearAllFilters(stockProvider),
                  ),

                  // ── Main content ───────────────────────────────────────
                  Expanded(
                    child: _switchView(poojaSummaryProvider, stockProvider),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  // ── Platform channel ──────────────────────────────────────────────────────
  static const platform = MethodChannel('cloudpos/printer');

  // ── Switch view (unchanged logic + date pickers) ──────────────────────────
  Widget _switchView(PoojaSummaryProvider? prov, StockProvider stockProvider) {
    switch (prov?.loaderState) {
      case LoaderState.loading:
        return const Center(
          child: CircularProgressIndicator(
            color: Colors.green,
          ),
        );

      case LoaderState.error:
        return const SizedBox.shrink();

      case LoaderState.networkErr:
        return const Center(child: Text('Network Error !'));

      case LoaderState.noData:
        return Column(
          children: [
            _DateFilterRow(poojaSummaryProvider: prov),
            const Expanded(
              child: Center(child: Text('No Data Found !')),
            ),
          ],
        );

      case LoaderState.loaded:
        return _pageView(prov);

      default:
        return const SizedBox.shrink();
    }
  }

  Widget _pageView(PoojaSummaryProvider? prov) {
    return Stack(
      children: [
        // Date pickers
        Align(
          alignment: Alignment.topCenter,
          child: _DateFilterRow(poojaSummaryProvider: prov),
        ),

        // Table
        Padding(
          padding:
              EdgeInsets.only(left: 15.w, right: 15.w, top: 65.h, bottom: 55.h),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              child: DataTable(
                headingRowHeight: 45.h,
                dataRowMinHeight: 50.h,
                dataRowMaxHeight: 50.h,
                decoration: BoxDecoration(color: ColorPalette.primaryColor),
                border: TableBorder.symmetric(
                  outside: BorderSide(color: Colors.grey, width: .5.w),
                ),
                columns: const [
                  DataColumn(
                      label: Text('Product Name',
                          style: TextStyle(color: Colors.white, fontSize: 12))),
                  DataColumn(
                      label: Text('Product Count',
                          style: TextStyle(color: Colors.white, fontSize: 12))),
                  DataColumn(
                      label: Text('Total',
                          style: TextStyle(color: Colors.white, fontSize: 12))),
                ],
                rows: List.generate(
                  prov?.poojaSummaryResponse?.data?.length ?? 0,
                  (index) => DataRow(
                    color: index % 2 == 0
                        ? MaterialStateProperty.all(Colors.white)
                        : MaterialStateProperty.all(Colors.grey.shade100),
                    cells: [
                      DataCell(SizedBox(
                        width: 185.w,
                        child: Text(
                          prov?.poojaSummaryResponse?.data![index].poojaName ??
                              '',
                          strutStyle: StrutStyle(height: 1.5.h),
                        ),
                      )),
                      DataCell(Center(
                          child: Text(
                              "${prov?.poojaSummaryResponse?.data![index].poojaCount ?? ''}"))),
                      DataCell(Center(
                          child: Text(
                              "${prov?.poojaSummaryResponse?.data![index].totalRate ?? ''}"))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),

        // Gross total bar
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            color: Colors.green,
            width: double.infinity,
            height: 50.h,
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Gross Total :',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
                10.horizontalSpace,
                Text(
                  prov?.poojaSummaryResponse?.grossTotal.toString() ?? '0',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.sp),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Filter Section Widget — Category + Product dropdowns
// ─────────────────────────────────────────────────────────────────────────────
class _FilterSection extends StatelessWidget {
  final StockProvider stockProvider;
  final int? selectedCategoryId;
  final String? selectedCategoryName;
  final int? selectedProductId;
  final String? selectedProductName;
  final void Function(int? id, String? name) onCategoryChanged;
  final void Function(int? id, String? name) onProductChanged;
  final VoidCallback onClear;

  const _FilterSection({
    required this.stockProvider,
    required this.selectedCategoryId,
    required this.selectedCategoryName,
    required this.selectedProductId,
    required this.selectedProductName,
    required this.onCategoryChanged,
    required this.onProductChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasFilter =
        selectedCategoryId != null || selectedProductId != null;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        border:
            Border(bottom: BorderSide(color: Colors.green.shade100, width: 1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Label row ──────────────────────────────────────────────────
          Row(
            children: [
              Icon(Icons.filter_list,
                  size: 16.sp, color: Colors.green.shade700),
              SizedBox(width: 4.w),
              Text(
                'Filter by Category & Product',
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.green.shade800,
                ),
              ),
              const Spacer(),
              if (hasFilter)
                GestureDetector(
                  onTap: onClear,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: Colors.red.shade50,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.red.shade200),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.close,
                            size: 12.sp, color: Colors.red.shade400),
                        SizedBox(width: 3.w),
                        Text('Clear',
                            style: TextStyle(
                                fontSize: 11.sp, color: Colors.red.shade400)),
                      ],
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),

          // ── Dropdown row ───────────────────────────────────────────────
          Row(
            children: [
              // Category dropdown
              Expanded(
                child: _StyledDropdown<int>(
                  hint: 'Select Category',
                  value: selectedCategoryId,
                  icon: Icons.category_outlined,
                  items: stockProvider.categoryList
                      .map((cat) => DropdownMenuItem<int>(
                            value: cat.id,
                            child: Text(
                              cat.name ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    final cat = stockProvider.categoryList.firstWhere(
                        (c) => c.id == val,
                        orElse: () => stockProvider.categoryList.first);
                    onCategoryChanged(val, cat.name);
                  },
                ),
              ),
              SizedBox(width: 10.w),

              // Product dropdown — enabled only after category selected
              Expanded(
                child: _StyledDropdown<int>(
                  hint: 'Select Product',
                  value: selectedProductId,
                  icon: Icons.inventory_2_outlined,
                  enabled: selectedCategoryId != null,
                  items: stockProvider.productList
                      .map((p) => DropdownMenuItem<int>(
                            value: p.id,
                            child: Text(
                              p.name ?? '',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ))
                      .toList(),
                  onChanged: (val) {
                    final prod = stockProvider.productList.firstWhere(
                        (p) => p.id == val,
                        orElse: () => stockProvider.productList.first);
                    onProductChanged(val, prod.name);
                  },
                ),
              ),
            ],
          ),

          // ── Active filter chips ────────────────────────────────────────
          if (hasFilter) ...[
            SizedBox(height: 6.h),
            Wrap(
              spacing: 6.w,
              children: [
                if (selectedCategoryName != null)
                  _FilterChip(
                      label: 'Category: $selectedCategoryName',
                      color: Colors.blue),
                if (selectedProductName != null)
                  _FilterChip(
                      label: 'Product: $selectedProductName',
                      color: Colors.orange),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Date filter row (extracted for reuse in both loaded + noData states)
// ─────────────────────────────────────────────────────────────────────────────
class _DateFilterRow extends StatelessWidget {
  final PoojaSummaryProvider? poojaSummaryProvider;

  const _DateFilterRow({required this.poojaSummaryProvider});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        children: [
          Flexible(
            child: PunnyamDatePicker(
              isEndDate: true,
              isFirstDate: true,
              title: poojaSummaryProvider?.fromDate
                      ?.split('-')
                      .reversed
                      .join('-') ??
                  "From Date",
              onChanged: (date) => poojaSummaryProvider
                ?..updateFromDate(date)
                ..getPoojaSummary(),
            ),
          ),
          5.horizontalSpace,
          Flexible(
            child: PunnyamDatePicker(
              isEndDate: true,
              isFirstDate: true,
              title:
                  poojaSummaryProvider?.toDate?.split('-').reversed.join('-') ??
                      "To Date",
              onChanged: (date) => poojaSummaryProvider
                ?..updateToDate(date)
                ..updateCurrentIndex(0)
                ..getPoojaSummary(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Reusable styled dropdown
// ─────────────────────────────────────────────────────────────────────────────
class _StyledDropdown<T> extends StatelessWidget {
  final String hint;
  final T? value;
  final IconData icon;
  final bool enabled;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const _StyledDropdown({
    required this.hint,
    required this.value,
    required this.icon,
    required this.items,
    required this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: enabled ? 1.0 : 0.45,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: value != null ? Colors.green : Colors.grey.shade300,
            width: value != null ? 1.5 : 1,
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            isExpanded: true,
            value: value,
            hint: Row(
              children: [
                Icon(icon, size: 14.sp, color: Colors.grey.shade400),
                SizedBox(width: 5.w),
                Expanded(
                  child: Text(
                    hint,
                    style:
                        TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            icon: Icon(Icons.keyboard_arrow_down,
                size: 18.sp,
                color: enabled ? Colors.green : Colors.grey.shade400),
            style: TextStyle(fontSize: 13.sp, color: Colors.black87),
            items: enabled ? items : [],
            onChanged: enabled ? onChanged : null,
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Small active-filter chip
// ─────────────────────────────────────────────────────────────────────────────
class _FilterChip extends StatelessWidget {
  final String label;
  final Color color;

  const _FilterChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(
            fontSize: 11.sp,
            color: color.withOpacity(0.8),
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
