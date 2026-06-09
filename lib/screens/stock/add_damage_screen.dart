// // import 'package:flutter/material.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:intl/intl.dart';
// // import 'package:provider/provider.dart';
// // import 'package:stock_manager/common/common_button.dart';
// // import 'package:stock_manager/models/product_model.dart';
// // import 'package:stock_manager/models/supplier_model.dart';
// // import 'package:stock_manager/models/unit_model.dart';
// // import 'package:stock_manager/models/category_model.dart';
// // import 'package:stock_manager/providers/stock_provider.dart';
// // import 'package:stock_manager/services/app_config.dart';
// // import 'package:stock_manager/services/provider_helper_class.dart';
// // import 'package:stock_manager/services/shared_preference_helper.dart';

// // /// ─────────────────────────────────────────────────────────────────────────────
// // /// AddDamageScreen
// // ///
// // /// Scenario: Purchased 30 KG ladies finger → sold 29 KG → 1 KG damaged.
// // /// This screen records the 1 KG damage with its purchase rate so the loss
// // /// amount (₹) is tracked and stock is decremented correctly on the backend.
// // ///
// // /// Navigation: Push this screen from purchase_details_screen.dart or
// // /// from the stock screen's action menu, passing [purchaseId] + [supplierId].
// // /// ─────────────────────────────────────────────────────────────────────────────
// // class AddDamageScreen extends StatefulWidget {
// //   final int purchaseId;
// //   final int supplierId;

// //   const AddDamageScreen({
// //     super.key,
// //     required this.purchaseId,
// //     required this.supplierId,
// //   });

// //   @override
// //   State<AddDamageScreen> createState() => _AddDamageScreenState();
// // }

// // class _AddDamageScreenState extends State<AddDamageScreen> {
// //   // ── Form & controllers ────────────────────────────────────────────────────
// //   final formKey = GlobalKey<FormState>();
// //   final TextEditingController damagedQtyController = TextEditingController();
// //   final TextEditingController purchaseRateController = TextEditingController();
// //   final TextEditingController productCodeController = TextEditingController();
// //   final TextEditingController notesController = TextEditingController();

// //   // ── Selection state ────────────────────────────────────────────────────────
// //   int? selectedCategoryId;
// //   int? selectedProductId;
// //   int? selectedUnitId;
// //   String? selectedUnitName;
// //   DateTime selectedDate = DateTime.now();

// //   // ── Accumulated damage list ────────────────────────────────────────────────
// //   /// Each entry: { supplier, product, unit, damagedQty, purchaseRate, lossAmt }
// //   List<Map<String, dynamic>> damagedItems = [];

// //   // ─────────────────────────────────────────────────────────────────────────
// //   @override
// //   void initState() {
// //     super.initState();
// //     WidgetsBinding.instance.addPostFrameCallback((_) {
// //       final p = context.read<StockProvider>();
// //       p.getProducts();
// //       p.getSuppliers();
// //       p.getUnits();
// //       p.getCategories();
// //     });
// //   }

// //   @override
// //   void dispose() {
// //     damagedQtyController.dispose();
// //     purchaseRateController.dispose();
// //     productCodeController.dispose();
// //     notesController.dispose();
// //     super.dispose();
// //   }

// //   // ─────────────────────────────────────────────────────────────────────────
// //   Future<void> _pickDate() async {
// //     final picked = await showDatePicker(
// //       context: context,
// //       initialDate: selectedDate,
// //       firstDate: DateTime(2000),
// //       lastDate: DateTime(2100),
// //     );
// //     if (picked != null) setState(() => selectedDate = picked);
// //   }

// //   // ── Live total loss ────────────────────────────────────────────────────────
// //   double _currentLoss() {
// //     double qty = double.tryParse(damagedQtyController.text) ?? 0;
// //     double rate = double.tryParse(purchaseRateController.text) ?? 0;
// //     return qty * rate;
// //   }

// //   double _totalLoss() {
// //     double accumulated =
// //         damagedItems.fold(0.0, (sum, e) => sum + (e['lossAmt'] as num));
// //     return accumulated + _currentLoss();
// //   }

// //   // ── Add current item to list ───────────────────────────────────────────────
// //   void _addItem() {
// //     if (!formKey.currentState!.validate()) return;

// //     double qty = double.parse(damagedQtyController.text);
// //     double rate = double.parse(purchaseRateController.text);

// //     setState(() {
// //       damagedItems.add({
// //         'supplier': widget.supplierId,
// //         'product': selectedProductId,
// //         'productName': context
// //             .read<StockProvider>()
// //             .productList
// //             .firstWhere((e) => e.id == selectedProductId)
// //             .name,
// //         'unit': selectedUnitId.toString(),
// //         'unitName': selectedUnitName ?? '',
// //         'damagedQty': qty.toInt(),
// //         'purchaseRate': rate.toInt(),
// //         'lossAmt': qty * rate,
// //       });

// //       // Reset item fields
// //       selectedCategoryId = null;
// //       selectedProductId = null;
// //       selectedUnitId = null;
// //       selectedUnitName = null;
// //       damagedQtyController.clear();
// //       purchaseRateController.clear();
// //       productCodeController.clear();
// //     });

// //     ScaffoldMessenger.of(context).showSnackBar(
// //       SnackBar(
// //         content: Text(
// //             'Item added. Loss: ₹${(_currentLoss()).toStringAsFixed(2)}'),
// //         backgroundColor: Colors.orange,
// //       ),
// //     );
// //   }

// //   // ── Submit all damage entries ──────────────────────────────────────────────
// //   Future<void> _saveAll() async {
// //     // If user filled a partial form, add it first
// //     bool hasCurrentData = damagedQtyController.text.isNotEmpty ||
// //         purchaseRateController.text.isNotEmpty ||
// //         selectedProductId != null;

// //     if (hasCurrentData) {
// //       if (!formKey.currentState!.validate()) return;
// //       double qty = double.parse(damagedQtyController.text);
// //       double rate = double.parse(purchaseRateController.text);
// //       damagedItems.add({
// //         'supplier': widget.supplierId,
// //         'product': selectedProductId,
// //         'productName': context
// //             .read<StockProvider>()
// //             .productList
// //             .firstWhere((e) => e.id == selectedProductId)
// //             .name,
// //         'unit': selectedUnitId.toString(),
// //         'unitName': selectedUnitName ?? '',
// //         'damagedQty': qty.toInt(),
// //         'purchaseRate': rate.toInt(),
// //         'lossAmt': qty * rate,
// //       });
// //     }

// //     if (damagedItems.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Please enter at least one damaged item')),
// //       );
// //       return;
// //     }

// //     await SharedPreferenceHelper.getStoreID();

// //     if (AppConfig.storeId == null || AppConfig.storeId!.isEmpty) {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text('Store ID missing. Please login again')),
// //       );
// //       return;
// //     }

