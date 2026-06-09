
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/models/view_samage_model.dart';
// import 'package:stock_manager/providers/stock_provider.dart';
// import 'package:stock_manager/screens/stock/add_damage_screen.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';

// class ViewDamageScreen extends StatefulWidget {
//   const ViewDamageScreen({super.key});

//   @override
//   State<ViewDamageScreen> createState() => _ViewDamageScreenState();
// }

// class _ViewDamageScreenState extends State<ViewDamageScreen> {
//   @override
//   void initState() {
//     super.initState();

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<StockProvider>().getViewDamage();
//     });
//   }

//   Future<void> _refresh() async {
//     await context.read<StockProvider>().getViewDamage();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         elevation: 0,
//         centerTitle: true,
//         backgroundColor: Colors.white,
//         title: Text(
//           "Damage Records",
//           style: TextStyle(
//             color: Colors.black87,
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         iconTheme: const IconThemeData(color: Colors.black87),
//         actions: [
//     Padding(
//       padding: const EdgeInsets.only(right: 12),
//       child: TextButton.icon(
//         onPressed: () async {
//           final result = await Navigator.push(
//             context,
//             MaterialPageRoute(
//               builder: (_) => const AddDamageScreen(),
//             ),
//           );

//           if (result == true) {
//             context.read<StockProvider>().getViewDamage();
//           }
//         },
//         icon: const Icon(
//           Icons.add,
//           color: Colors.red,
//           size: 20,
//         ),
//         label: const Text(
//           "Add",
//           style: TextStyle(
//             color: Colors.red,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//       ),
//     ),
//   ],
        
//       ),
//       body: Consumer<StockProvider>(
//         builder: (context, provider, child) {
//           if (provider.loaderState == LoaderState.loading) {
//             return const Center(
//               child: CircularProgressIndicator(),
//             );
//           }

//           final List<DamageMessage> damageList =
//               provider.damageList;

//           if (damageList.isEmpty) {
//             return const _EmptyWidget();
//           }

//           return RefreshIndicator(
//             onRefresh: _refresh,
//             child: ListView.builder(
//               padding: EdgeInsets.all(12.w),
//               itemCount: damageList.length,
//               itemBuilder: (context, index) {
//                 final item = damageList[index];

//                 return Container(
//                   margin: EdgeInsets.only(bottom: 12.h),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(12.r),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.black.withOpacity(0.05),
//                         blurRadius: 5,
//                         offset: const Offset(0, 2),
//                       ),
//                     ],
//                   ),
//                   child: Padding(
//                     padding: EdgeInsets.all(14.w),
//                     child: Row(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         CircleAvatar(
//                           radius: 18.r,
//                           backgroundColor: Colors.red.shade100,
//                           child: Text(
//                             "${index + 1}",
//                             style: TextStyle(
//                               color: Colors.red.shade700,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),

//                         SizedBox(width: 12.w),

//                         Expanded(
//                           child: Column(
//                             crossAxisAlignment:
//                                 CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 item.productName ?? "",
//                                 style: TextStyle(
//                                   fontSize: 15.sp,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),

//                               SizedBox(height: 8.h),

//                               Row(
//                                 children: [
//                                   Icon(
//                                     Icons.inventory_2_outlined,
//                                     color: Colors.red.shade600,
//                                     size: 16.sp,
//                                   ),
//                                   SizedBox(width: 5.w),
//                                   Text(
//                                     "Qty : ${item.qty ?? 0} ${item.unitName ?? ''}",
//                                     style: TextStyle(
//                                       fontSize: 13.sp,
//                                     ),
//                                   ),
//                                 ],
//                               ),

//                               SizedBox(height: 5.h),

//                               if ((item.reason ?? '').isNotEmpty)
//                                 Row(
//                                   crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                   children: [
//                                     Icon(
//                                       Icons.note_alt_outlined,
//                                       color: Colors.orange,
//                                       size: 16.sp,
//                                     ),
//                                     SizedBox(width: 5.w),
//                                     Expanded(
//                                       child: Text(
//                                         item.reason ?? '',
//                                         style: TextStyle(
//                                           fontSize: 13.sp,
//                                         ),
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                             ],
//                           ),
//                         ),

