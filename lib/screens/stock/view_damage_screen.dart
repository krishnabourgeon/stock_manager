// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:intl/intl.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/providers/stock_provider.dart';
// import 'package:stock_manager/screens/stock/add_damage_screen.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';

// class ViewDamageScreen extends StatefulWidget {
//   const ViewDamageScreen({super.key});

//   @override
//   State<ViewDamageScreen> createState() => _ViewDamageScreenState();
// }

// class _ViewDamageScreenState extends State<ViewDamageScreen> {
//   // ── Date filter — locked to today by default ───────────────────────────────
//   DateTime _filterDate = DateTime.now();

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) => _loadDamages());
//   }

//   Future<void> _loadDamages() async {
//     final dateStr = DateFormat('yyyy-MM-dd').format(_filterDate);
//     await context
//         .read<StockProvider>()
//         .getDamageList(date: dateStr); // see provider method below
//   }

//   // Only allow picking today or earlier, but show only "today" option pill
//   Future<void> _pickDate() async {
//     final picked = await showDatePicker(
//       context: context,
//       initialDate: _filterDate,
//       firstDate: DateTime(2020),
//       lastDate: DateTime.now(), // ← cannot go into future
//       helpText: 'Filter by damage date',
//     );
//     if (picked != null && picked != _filterDate) {
//       setState(() => _filterDate = picked);
//       _loadDamages();
//     }
//   }

//   void _resetToToday() {
//     if (!_isToday(_filterDate)) {
//       setState(() => _filterDate = DateTime.now());
//       _loadDamages();
//     }
//   }

//   bool _isToday(DateTime date) {
//     final now = DateTime.now();
//     return date.year == now.year &&
//         date.month == now.month &&
//         date.day == now.day;
//   }

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
//           'Damage Records',
//           style: TextStyle(
//             fontSize: 18.sp,
//             fontWeight: FontWeight.w600,
//             color: Colors.black87,
//           ),
//         ),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.refresh),
//             onPressed: _loadDamages,
//             tooltip: 'Refresh',
//           ),
//         ],
//       ),