// //     context.read<StockProvider>().saveDamage(
// //       damagedItems: damagedItems,
// //       purchaseId: widget.purchaseId,
// //       date: selectedDate,
// //       notes: notesController.text.trim().isEmpty ? null : notesController.text.trim(),
// //       onSuccess: () {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('Damage entry saved successfully'),
// //             backgroundColor: Colors.green,
// //           ),
// //         );
// //         setState(() {
// //           damagedItems.clear();
// //           damagedQtyController.clear();
// //           purchaseRateController.clear();
// //           productCodeController.clear();
// //           notesController.clear();
// //           selectedCategoryId = null;
// //           selectedProductId = null;
// //           selectedUnitId = null;
// //           selectedUnitName = null;
// //           selectedDate = DateTime.now();
// //         });
// //         Navigator.pop(context);
// //       },
// //       onFailure: () {
// //         ScaffoldMessenger.of(context).showSnackBar(
// //           const SnackBar(
// //             content: Text('Failed to save damage entry'),
// //             backgroundColor: Colors.red,
// //           ),
// //         );
// //       },
// //     );
// //   }

// //   // ─────────────────────────────────────────────────────────────────────────
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.grey.shade50,
// //       appBar: AppBar(
// //         backgroundColor: Colors.white,
// //         centerTitle: true,
// //         elevation: 0.5,
// //         title: Text(
// //           'Damage Entry',
// //           style: TextStyle(
// //             fontSize: 20.sp,
// //             fontWeight: FontWeight.w600,
// //             color: Colors.black87,
// //           ),
// //         ),
// //         iconTheme: const IconThemeData(color: Colors.black87),
// //       ),
// //       body: SingleChildScrollView(
// //         padding: EdgeInsets.all(16.w),
// //         child: Form(
// //           key: formKey,
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               // ── Info Banner ────────────────────────────────────────────
// //               _InfoBanner(purchaseId: widget.purchaseId),
// //               16.verticalSpace,

// //               // ── Date ──────────────────────────────────────────────────
// //               _sectionLabel('Damage Date'),
// //               8.verticalSpace,
// //               InkWell(
// //                 onTap: _pickDate,
// //                 child: InputDecorator(
// //                   decoration: const InputDecoration(
// //                     border: OutlineInputBorder(),
// //                     suffixIcon: Icon(Icons.calendar_today, size: 18),
// //                     contentPadding:
// //                         EdgeInsets.symmetric(horizontal: 12, vertical: 14),
// //                   ),
// //                   child: Text(DateFormat('dd-MM-yyyy').format(selectedDate)),
// //                 ),
// //               ),
// //               16.verticalSpace,

// //               // ── Category ──────────────────────────────────────────────
// //               _sectionLabel('Category'),
// //               8.verticalSpace,
// //               Consumer<StockProvider>(
// //                 builder: (context, provider, _) {
// //                   return DropdownButtonFormField<int>(
// //                     decoration: const InputDecoration(
// //                       border: OutlineInputBorder(),
// //                       labelText: 'Select Category',
// //                       contentPadding:
// //                           EdgeInsets.symmetric(horizontal: 12, vertical: 14),
// //                     ),
// //                     value: provider.categoryList
// //                             .any((e) => e.id == selectedCategoryId)
// //                         ? selectedCategoryId
// //                         : null,
// //                     items: provider.categoryList
// //                         .fold<List<Cat>>([], (prev, item) {
// //                           if (!prev.any((e) => e.id == item.id)) {
// //                             prev.add(item);
// //                           }
// //                           return prev;
// //                         })
// //                         .map((item) => DropdownMenuItem<int>(
// //                               value: item.id,
// //                               child: Text(item.name.toString()),
// //                             ))
// //                         .toList(),
// //                     onChanged: (value) {
// //                       setState(() {
// //                         selectedCategoryId = value;
// //                         selectedProductId = null;
// //                       });
// //                       provider.getProducts(categoryId: value);
// //                     },
// //                     validator: (v) => v == null ? 'Select category' : null,
// //                   );
// //                 },
// //               ),
// //               12.verticalSpace,

// //               // ── Product ───────────────────────────────────────────────
// //               _sectionLabel('Damaged Product'),
// //               8.verticalSpace,
// //               Consumer<StockProvider>(
// //                 builder: (context, provider, _) {
// //                   return DropdownButtonFormField<int>(
// //                     decoration: const InputDecoration(
// //                       border: OutlineInputBorder(),
// //                       labelText: 'Select Product',
// //                       contentPadding:
// //                           EdgeInsets.symmetric(horizontal: 12, vertical: 14),
// //                     ),
// //                     value: provider.productList
// //                             .any((e) => e.id == selectedProductId)
// //                         ? selectedProductId
// //                         : null,
// //                     items: provider.productList
// //                         .fold<List<Datum>>([], (prev, item) {
// //                           if (!prev.any((e) => e.id == item.id)) {
// //                             prev.add(item);
// //                           }
// //                           return prev;
// //                         })
// //                         .map((item) => DropdownMenuItem<int>(
// //                               value: item.id,
// //                               child: Text(item.name.toString()),
// //                             ))
// //                         .toList(),
// //                     onChanged: (value) {
// //                       setState(() {
// //                         selectedProductId = value;
// //                         final product = provider.productList
// //                             .firstWhere((e) => e.id == value);
// //                         productCodeController.text = product.code ?? '';
// //                         selectedUnitId = product.unit;
// //                         final unitObj = provider.unitList.firstWhere(
// //                           (u) => u.id == selectedUnitId,
// //                           orElse: () => Unit(id: 0, name: 'Unknown'),
// //                         );
// //                         selectedUnitName = unitObj.name;
// //                       });
// //                     },
// //                     validator: (v) => v == null ? 'Select product' : null,
// //                   );
// //                 },
// //               ),
// //               12.verticalSpace,

// //               // ── Product code + Unit ───────────────────────────────────
// //               Row(
// //                 children: [
// //                   Expanded(
// //                     child: TextFormField(
// //                       controller: productCodeController,
// //                       readOnly: true,
// //                       decoration: const InputDecoration(
// //                         labelText: 'Product Code',
// //                         border: OutlineInputBorder(),
// //                       ),
// //                     ),
// //                   ),
// //                   12.horizontalSpace,
// //                   Expanded(
// //                     child: Consumer<StockProvider>(
// //                       builder: (context, provider, _) {
// //                         return DropdownButtonFormField<int>(
// //                           decoration: const InputDecoration(
// //                             labelText: 'Unit',
// //                             border: OutlineInputBorder(),
// //                           ),
// //                           value: provider.unitList
// //                                   .any((e) => e.id == selectedUnitId)
// //                               ? selectedUnitId
// //                               : null,
// //                           items: provider.unitList
// //                               .map((u) => DropdownMenuItem<int>(
// //                                     value: u.id,
// //                                     child: Text(u.name.toString()),
// //                                   ))
// //                               .toList(),
// //                           onChanged: (value) {
// //                             setState(() {
// //                               selectedUnitId = value;
// //                               selectedUnitName = provider.unitList
// //                                   .firstWhere((u) => u.id == value)
// //                                   .name;
// //                             });
// //                           },
// //                           validator: (v) => v == null ? 'Select unit' : null,
// //                         );
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               16.verticalSpace,