//                         Container(
//                           padding: EdgeInsets.symmetric(
//                             horizontal: 8.w,
//                             vertical: 4.h,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.red.shade50,
//                             borderRadius:
//                                 BorderRadius.circular(6.r),
//                           ),
//                           child: Text(
//                             formatDate(
//                               item.addedDate ?? "",
//                             ),
//                             style: TextStyle(
//                               color: Colors.red.shade700,
//                               fontSize: 11.sp,
//                               fontWeight: FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }

//   String formatDate(String date) {
//     try {
//       return DateFormat(
//         'dd MMM yyyy',
//       ).format(DateTime.parse(date));
//     } catch (e) {
//       return date;
//     }
//   }
// }

// class _EmptyWidget extends StatelessWidget {
//   const _EmptyWidget();

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         mainAxisAlignment:
//             MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.inventory_2_outlined,
//             size: 70,
//             color: Colors.grey.shade400,
//           ),
//           SizedBox(height: 12.h),
//           Text(
//             "No Damage Records Found",
//             style: TextStyle(
//               fontSize: 15.sp,
//               color: Colors.grey.shade600,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/models/category_model.dart';
import 'package:stock_manager/models/product_model.dart';
import 'package:stock_manager/models/view_samage_model.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/screens/stock/add_damage_screen.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class ViewDamageScreen extends StatefulWidget {
  const ViewDamageScreen({super.key});

  @override
  State<ViewDamageScreen> createState() => _ViewDamageScreenState();
}