//       // ── FAB — navigate to add damage ─────────────────────────────────────
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () async {
//           final added = await Navigator.push<bool>(
//             context,
//             MaterialPageRoute(builder: (_) => const AddDamageScreen()),
//           );
//           if (added == true) _loadDamages(); // refresh after save
//         },
//         backgroundColor: Colors.red.shade700,
//         icon: const Icon(Icons.add, color: Colors.white),
//         label: Text(
//           'Add Damage',
//           style: TextStyle(color: Colors.white, fontSize: 13.sp),
//         ),
//       ),

//       body: Column(
//         children: [
//           // ── Date filter bar ────────────────────────────────────────────────
//           _DateFilterBar(
//             selectedDate: _filterDate,
//             isToday: _isToday(_filterDate),
//             onPickDate: _pickDate,
//             onTodayTap: _resetToToday,
//           ),

//           // ── List ───────────────────────────────────────────────────────────
//           Expanded(
//             child: Consumer<StockProvider>(
//               builder: (_, provider, __) {
//                 if (provider.loaderState == LoaderState.loading) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final list = provider.damageList; // see provider field below

//                 if (list.isEmpty) {
//                   return _EmptyState(date: _filterDate);
//                 }

//                 return ListView.builder(
//                   padding: EdgeInsets.all(14.w),
//                   itemCount: list.length,
//                   itemBuilder: (_, i) => _DamageRecordCard(
//                     index: i + 1,
//                     item: list[i],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Date filter bar
// // ─────────────────────────────────────────────────────────────────────────────
// class _DateFilterBar extends StatelessWidget {
//   final DateTime selectedDate;
//   final bool isToday;
//   final VoidCallback onPickDate;
//   final VoidCallback onTodayTap;

//   const _DateFilterBar({
//     required this.selectedDate,
//     required this.isToday,
//     required this.onPickDate,
//     required this.onTodayTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Colors.white,
//       padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
//       child: Row(
//         children: [
//           // Today chip
//           GestureDetector(
//             onTap: onTodayTap,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding:
//                   EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
//               decoration: BoxDecoration(
//                 color: isToday ? Colors.red.shade700 : Colors.grey.shade100,
//                 borderRadius: BorderRadius.circular(20),
//                 border: Border.all(
//                   color: isToday ? Colors.red.shade700 : Colors.grey.shade300,
//                 ),
//               ),
//               child: Text(
//                 'Today',
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w600,
//                   color: isToday ? Colors.white : Colors.grey.shade600,
//                 ),
//               ),
//             ),
//           ),
//           12.horizontalSpace,

//           // Date picker chip
//           Expanded(
//             child: GestureDetector(
//               onTap: onPickDate,
//               child: Container(
//                 padding:
//                     EdgeInsets.symmetric(horizontal: 14.w, vertical: 7.h),
//                 decoration: BoxDecoration(
//                   color: !isToday ? Colors.red.shade50 : Colors.grey.shade100,
//                   borderRadius: BorderRadius.circular(20),
//                   border: Border.all(
//                     color: !isToday
//                         ? Colors.red.shade300
//                         : Colors.grey.shade300,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Icon(
//                       Icons.calendar_today,
//                       size: 14,
//                       color: !isToday
//                           ? Colors.red.shade700
//                           : Colors.grey.shade500,
//                     ),
//                     6.horizontalSpace,
//                     Text(
//                       DateFormat('dd MMM yyyy').format(selectedDate),
//                       style: TextStyle(
//                         fontSize: 12.sp,
//                         fontWeight: FontWeight.w600,
//                         color: !isToday
//                             ? Colors.red.shade700
//                             : Colors.grey.shade600,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // Damage record card
// // ─────────────────────────────────────────────────────────────────────────────
// class _DamageRecordCard extends StatelessWidget {
//   final int index;
//   final Map<String, dynamic> item; // shape from getDamageList response

//   const _DamageRecordCard({required this.index, required this.item});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsets.only(bottom: 10.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(12),
//         border: Border.all(color: Colors.red.shade50),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 6,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Padding(
//         padding: EdgeInsets.all(14.w),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Index circle
//             Container(
//               width: 32,
//               height: 32,
//               alignment: Alignment.center,
//               decoration: BoxDecoration(
//                 color: Colors.red.shade100,
//                 shape: BoxShape.circle,
//               ),
//               child: Text(
//                 '$index',
//                 style: TextStyle(
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.red.shade700,
//                 ),
//               ),
//             ),
//             12.horizontalSpace,

//             // Details
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     item['product_name']?.toString() ??
//                         'Product #${item['product_id']}',
//                     style: TextStyle(
//                       fontSize: 14.sp,
//                       fontWeight: FontWeight.w600,
//                       color: Colors.black87,
//                     ),
//                   ),
//                   6.verticalSpace,
//                   Wrap(
//                     spacing: 12,
//                     runSpacing: 4,
//                     children: [
//                       _InfoChip(
//                         icon: Icons.remove_circle_outline,
//                         label: 'Qty: ${item['qty']} ${item['unit'] ?? ''}',
//                         color: Colors.red,
//                       ),
//                       if ((item['reason'] ?? '').toString().isNotEmpty)
//                         _InfoChip(
//                           icon: Icons.note_alt_outlined,
//                           label: item['reason'].toString(),
//                           color: Colors.orange,
//                         ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),

//             // Date badge
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               children: [
//                 Container(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: 8.w, vertical: 3.h),
//                   decoration: BoxDecoration(
//                     color: Colors.red.shade50,
//                     borderRadius: BorderRadius.circular(6),
//                   ),
//                   child: Text(
//                     _formatDate(item['date']?.toString() ?? ''),
//                     style: TextStyle(
//                       fontSize: 10.sp,
//                       color: Colors.red.shade700,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   String _formatDate(String raw) {
//     try {
//       return DateFormat('dd MMM').format(DateTime.parse(raw));
//     } catch (_) {
//       return raw;
//     }
//   }
// }

// class _InfoChip extends StatelessWidget {
//   final IconData icon;
//   final String label;
//   final Color color;

//   const _InfoChip(
//       {required this.icon, required this.label, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisSize: MainAxisSize.min,
//       children: [
//         Icon(icon, size: 13, color: color.withOpacity(0.7)),
//         4.horizontalSpace,
//         Text(
//           label,
//           style: TextStyle(
//             fontSize: 11.sp,
//             color: Colors.grey.shade700,
//           ),
//         ),
//       ],
//     );
//   }
// }

// class _EmptyState extends StatelessWidget {
//   final DateTime date;
//   const _EmptyState({required this.date});

//   @override
//   Widget build(BuildContext context) {
//     final isToday = date.day == DateTime.now().day &&
//         date.month == DateTime.now().month &&
//         date.year == DateTime.now().year;

//     return Center(
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Icon(Icons.inventory_2_outlined,
//               size: 56, color: Colors.grey.shade300),
//           16.verticalSpace,
//           Text(
//             isToday
//                 ? 'No damage records for today'
//                 : 'No records for ${DateFormat('dd MMM yyyy').format(date)}',
//             style: TextStyle(
//               fontSize: 14.sp,
//               color: Colors.grey.shade500,
//             ),
//           ),
//           8.verticalSpace,
//           Text(
//             'Tap + Add Damage to record one',
//             style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade400),
//           ),
//         ],
//       ),
//     );
//   }
// }