// //               // ── Damaged Qty + Purchase Rate ────────────────────────────
// //               _sectionLabel('Damage Details'),
// //               8.verticalSpace,
// //               Row(
// //                 children: [
// //                   // Damaged Qty
// //                   SizedBox(
// //                     width: 110.w,
// //                     child: TextFormField(
// //                       controller: damagedQtyController,
// //                       keyboardType: TextInputType.number,
// //                       textAlign: TextAlign.center,
// //                       decoration: InputDecoration(
// //                         labelText: 'Dmg Qty',
// //                         border: const OutlineInputBorder(),
// //                         suffixText: selectedUnitName ?? '',
// //                       ),
// //                       onChanged: (_) => setState(() {}),
// //                       validator: (v) {
// //                         if (v == null || v.isEmpty) return 'Enter qty';
// //                         if (double.tryParse(v) == null) return 'Invalid';
// //                         if (double.parse(v) <= 0) return 'Must be > 0';
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                   12.horizontalSpace,
// //                   // Purchase Rate
// //                   Expanded(
// //                     child: TextFormField(
// //                       controller: purchaseRateController,
// //                       keyboardType: TextInputType.number,
// //                       decoration: const InputDecoration(
// //                         labelText: 'Purchase Rate (₹)',
// //                         border: OutlineInputBorder(),
// //                       ),
// //                       onChanged: (_) => setState(() {}),
// //                       validator: (v) {
// //                         if (v == null || v.isEmpty) return 'Enter rate';
// //                         if (double.tryParse(v) == null) return 'Invalid';
// //                         return null;
// //                       },
// //                     ),
// //                   ),
// //                 ],
// //               ),
// //               16.verticalSpace,

// //               // ── Notes ─────────────────────────────────────────────────
// //               TextFormField(
// //                 controller: notesController,
// //                 maxLines: 2,
// //                 decoration: const InputDecoration(
// //                   labelText: 'Reason / Notes (optional)',
// //                   border: OutlineInputBorder(),
// //                   hintText: 'e.g. Rotten due to storage, Transport damage',
// //                 ),
// //               ),
// //               20.verticalSpace,

// //               // ── Loss preview card ──────────────────────────────────────
// //               _LossCard(
// //                 currentLoss: _currentLoss(),
// //                 totalLoss: _totalLoss(),
// //                 itemCount: damagedItems.length,
// //               ),
// //               16.verticalSpace,

// //               // ── Add another item ───────────────────────────────────────
// //               CommonButton(
// //                 title: 'Add Another Damaged Item',
// //                 titleColor: Colors.white,
// //                 colors: const [Colors.orange, Colors.orange],
// //                 onPressed: _addItem,
// //               ),
// //               12.verticalSpace,

// //               // ── Added items list ───────────────────────────────────────
// //               if (damagedItems.isNotEmpty) ...[
// //                 _sectionLabel('Damage List'),
// //                 8.verticalSpace,
// //                 ...damagedItems.asMap().entries.map((entry) {
// //                   final i = entry.key;
// //                   final item = entry.value;
// //                   return _DamageItemCard(
// //                     item: item,
// //                     onDelete: () => setState(() => damagedItems.removeAt(i)),
// //                   );
// //                 }),
// //                 16.verticalSpace,
// //               ],