class _ViewDamageScreenState extends State<ViewDamageScreen> {
  int? _selectedCategoryId;
  int? _selectedProductId;
  String? _selectedProductName;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<StockProvider>();
      p.getViewDamage();
      p.getCategories();
      p.getProducts();
    });
  }

  Future<void> _refresh() async {
    await context.read<StockProvider>().getViewDamage();
  }

  List<DamageMessage> _filteredList(List<DamageMessage> all) {
    if (_selectedProductName == null) return all;
    return all
        .where((item) => (item.productName ?? '')
            .toLowerCase()
            .contains(_selectedProductName!.toLowerCase()))
        .toList();
  }

  void _clearFilters() {
    setState(() {
      _selectedCategoryId = null;
      _selectedProductId = null;
      _selectedProductName = null;
    });
    context.read<StockProvider>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Damage Records",
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        iconTheme: const IconThemeData(color: Colors.black87),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: TextButton.icon(
              onPressed: () async {
                final result = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AddDamageScreen()),
                );
                if (result == true) {
                  context.read<StockProvider>().getViewDamage();
                }
              },
              icon: const Icon(Icons.add, color: Colors.red, size: 20),
              label: const Text(
                "Add",
                style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Inline filter dropdowns ──────────────────────────────────────
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 12.h),
            child: Consumer<StockProvider>(
              builder: (_, provider, __) {
                return Column(
                  children: [
                    // Category + Product in a Row
                    Row(
                      children: [
                        // Category dropdown
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: 'Category',
                              labelStyle: TextStyle(fontSize: 13.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 12.h),
                              isDense: true,
                            ),
                            value: provider.categoryList
                                    .any((e) => e.id == _selectedCategoryId)
                                ? _selectedCategoryId
                                : null,
                            items: provider.categoryList
                                .fold<List<Cat>>([], (prev, item) {
                                  if (!prev.any((e) => e.id == item.id))
                                    prev.add(item);
                                  return prev;
                                })
                                .map((c) => DropdownMenuItem(
                                      value: c.id,
                                      child: Text(
                                        c.name.toString(),
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                    ))
                                .toList(),
                            onChanged: (val) {
                              setState(() {
                                _selectedCategoryId = val;
                                _selectedProductId = null;
                                _selectedProductName = null;
                              });
                              provider.getProducts(categoryId: val);
                            },
                          ),
                        ),
                        SizedBox(width: 10.w),
                        // Product dropdown
                        Expanded(
                          child: DropdownButtonFormField<int>(
                            decoration: InputDecoration(
                              labelText: 'Product',
                              labelStyle: TextStyle(fontSize: 13.sp),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12.w, vertical: 12.h),
                              isDense: true,
                            ),
                            value: provider.productList
                                    .any((e) => e.id == _selectedProductId)
                                ? _selectedProductId
                                : null,
                            items: _selectedCategoryId == null
                                ? []
                                : provider.productList
                                    .fold<List<Datum>>([], (prev, item) {
                                      if (!prev.any((e) => e.id == item.id))
                                        prev.add(item);
                                      return prev;
                                    })
                                    .map((p) => DropdownMenuItem(
                                          value: p.id,
                                          child: Text(
                                            p.name.toString(),
                                            style:
                                                TextStyle(fontSize: 13.sp),
                                          ),
                                        ))
                                    .toList(),
                            onChanged: _selectedCategoryId == null
                                ? null
                                : (val) {
                                    setState(() {
                                      _selectedProductId = val;
                                      _selectedProductName = provider
                                          .productList
                                          .firstWhere((e) => e.id == val)
                                          .name;
                                    });
                                  },
                          ),
                        ),
                        // Clear button — only show when a filter is active
                        if (_selectedCategoryId != null) ...[
                          SizedBox(width: 6.w),
                          GestureDetector(
                            onTap: _clearFilters,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: Colors.red.shade50,
                                borderRadius: BorderRadius.circular(8.r),
                                border:
                                    Border.all(color: Colors.red.shade200),
                              ),
                              child: Icon(
                                Icons.close,
                                size: 18.sp,
                                color: Colors.red.shade700,
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ],
                );
              },
            ),
          ),

          // ── List ──────────────────────────────────────────────────────────
          Expanded(
            child: Consumer<StockProvider>(
              builder: (context, provider, child) {
                if (provider.loaderState == LoaderState.loading) {
                  return const Center(child: CircularProgressIndicator());
                }

                final filtered = _filteredList(provider.damageList);

                if (filtered.isEmpty) {
                  return _EmptyWidget(
                    isFiltered: _selectedProductName != null,
                    onClear: _clearFilters,
                  );
                }

                return RefreshIndicator(
                  onRefresh: _refresh,
                  child: ListView.builder(
                    padding: EdgeInsets.all(12.w),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final item = filtered[index];
                      return _DamageTile(index: index + 1, item: item);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Damage tile
// ─────────────────────────────────────────────────────────────────────────────
class _DamageTile extends StatelessWidget {
  final int index;
  final DamageMessage item;

  const _DamageTile({required this.index, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(14.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 18.r,
              backgroundColor: Colors.red.shade100,
              child: Text(
                "$index",
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.productName ?? "",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(Icons.inventory_2_outlined,
                          color: Colors.red.shade600, size: 16.sp),
                      SizedBox(width: 5.w),
                      Text(
                        "Qty : ${item.qty ?? 0} ${item.unitName ?? ''}",
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ],
                  ),
                  if ((item.reason ?? '').isNotEmpty) ...[
                    SizedBox(height: 5.h),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.note_alt_outlined,
                            color: Colors.orange, size: 16.sp),
                        SizedBox(width: 5.w),
                        Expanded(
                          child: Text(
                            item.reason ?? '',
                            style: TextStyle(fontSize: 13.sp),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: Colors.red.shade50,
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                _formatDate(item.addedDate ?? ""),
                style: TextStyle(
                  color: Colors.red.shade700,
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatDate(String date) {
    try {
      return DateFormat('dd MMM yyyy').format(DateTime.parse(date));
    } catch (e) {
      return date;
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Empty widget
// ─────────────────────────────────────────────────────────────────────────────
class _EmptyWidget extends StatelessWidget {
  final bool isFiltered;
  final VoidCallback onClear;

  const _EmptyWidget({required this.isFiltered, required this.onClear});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isFiltered ? Icons.search_off_rounded : Icons.inventory_2_outlined,
            size: 70,
            color: Colors.grey.shade400,
          ),
          SizedBox(height: 12.h),
          Text(
            isFiltered
                ? "No damage records found\nfor selected product"
                : "No Damage Records Found",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15.sp,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
          ),
          if (isFiltered) ...[
            16.verticalSpace,
            TextButton.icon(
              onPressed: onClear,
              icon: const Icon(Icons.clear, size: 16),
              label: const Text('Clear Filter'),
            ),
          ],
        ],
      ),
    );
  }
}