// //               // ── Submit ────────────────────────────────────────────────
// //               Consumer<StockProvider>(
// //                 builder: (context, provider, _) {
// //                   return CommonButton(
// //                     title: provider.btnLoader
// //                         ? 'Saving...'
// //                         : 'Save Damage Entry',
// //                     titleColor: Colors.white,
// //                     colors: const [Color(0xFF2E7D32), Color(0xFF2E7D32)],
// //                     onPressed: provider.btnLoader ? null : _saveAll,
// //                   );
// //                 },
// //               ),
// //               24.verticalSpace,
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Widget _sectionLabel(String text) => Text(
// //         text,
// //         style: TextStyle(
// //           fontSize: 13.sp,
// //           fontWeight: FontWeight.w600,
// //           color: Colors.grey.shade600,
// //           letterSpacing: 0.3,
// //         ),
// //       );
// // }

// // // ─────────────────────────────────────────────────────────────────────────────
// // // Sub-widgets
// // // ─────────────────────────────────────────────────────────────────────────────

// // class _InfoBanner extends StatelessWidget {
// //   final int purchaseId;
// //   const _InfoBanner({required this.purchaseId});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(12.w),
// //       decoration: BoxDecoration(
// //         color: Colors.orange.shade50,
// //         border: Border.all(color: Colors.orange.shade200),
// //         borderRadius: BorderRadius.circular(10),
// //       ),
// //       child: Row(
// //         children: [
// //           Icon(Icons.info_outline, color: Colors.orange.shade700, size: 20),
// //           12.horizontalSpace,
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Damage Entry for Purchase #$purchaseId',
// //                   style: TextStyle(
// //                     fontSize: 13.sp,
// //                     fontWeight: FontWeight.w600,
// //                     color: Colors.orange.shade800,
// //                   ),
// //                 ),
// //                 4.verticalSpace,
// //                 Text(
// //                   'Record only the quantity that was damaged/wasted. '
// //                   'Stock will be reduced by the damaged amount.',
// //                   style: TextStyle(
// //                     fontSize: 11.sp,
// //                     color: Colors.orange.shade700,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _LossCard extends StatelessWidget {
// //   final double currentLoss;
// //   final double totalLoss;
// //   final int itemCount;

// //   const _LossCard({
// //     required this.currentLoss,
// //     required this.totalLoss,
// //     required this.itemCount,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       padding: EdgeInsets.all(14.w),
// //       decoration: BoxDecoration(
// //         color: Colors.red.shade50,
// //         borderRadius: BorderRadius.circular(10),
// //         border: Border.all(color: Colors.red.shade200),
// //       ),
// //       child: Row(
// //         children: [
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 Text(
// //                   'Current Item Loss',
// //                   style: TextStyle(fontSize: 12.sp, color: Colors.grey),
// //                 ),
// //                 Text(
// //                   '₹${currentLoss.toStringAsFixed(2)}',
// //                   style: TextStyle(
// //                     fontSize: 16.sp,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.red.shade700,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //           Container(height: 40, width: 1, color: Colors.red.shade200),
// //           Expanded(
// //             child: Column(
// //               crossAxisAlignment: CrossAxisAlignment.end,
// //               children: [
// //                 Text(
// //                   'Total Loss ($itemCount added)',
// //                   style: TextStyle(fontSize: 12.sp, color: Colors.grey),
// //                 ),
// //                 Text(
// //                   '₹${totalLoss.toStringAsFixed(2)}',
// //                   style: TextStyle(
// //                     fontSize: 16.sp,
// //                     fontWeight: FontWeight.bold,
// //                     color: Colors.red.shade900,
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class _DamageItemCard extends StatelessWidget {
// //   final Map<String, dynamic> item;
// //   final VoidCallback onDelete;

// //   const _DamageItemCard({required this.item, required this.onDelete});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       margin: EdgeInsets.only(bottom: 8.h),
// //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
// //       child: ListTile(
// //         contentPadding:
// //             EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
// //         leading: CircleAvatar(
// //           backgroundColor: Colors.red.shade100,
// //           child: Icon(Icons.warning_amber_rounded,
// //               color: Colors.red.shade700, size: 18),
// //         ),
// //         title: Text(
// //           item['productName']?.toString() ?? 'Product #${item['product']}',
// //           style: TextStyle(
// //               fontWeight: FontWeight.w600, fontSize: 13.sp),
// //         ),
// //         subtitle: Text(
// //           'Damaged: ${item['damagedQty']} ${item['unitName']}  |  '
// //           'Rate: ₹${item['purchaseRate']}',
// //           style: TextStyle(fontSize: 12.sp),
// //         ),
// //         trailing: Row(
// //           mainAxisSize: MainAxisSize.min,
// //           children: [
// //             Text(
// //               '-₹${(item['lossAmt'] as num).toStringAsFixed(0)}',
// //               style: TextStyle(
// //                 color: Colors.red.shade700,
// //                 fontWeight: FontWeight.bold,
// //                 fontSize: 13.sp,
// //               ),
// //             ),
// //             IconButton(
// //               icon: const Icon(Icons.delete_outline, color: Colors.red),
// //               onPressed: onDelete,
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }






// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/common/color_palette.dart';
// import 'package:stock_manager/common/common_button.dart';
// import 'package:stock_manager/models/category_model.dart';
// import 'package:stock_manager/models/product_model.dart';
// import 'package:stock_manager/models/unit_model.dart';
// import 'package:stock_manager/providers/stock_provider.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';

// /// AddDamageScreen — UI Only (API integration pending)
// ///
// /// Usage:
// ///   Navigator.push(context, MaterialPageRoute(
// ///     builder: (_) => const AddDamageScreen(),
// ///   ));

// class AddDamageScreen extends StatefulWidget {
//   const AddDamageScreen({super.key});

//   @override
//   State<AddDamageScreen> createState() => _AddDamageScreenState();
// }

// class _AddDamageScreenState extends State<AddDamageScreen> {
//   final _formKey = GlobalKey<FormState>();

//   // Controllers
//   final TextEditingController _damagedQtyCtrl = TextEditingController();
//   final TextEditingController _productCodeCtrl = TextEditingController();
//   final TextEditingController _notesCtrl = TextEditingController();

//   // Selections
//   int? _selectedCategoryId;
//   int? _selectedProductId;
//   int? _selectedUnitId;
//   String? _selectedUnitName;
//   String? _selectedProductName;
//   DateTime _selectedDate = DateTime.now();

//   // Accumulated damage rows
//   List<Map<String, dynamic>> _damagedItems = [];

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       final p = context.read<StockProvider>();
//       p.getProducts();
//       p.getUnits();
//       p.getCategories();
//     });
//   }

//   @override
//   void dispose() {
//     _damagedQtyCtrl.dispose();
//     _productCodeCtrl.dispose();
//     _notesCtrl.dispose();
//     super.dispose();
//   }

//   // ── Date picker ────────────────────────────────────────────────────────────
//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate,
//       firstDate: DateTime(2000),
//       lastDate: DateTime.now(),
//     );
//     if (picked != null) setState(() => _selectedDate = picked);
//   }

//   // ── Add item to list ───────────────────────────────────────────────────────
//   void _addItem() {
//     if (!_formKey.currentState!.validate()) return;

//     final qty = double.parse(_damagedQtyCtrl.text);

//     setState(() {
//       _damagedItems.add({
//         'productId': _selectedProductId,
//         'productName': _selectedProductName ?? 'Product',
//         'productCode': _productCodeCtrl.text,
//         'unitId': _selectedUnitId,
//         'unitName': _selectedUnitName ?? '',
//         'damagedQty': qty,
//       });

//       // Reset item fields only (not date/notes)
//       _selectedCategoryId = null;
//       _selectedProductId = null;
//       _selectedProductName = null;
//       _selectedUnitId = null;
//       _selectedUnitName = null;
//       _damagedQtyCtrl.clear();
//       _productCodeCtrl.clear();
//     });

//     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//       content: Text(
//           'Item added — ${qty.toStringAsFixed(0)} ${_selectedUnitName ?? ''} damaged'),
//       backgroundColor: Colors.orange.shade700,
//       behavior: SnackBarBehavior.floating,
//       duration: const Duration(seconds: 2),
//     ));
//   }

// void _saveAll() {
//   final hasPartialData =
//       _damagedQtyCtrl.text.isNotEmpty || _selectedProductId != null;

//   if (hasPartialData) {
//     if (!_formKey.currentState!.validate()) return;
//     final qty = double.parse(_damagedQtyCtrl.text);
//     _damagedItems.add({
//       'productId': _selectedProductId,
//       'productName': _selectedProductName ?? 'Product',
//       'productCode': _productCodeCtrl.text,
//       'unitId': _selectedUnitId,
//       'unitName': _selectedUnitName ?? '',
//       'damagedQty': qty,
//     });
//   }

//   if (_damagedItems.isEmpty) {
//     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//       content: Text('Please add at least one damaged item'),
//       backgroundColor: Colors.red,
//     ));
//     return;
//   }

//   context.read<StockProvider>().saveDamage(
//     damagedItems: List.from(_damagedItems),
//     date: _selectedDate,
//     notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
//     onSuccess: () {
//       setState(() {
//         _damagedItems.clear();
//         _selectedCategoryId = null;
//         _selectedProductId = null;
//         _selectedProductName = null;
//         _selectedUnitId = null;
//         _selectedUnitName = null;
//         _damagedQtyCtrl.clear();
//         _productCodeCtrl.clear();
//         _notesCtrl.clear();
//         _selectedDate = DateTime.now();
//       });
//       Navigator.pop(context, true); // pass true so caller can refresh
//     },
//     onFailure: () {
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('Failed to save damage entry'),
//         backgroundColor: Colors.red,
//       ));
//     },
//   );
// }

//   void _showSuccessDialog() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//         title: Row(children: [
//           Icon(Icons.check_circle, color: ColorPalette.darkGreen),
//           const SizedBox(width: 8),
//           const Text('Damage Recorded'),
//         ]),
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text('Date: ${DateFormat('dd MMM yyyy').format(_selectedDate)}'),
//             const SizedBox(height: 4),
//             Text('Items: ${_damagedItems.length}'),
//             if (_notesCtrl.text.isNotEmpty) ...[
//               const SizedBox(height: 4),
//               Text('Notes: ${_notesCtrl.text}'),
//             ],
//           ],
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     ).then((_) {
//       setState(() {
//         _damagedItems.clear();
//         _selectedCategoryId = null;
//         _selectedProductId = null;
//         _selectedProductName = null;
//         _selectedUnitId = null;
//         _selectedUnitName = null;
//         _damagedQtyCtrl.clear();
//         _productCodeCtrl.clear();
//         _notesCtrl.clear();
//         _selectedDate = DateTime.now();
//       });
//       Navigator.pop(context);
//     });
//   }

//   // ─────────────────────────────────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFFF5F5F5),
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         centerTitle: true,
//         elevation: 0.5,
//         iconTheme: const IconThemeData(color: Colors.black87),
//         title: Text(
//           'Damage Entry',
//           style: TextStyle(
//             fontSize: 20.sp,
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.all(16.w),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // ── Info banner ──────────────────────────────────────────────
//               _InfoBanner(),
//               16.verticalSpace,

//               // ── Card: Date ───────────────────────────────────────────────
//               _Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _SectionTitle('Damage Date'),
//                     12.verticalSpace,
//                     InkWell(
//                       onTap: _pickDate,
//                       borderRadius: BorderRadius.circular(8),
//                       child: InputDecorator(
//                         decoration: const InputDecoration(
//                           labelText: 'Select Date',
//                           border: OutlineInputBorder(),
//                           suffixIcon: Icon(Icons.calendar_today, size: 18),
//                           contentPadding: EdgeInsets.symmetric(
//                               horizontal: 12, vertical: 14),
//                         ),
//                         child: Text(
//                           DateFormat('dd-MM-yyyy').format(_selectedDate),
//                           style: TextStyle(fontSize: 14.sp),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               12.verticalSpace,

//               // ── Card: Product ────────────────────────────────────────────
//               _Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _SectionTitle('Damaged Product'),
//                     12.verticalSpace,

//                     // Category
//                     Consumer<StockProvider>(
//                       builder: (_, provider, __) {
//                         return DropdownButtonFormField<int>(
//                           decoration: InputDecoration(
//                             labelText: 'Select Category',
//                             border: const OutlineInputBorder(),
//                             prefixIcon:
//                                 provider.loaderState == LoaderState.loading
//                                     ? const Padding(
//                                         padding: EdgeInsets.all(12),
//                                         child: SizedBox(
//                                           width: 18,
//                                           height: 18,
//                                           child: CircularProgressIndicator(
//                                               strokeWidth: 2),
//                                         ),
//                                       )
//                                     : null,
//                           ),
//                           value: provider.categoryList
//                                   .any((e) => e.id == _selectedCategoryId)
//                               ? _selectedCategoryId
//                               : null,
//                           items: provider.categoryList
//                               .fold<List<Cat>>([], (prev, item) {
//                                 if (!prev.any((e) => e.id == item.id))
//                                   prev.add(item);
//                                 return prev;
//                               })
//                               .map((c) => DropdownMenuItem(
//                                     value: c.id,
//                                     child: Text(c.name.toString()),
//                                   ))
//                               .toList(),
//                           onChanged: (val) {
//                             setState(() {
//                               _selectedCategoryId = val;
//                               _selectedProductId = null;
//                               _selectedProductName = null;
//                               _productCodeCtrl.clear();
//                             });
//                             provider.getProducts(categoryId: val);
//                           },
//                           validator: (v) =>
//                               v == null ? 'Select category' : null,
//                         );
//                       },
//                     ),
//                     12.verticalSpace,

//                     // Product
//                     Consumer<StockProvider>(
//                       builder: (_, provider, __) {
//                         return DropdownButtonFormField<int>(
//                           decoration: const InputDecoration(
//                             labelText: 'Select Product',
//                             border: OutlineInputBorder(),
//                           ),
//                           value: provider.productList
//                                   .any((e) => e.id == _selectedProductId)
//                               ? _selectedProductId
//                               : null,
//                           items: provider.productList
//                               .fold<List<Datum>>([], (prev, item) {
//                                 if (!prev.any((e) => e.id == item.id))
//                                   prev.add(item);
//                                 return prev;
//                               })
//                               .map((p) => DropdownMenuItem(
//                                     value: p.id,
//                                     child: Text(p.name.toString()),
//                                   ))
//                               .toList(),
//                           onChanged: (val) {
//                             setState(() {
//                               _selectedProductId = val;
//                               final product = provider.productList
//                                   .firstWhere((e) => e.id == val);
//                               _selectedProductName = product.name;
//                               _productCodeCtrl.text = product.code ?? '';
//                               _selectedUnitId = product.unit;
//                               final unitObj = provider.unitList.firstWhere(
//                                 (u) => u.id == _selectedUnitId,
//                                 orElse: () => Unit(id: 0, name: ''),
//                               );
//                               _selectedUnitName = unitObj.name;
//                             });
//                           },
//                           validator: (v) =>
//                               v == null ? 'Select product' : null,
//                         );
//                       },
//                     ),
//                     12.verticalSpace,

//                     // Product Code + Unit row
//                     Row(
//                       children: [
//                         Expanded(
//                           child: TextFormField(
//                             controller: _productCodeCtrl,
//                             readOnly: true,
//                             decoration: const InputDecoration(
//                               labelText: 'Product Code',
//                               border: OutlineInputBorder(),
//                             ),
//                           ),
//                         ),
//                         12.horizontalSpace,
//                         Expanded(
//                           child: Consumer<StockProvider>(
//                             builder: (_, provider, __) {
//                               return DropdownButtonFormField<int>(
//                                 decoration: const InputDecoration(
//                                   labelText: 'Unit',
//                                   border: OutlineInputBorder(),
//                                 ),
//                                 value: provider.unitList
//                                         .any((u) => u.id == _selectedUnitId)
//                                     ? _selectedUnitId
//                                     : null,
//                                 items: provider.unitList
//                                     .map((u) => DropdownMenuItem(
//                                           value: u.id,
//                                           child: Text(u.name.toString()),
//                                         ))
//                                     .toList(),
//                                 onChanged: (val) => setState(() {
//                                   _selectedUnitId = val;
//                                   _selectedUnitName = provider.unitList
//                                       .firstWhere((u) => u.id == val)
//                                       .name;
//                                 }),
//                                 validator: (v) =>
//                                     v == null ? 'Select unit' : null,
//                               );
//                             },
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               12.verticalSpace,

//               // ── Card: Damaged Qty + Notes ─────────────────────────────────
//               _Card(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     _SectionTitle('Damage Details'),
//                     12.verticalSpace,

//                     // Damaged Qty — full width now (no rate field)
//                     TextFormField(
//                       controller: _damagedQtyCtrl,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         labelText: 'Damaged Quantity',
//                         border: const OutlineInputBorder(),
//                         suffixText: _selectedUnitName ?? '',
//                         prefixIcon: const Icon(Icons.remove_circle_outline,
//                             color: Colors.red),
//                       ),
//                       onChanged: (_) => setState(() {}),
//                       validator: (v) {
//                         if (v == null || v.isEmpty) return 'Enter damaged qty';
//                         if (double.tryParse(v) == null) return 'Invalid number';
//                         if (double.parse(v) <= 0) return 'Must be greater than 0';
//                         return null;
//                       },
//                     ),
//                     16.verticalSpace,

//                     // Notes
//                     TextFormField(
//                       controller: _notesCtrl,
//                       maxLines: 2,
//                       decoration: const InputDecoration(
//                         labelText: 'Reason / Notes',
//                         border: OutlineInputBorder(),
//                         hintText: 'e.g. Rotten, transport damage...',
//                         prefixIcon: Icon(Icons.note_alt_outlined),
//                       ),
//                       validator: (value) {
//                         if (value == null || value.trim().isEmpty) {
//                           return 'Please enter damage reason';
//                         }
//                         return null;
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//               16.verticalSpace,

//               // ── Add item button ───────────────────────────────────────────
//               CommonButton(
//                 title: '+ Add Another Item',
//                 titleColor: Colors.white,
//                 colors: [Colors.orange.shade700, Colors.orange.shade700],
//                 onPressed: _addItem,
//               ),

//               // ── Added items list ──────────────────────────────────────────
//               if (_damagedItems.isNotEmpty) ...[
//                 16.verticalSpace,
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     _SectionTitle('Damage List (${_damagedItems.length})'),
//                     TextButton.icon(
//                       onPressed: () => setState(() => _damagedItems.clear()),
//                       icon: const Icon(Icons.delete_sweep,
//                           size: 16, color: Colors.red),
//                       label: Text('Clear All',
//                           style:
//                               TextStyle(color: Colors.red, fontSize: 12.sp)),
//                     ),
//                   ],
//                 ),
//                 8.verticalSpace,
//                 ..._damagedItems.asMap().entries.map((entry) {
//                   return _DamageItemTile(
//                     index: entry.key + 1,
//                     item: entry.value,
//                     onDelete: () =>
//                         setState(() => _damagedItems.removeAt(entry.key)),
//                   );
//                 }),
//                 12.verticalSpace,
//               ],

//               // ── Save button ───────────────────────────────────────────────
//               // CommonButton(
//               //   title: 'Save Damage Entry',
//               //   titleColor: Colors.white,
//               //   colors: [ColorPalette.darkGreen, ColorPalette.darkGreen],
//               //   onPressed: _saveAll,
//               // ),

//               Consumer<StockProvider>(
//                 builder: (context, provider, _) {
//                   return CommonButton(
//                     title: provider.btnLoader ? 'Saving...' : 'Save Damage Entry',
//                     titleColor: Colors.white,
//                     colors: [ColorPalette.darkGreen, ColorPalette.darkGreen],
//                     onPressed: provider.btnLoader ? null : _saveAll,
//                   );
//                 },
//               ),
//               20.verticalSpace,
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Sub-widgets
// // ─────────────────────────────────────────────────────────────────────────────

// class _Card extends StatelessWidget {
//   final Widget child;
//   const _Card({required this.child});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       padding: EdgeInsets.all(14.w),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.05),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: child,
//     );
//   }
// }

// class _SectionTitle extends StatelessWidget {
//   final String text;
//   const _SectionTitle(this.text);

//   @override
//   Widget build(BuildContext context) {
//     return Text(
//       text,
//       style: TextStyle(
//         fontSize: 13.sp,
//         fontWeight: FontWeight.w700,
//         color: Colors.grey.shade600,
//         letterSpacing: 0.3,
//       ),
//     );
//   }
// }

// class _InfoBanner extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
//       decoration: BoxDecoration(
//         color: Colors.orange.shade50,
//         border: Border.all(color: Colors.orange.shade200),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       child: Row(
//         children: [
//           Icon(Icons.warning_amber_rounded,
//               color: Colors.orange.shade700, size: 22),
//           12.horizontalSpace,
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Record Item Damage',
//                   style: TextStyle(
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.orange.shade800,
//                   ),
//                 ),
//                 4.verticalSpace,
//                 Text(
//                   'Enter only the qty that was damaged/wasted. '
//                   'Stock will be reduced accordingly.',
//                   style: TextStyle(
//                       fontSize: 11.sp, color: Colors.orange.shade700),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class _DamageItemTile extends StatelessWidget {
//   final int index;
//   final Map<String, dynamic> item;
//   final VoidCallback onDelete;

//   const _DamageItemTile({
//     required this.index,
//     required this.item,
//     required this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 8.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         border: Border.all(color: Colors.red.shade100),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 4,
//             offset: const Offset(0, 1),
//           ),
//         ],
//       ),
//       child: ListTile(
//         contentPadding:
//             EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
//         leading: CircleAvatar(
//           radius: 16,
//           backgroundColor: Colors.red.shade100,
//           child: Text(
//             '$index',
//             style: TextStyle(
//               color: Colors.red.shade700,
//               fontWeight: FontWeight.bold,
//               fontSize: 12.sp,
//             ),
//           ),
//         ),
//         title: Text(
//           item['productName']?.toString() ?? '',
//           style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
//         ),
//         subtitle: Text(
//           'Damaged: ${(item['damagedQty'] as double).toStringAsFixed(0)} ${item['unitName']}',
//           style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
//         ),
//         trailing: GestureDetector(
//           onTap: onDelete,
//           child: Icon(Icons.close, size: 18, color: Colors.grey.shade500),
//         ),
//       ),
//     );
//   }
// }








import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/common/color_palette.dart';
import 'package:stock_manager/common/common_button.dart';
import 'package:stock_manager/models/category_model.dart';
import 'package:stock_manager/models/product_model.dart';
import 'package:stock_manager/models/unit_model.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/services/provider_helper_class.dart';

class AddDamageScreen extends StatefulWidget {
  const AddDamageScreen({super.key});

  @override
  State<AddDamageScreen> createState() => _AddDamageScreenState();
}

class _AddDamageScreenState extends State<AddDamageScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _damagedQtyCtrl = TextEditingController();
  final TextEditingController _productCodeCtrl = TextEditingController();
  final TextEditingController _notesCtrl = TextEditingController();

  // Selections
  int? _selectedCategoryId;
  int? _selectedProductId;
  int? _selectedUnitId;
  String? _selectedUnitName;
  String? _selectedProductName;
  DateTime _selectedDate = DateTime.now();

  // Accumulated damage rows
  List<Map<String, dynamic>> _damagedItems = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final p = context.read<StockProvider>();
      p.getProducts();
      p.getUnits();
      p.getCategories();
    });
  }

  @override
  void dispose() {
    _damagedQtyCtrl.dispose();
    _productCodeCtrl.dispose();
    _notesCtrl.dispose();
    super.dispose();
  }

  // ── Date picker ────────────────────────────────────────────────────────────
  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  // ── Add item to list ───────────────────────────────────────────────────────
  void _addItem() {
    if (!_formKey.currentState!.validate()) return;

    final qty = double.parse(_damagedQtyCtrl.text);
    final unitName = _selectedUnitName;

    setState(() {
      _damagedItems.add({
        'productId': _selectedProductId,
        'productName': _selectedProductName ?? 'Product',
        'productCode': _productCodeCtrl.text,
        'unitId': _selectedUnitId,
        'unitName': _selectedUnitName ?? '',
        'damagedQty': qty,
      });

      // Reset item fields only (not date/notes)
      _selectedCategoryId = null;
      _selectedProductId = null;
      _selectedProductName = null;
      _selectedUnitId = null;
      _selectedUnitName = null;
      _damagedQtyCtrl.clear();
      _productCodeCtrl.clear();

      // ✅ Reset stock after adding
      context.read<StockProvider>().availableStock = 0.0;
    });

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
          'Item added — ${qty.toStringAsFixed(0)} ${unitName ?? ''} damaged'),
      backgroundColor: Colors.orange.shade700,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
    ));
  }

  void _saveAll() {
    final hasPartialData =
        _damagedQtyCtrl.text.isNotEmpty || _selectedProductId != null;

    if (hasPartialData) {
      if (!_formKey.currentState!.validate()) return;
      final qty = double.parse(_damagedQtyCtrl.text);
      _damagedItems.add({
        'productId': _selectedProductId,
        'productName': _selectedProductName ?? 'Product',
        'productCode': _productCodeCtrl.text,
        'unitId': _selectedUnitId,
        'unitName': _selectedUnitName ?? '',
        'damagedQty': qty,
      });
    }

    if (_damagedItems.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Please add at least one damaged item'),
        backgroundColor: Colors.red,
      ));
      return;
    }

    context.read<StockProvider>().saveDamage(
      damagedItems: List.from(_damagedItems),
      date: _selectedDate,
      notes: _notesCtrl.text.trim().isEmpty ? null : _notesCtrl.text.trim(),
      onSuccess: () {
        setState(() {
          _damagedItems.clear();
          _selectedCategoryId = null;
          _selectedProductId = null;
          _selectedProductName = null;
          _selectedUnitId = null;
          _selectedUnitName = null;
          _damagedQtyCtrl.clear();
          _productCodeCtrl.clear();
          _notesCtrl.clear();
          _selectedDate = DateTime.now();
          context.read<StockProvider>().availableStock = 0.0;
        });
        Navigator.pop(context, true);
      },
      onFailure: () {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Failed to save damage entry'),
          backgroundColor: Colors.red,
        ));
      },
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0.5,
        iconTheme: const IconThemeData(color: Colors.black87),
        title: Text(
          'Damage Entry',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Info banner ──────────────────────────────────────────────
              _InfoBanner(),
              16.verticalSpace,

              // ── Card: Date ───────────────────────────────────────────────
              _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle('Damage Date'),
                    12.verticalSpace,
                    InkWell(
                      onTap: _pickDate,
                      borderRadius: BorderRadius.circular(8),
                      child: InputDecorator(
                        decoration: const InputDecoration(
                          labelText: 'Select Date',
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.calendar_today, size: 18),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 12, vertical: 14),
                        ),
                        child: Text(
                          DateFormat('dd-MM-yyyy').format(_selectedDate),
                          style: TextStyle(fontSize: 14.sp),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              12.verticalSpace,

              // ── Card: Product ────────────────────────────────────────────
              _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle('Damaged Product'),
                    12.verticalSpace,

                    // Category
                    Consumer<StockProvider>(
                      builder: (_, provider, __) {
                        return DropdownButtonFormField<int>(
                          decoration: InputDecoration(
                            labelText: 'Select Category',
                            border: const OutlineInputBorder(),
                            prefixIcon:
                                provider.loaderState == LoaderState.loading
                                    ? const Padding(
                                        padding: EdgeInsets.all(12),
                                        child: SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                              strokeWidth: 2),
                                        ),
                                      )
                                    : null,
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
                                    child: Text(c.name.toString()),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedCategoryId = val;
                              _selectedProductId = null;
                              _selectedProductName = null;
                              _productCodeCtrl.clear();
                              // ✅ Reset stock when category changes
                              provider.availableStock = 0.0;
                            });
                            provider.getProducts(categoryId: val);
                          },
                          validator: (v) =>
                              v == null ? 'Select category' : null,
                        );
                      },
                    ),
                    12.verticalSpace,

                    // Product
                    Consumer<StockProvider>(
                      builder: (_, provider, __) {
                        return DropdownButtonFormField<int>(
                          decoration: const InputDecoration(
                            labelText: 'Select Product',
                            border: OutlineInputBorder(),
                          ),
                          value: provider.productList
                                  .any((e) => e.id == _selectedProductId)
                              ? _selectedProductId
                              : null,
                          items: provider.productList
                              .fold<List<Datum>>([], (prev, item) {
                                if (!prev.any((e) => e.id == item.id))
                                  prev.add(item);
                                return prev;
                              })
                              .map((p) => DropdownMenuItem(
                                    value: p.id,
                                    child: Text(p.name.toString()),
                                  ))
                              .toList(),
                          onChanged: (val) {
                            setState(() {
                              _selectedProductId = val;
                              final product = provider.productList
                                  .firstWhere((e) => e.id == val);
                              _selectedProductName = product.name;
                              _productCodeCtrl.text = product.code ?? '';
                              _selectedUnitId = product.unit;
                              final unitObj = provider.unitList.firstWhere(
                                (u) => u.id == _selectedUnitId,
                                orElse: () => Unit(id: 0, name: ''),
                              );
                              _selectedUnitName = unitObj.name;
                            });
                            // ✅ Fetch available stock for selected product
                            if (val != null) {
                              provider.getProductStockForDamage(
                                  val.toString());
                            }
                          },
                          validator: (v) =>
                              v == null ? 'Select product' : null,
                        );
                      },
                    ),
                    12.verticalSpace,

                    // Product Code + Unit row
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _productCodeCtrl,
                            readOnly: true,
                            decoration: const InputDecoration(
                              labelText: 'Product Code',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        12.horizontalSpace,
                        Expanded(
                          child: Consumer<StockProvider>(
                            builder: (_, provider, __) {
                              return DropdownButtonFormField<int>(
                                decoration: const InputDecoration(
                                  labelText: 'Unit',
                                  border: OutlineInputBorder(),
                                ),
                                value: provider.unitList
                                        .any((u) => u.id == _selectedUnitId)
                                    ? _selectedUnitId
                                    : null,
                                items: provider.unitList
                                    .map((u) => DropdownMenuItem(
                                          value: u.id,
                                          child: Text(u.name.toString()),
                                        ))
                                    .toList(),
                                onChanged: (val) => setState(() {
                                  _selectedUnitId = val;
                                  _selectedUnitName = provider.unitList
                                      .firstWhere((u) => u.id == val)
                                      .name;
                                }),
                                validator: (v) =>
                                    v == null ? 'Select unit' : null,
                              );
                            },
                          ),
                        ),
                      ],
                    ),

                    // ✅ Available stock indicator
                    Consumer<StockProvider>(
                      builder: (_, provider, __) {
                        if (_selectedProductId == null) {
                          return const SizedBox.shrink();
                        }
                        if (provider.isStockLoading) {
                          return Padding(
                            padding: EdgeInsets.only(top: 10.h),
                            child: Row(
                              children: [
                                const SizedBox(
                                  width: 14,
                                  height: 14,
                                  child: CircularProgressIndicator(
                                      strokeWidth: 2),
                                ),
                                8.horizontalSpace,
                                Text(
                                  'Fetching available stock...',
                                  style: TextStyle(
                                      fontSize: 12.sp,
                                      color: Colors.grey.shade600),
                                ),
                              ],
                            ),
                          );
                        }
                        return Padding(
                          padding: EdgeInsets.only(top: 10.h),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.w, vertical: 8.h),
                            decoration: BoxDecoration(
                              color: provider.availableStock > 0
                                  ? Colors.green.shade50
                                  : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: provider.availableStock > 0
                                    ? Colors.green.shade200
                                    : Colors.red.shade200,
                              ),
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  provider.availableStock > 0
                                      ? Icons.inventory_2_outlined
                                      : Icons.warning_amber_rounded,
                                  size: 16,
                                  color: provider.availableStock > 0
                                      ? Colors.green.shade700
                                      : Colors.red.shade700,
                                ),
                                8.horizontalSpace,
                                Text(
                                  provider.availableStock > 0
                                      ? 'Available Stock: ${provider.availableStock.toStringAsFixed(2)} ${_selectedUnitName ?? ''}'
                                      : 'No stock available for this product',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w600,
                                    color: provider.availableStock > 0
                                        ? Colors.green.shade700
                                        : Colors.red.shade700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              12.verticalSpace,

              // ── Card: Damaged Qty + Notes ─────────────────────────────────
              _Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _SectionTitle('Damage Details'),
                    12.verticalSpace,

                    // Damaged Qty with stock validation
                    Consumer<StockProvider>(
                      builder: (_, provider, __) {
                        return TextFormField(
                          controller: _damagedQtyCtrl,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: 'Damaged Quantity',
                            border: const OutlineInputBorder(),
                            suffixText: _selectedUnitName ?? '',
                            prefixIcon: const Icon(
                                Icons.remove_circle_outline,
                                color: Colors.red),
                          ),
                          onChanged: (_) => setState(() {}),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return 'Enter damaged qty';
                            }
                            if (double.tryParse(v) == null) {
                              return 'Invalid number';
                            }
                            final enteredQty = double.parse(v);
                            if (enteredQty <= 0) {
                              return 'Must be greater than 0';
                            }
                            // ✅ Stock validation
                            if (provider.availableStock > 0 &&
                                enteredQty > provider.availableStock) {
                              return 'Cannot exceed available stock (${provider.availableStock.toStringAsFixed(2)})';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                    16.verticalSpace,

                    // Notes
                    TextFormField(
                      controller: _notesCtrl,
                      maxLines: 2,
                      decoration: const InputDecoration(
                        labelText: 'Reason / Notes',
                        border: OutlineInputBorder(),
                        hintText: 'e.g. Rotten, transport damage...',
                        prefixIcon: Icon(Icons.note_alt_outlined),
                      ),
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Please enter damage reason';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              16.verticalSpace,

              // ── Add item button ───────────────────────────────────────────
              CommonButton(
                title: '+ Add Another Item',
                titleColor: Colors.white,
                colors: [Colors.orange.shade700, Colors.orange.shade700],
                onPressed: _addItem,
              ),

              // ── Added items list ──────────────────────────────────────────
              if (_damagedItems.isNotEmpty) ...[
                16.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _SectionTitle('Damage List (${_damagedItems.length})'),
                    TextButton.icon(
                      onPressed: () => setState(() => _damagedItems.clear()),
                      icon: const Icon(Icons.delete_sweep,
                          size: 16, color: Colors.red),
                      label: Text('Clear All',
                          style:
                              TextStyle(color: Colors.red, fontSize: 12.sp)),
                    ),
                  ],
                ),
                8.verticalSpace,
                ..._damagedItems.asMap().entries.map((entry) {
                  return _DamageItemTile(
                    index: entry.key + 1,
                    item: entry.value,
                    onDelete: () =>
                        setState(() => _damagedItems.removeAt(entry.key)),
                  );
                }),
                12.verticalSpace,
              ],

              // ── Save button ───────────────────────────────────────────────
              Consumer<StockProvider>(
                builder: (context, provider, _) {
                  return CommonButton(
                    title:
                        provider.btnLoader ? 'Saving...' : 'Save Damage Entry',
                    titleColor: Colors.white,
                    colors: [ColorPalette.darkGreen, ColorPalette.darkGreen],
                    onPressed: provider.btnLoader ? null : _saveAll,
                  );
                },
              ),
              20.verticalSpace,
            ],
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Sub-widgets
// ─────────────────────────────────────────────────────────────────────────────

class _Card extends StatelessWidget {
  final Widget child;
  const _Card({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13.sp,
        fontWeight: FontWeight.w700,
        color: Colors.grey.shade600,
        letterSpacing: 0.3,
      ),
    );
  }
}

class _InfoBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.orange.shade50,
        border: Border.all(color: Colors.orange.shade200),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(Icons.warning_amber_rounded,
              color: Colors.orange.shade700, size: 22),
          12.horizontalSpace,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Record Item Damage',
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.orange.shade800,
                  ),
                ),
                4.verticalSpace,
                Text(
                  'Enter only the qty that was damaged/wasted. '
                  'Stock will be reduced accordingly.',
                  style: TextStyle(
                      fontSize: 11.sp, color: Colors.orange.shade700),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DamageItemTile extends StatelessWidget {
  final int index;
  final Map<String, dynamic> item;
  final VoidCallback onDelete;

  const _DamageItemTile({
    required this.index,
    required this.item,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.red.shade100),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 4,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: ListTile(
        contentPadding:
            EdgeInsets.symmetric(horizontal: 14.w, vertical: 4.h),
        leading: CircleAvatar(
          radius: 16,
          backgroundColor: Colors.red.shade100,
          child: Text(
            '$index',
            style: TextStyle(
              color: Colors.red.shade700,
              fontWeight: FontWeight.bold,
              fontSize: 12.sp,
            ),
          ),
        ),
        title: Text(
          item['productName']?.toString() ?? '',
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
        ),
        subtitle: Text(
          'Damaged: ${(item['damagedQty'] as double).toStringAsFixed(0)} ${item['unitName']}',
          style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade600),
        ),
        trailing: GestureDetector(
          onTap: onDelete,
          child: Icon(Icons.close, size: 18, color: Colors.grey.shade500),
        ),
      ),
    );
  }
}