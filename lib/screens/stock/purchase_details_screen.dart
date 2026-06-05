// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/providers/stock_provider.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';
// import 'package:intl/intl.dart';

// class PurchaseDetailsScreen extends StatefulWidget {
//   final String productId;
//   final String productName;

//   const PurchaseDetailsScreen({
//     super.key,
//     required this.productId,
//     required this.productName,
//   });

//   @override
//   State<PurchaseDetailsScreen> createState() => _PurchaseDetailsScreenState();
// }

// class _PurchaseDetailsScreenState extends State<PurchaseDetailsScreen> {
//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<StockProvider>().getViewProductStock(widget.productId);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final provider = context.watch<StockProvider>();

//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.green,
//         title: Text(
//           widget.productName,
//           style: TextStyle(
//               fontSize: 20.sp,
//               fontWeight: FontWeight.bold,
//               color: Colors.white),
//         ),
//         centerTitle: true,
//       ),
//       body: provider.loaderState == LoaderState.loading
//           ? const Center(child: CircularProgressIndicator())
//           : provider.viewProductStockList.isEmpty
//               ? const Center(child: Text("No stock found"))
//               : Padding(
//                   padding: EdgeInsets.all(10.w),
//                   child: SingleChildScrollView(
//                     scrollDirection: Axis.vertical,
//                     child: SingleChildScrollView(
//                       scrollDirection: Axis.horizontal,
//                       child: DataTable(
//                         headingRowColor: WidgetStateProperty.all(Colors.green),
//                         headingTextStyle: TextStyle(
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14.sp,
//                         ),
//                         columnSpacing: 25.w,
//                         border: TableBorder.all(color: Colors.grey.shade200),
//                         columns: const [
//                           DataColumn(label: Text('Sl.No')),
//                           DataColumn(label: Text('Code')),
//                           DataColumn(label: Text('Date')),
//                           DataColumn(label: Text('Invoice No')),
//                           DataColumn(label: Text('Mode')),
//                           DataColumn(label: Text('Qty')),
//                          // DataColumn(label: Text('Qty Out')),
//                           DataColumn(label: Text('Sales Rate')),
//                         ],
//                         rows: provider.viewProductStockList
//                             .asMap()
//                             .entries
//                             .map((entry) {
//                           final index = entry.key;
//                           final item = entry.value;
//                           final bool isIn =
//                               item.mode.toLowerCase().contains("in");
//                           return DataRow(
//                             color: WidgetStateProperty.all(index % 2 != 0
//                                 ? Colors.grey.shade50
//                                 : Colors.white),
//                             cells: [
//                               DataCell(Text((index + 1).toString())),
//                               DataCell(Text(item.productCode)),
//                             DataCell(Text(
//                                 DateFormat('dd-MM-yyyy').format(item.addedDate))),
//                             DataCell(Text(item.invoiceNo)),
//                             DataCell(
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 8.w, vertical: 4.h),
//                                 decoration: BoxDecoration(
//                                   color: isIn
//                                       ? Colors.green.withOpacity(0.1)
//                                       : Colors.red.withOpacity(0.1),
//                                   borderRadius: BorderRadius.circular(4),
//                                 ),
//                                 child: Text(
//                                   item.mode,
//                                   style: TextStyle(
//                                     color: isIn ? Colors.green : Colors.red,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             // DataCell(Text(
//                             //   isIn ? "${item.qty}" : "-",
//                             //   style: TextStyle(
//                             //       color: isIn ? Colors.green : Colors.black,
//                             //       fontWeight: isIn ? FontWeight.bold : null),
//                             // )),
//                             DataCell(Text(
//                               !isIn ? "${item.qty}" : "-",
//                               style: TextStyle(
//                                   color: !isIn ? Colors.red : Colors.black,
//                                   fontWeight: !isIn ? FontWeight.bold : null),
//                             )),
//                             DataCell(Text("${item.salesRate ?? '0'}")),
//                           ],
//                         );
//                       }).toList(),
//                     ),
//                   ),
//                 ),
//               ),
//     );
//   }
// }




import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/providers/stock_provider.dart';
import 'package:stock_manager/services/provider_helper_class.dart';
import 'package:intl/intl.dart';

class PurchaseDetailsScreen extends StatefulWidget {
  final String productId;
  final String productName;

  const PurchaseDetailsScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  State<PurchaseDetailsScreen> createState() => _PurchaseDetailsScreenState();
}

class _PurchaseDetailsScreenState extends State<PurchaseDetailsScreen> {
  DateTime? _fromDate;
  DateTime? _toDate;
  final DateFormat _displayFormat = DateFormat('dd-MM-yyyy');

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().getViewProductStock(widget.productId);
    });
  }

  Future<void> _pickDate({required bool isFrom}) async {
    final now = DateTime.now();
    final initial = isFrom
        ? (_fromDate ?? now)
        : (_toDate ?? now);

    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(2000),
      lastDate: now,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.green,
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked == null) return;

    setState(() {
      if (isFrom) {
        _fromDate = picked;
        // Reset toDate if it's before the new fromDate
        if (_toDate != null && _toDate!.isBefore(picked)) {
          _toDate = null;
        }
      } else {
        _toDate = picked;
      }
    });
  }

  void _clearFilters() {
    setState(() {
      _fromDate = null;
      _toDate = null;
    });
  }

  List<dynamic> _filteredList(List<dynamic> list) {
    if (_fromDate == null && _toDate == null) return list;

    return list.where((item) {
      final date = item.addedDate as DateTime;
      final from = _fromDate != null
          ? DateTime(_fromDate!.year, _fromDate!.month, _fromDate!.day)
          : null;
      final to = _toDate != null
          ? DateTime(_toDate!.year, _toDate!.month, _toDate!.day, 23, 59, 59)
          : null;

      if (from != null && date.isBefore(from)) return false;
      if (to != null && date.isAfter(to)) return false;
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StockProvider>();
    final filteredList = _filteredList(provider.viewProductStockList);
    final bool hasFilter = _fromDate != null || _toDate != null;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          widget.productName,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // ── Date Filter Bar ──────────────────────────────────────────
          Container(
            color: Colors.green.shade50,
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
            child: Row(
              children: [
                // From Date
                Expanded(
                  child: _DatePickerField(
                    label: 'From',
                    value: _fromDate != null
                        ? _displayFormat.format(_fromDate!)
                        : null,
                    onTap: () => _pickDate(isFrom: true),
                  ),
                ),
                SizedBox(width: 10.w),
                // To Date
                Expanded(
                  child: _DatePickerField(
                    label: 'To',
                    value: _toDate != null
                        ? _displayFormat.format(_toDate!)
                        : null,
                    onTap: () => _pickDate(isFrom: false),
                  ),
                ),
                SizedBox(width: 8.w),
                // Clear button — only visible when a filter is active
                if (hasFilter)
                  GestureDetector(
                    onTap: _clearFilters,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.red.shade200),
                      ),
                      child: Icon(Icons.close,
                          size: 18.sp, color: Colors.red.shade400),
                    ),
                  ),
              ],
            ),
          ),

          // ── Result count chip ────────────────────────────────────────
          if (provider.loaderState != LoaderState.loading &&
              provider.viewProductStockList.isNotEmpty)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  hasFilter
                      ? '${filteredList.length} of ${provider.viewProductStockList.length} records'
                      : '${filteredList.length} records',
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),

          // ── Table ────────────────────────────────────────────────────
          Expanded(
            child: provider.loaderState == LoaderState.loading
                ? const Center(child: CircularProgressIndicator())
                : filteredList.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.search_off,
                                size: 48.sp, color: Colors.grey.shade400),
                            SizedBox(height: 8.h),
                            Text(
                              hasFilter
                                  ? 'No records found for the\nselected date range'
                                  : 'No stock found',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: EdgeInsets.all(10.w),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              headingRowColor:
                                  WidgetStateProperty.all(Colors.green),
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
                                //DataColumn(label: Text('Invoice No')),
                                DataColumn(label: Text('Mode')),
                                DataColumn(label: Text('Qty')),
                                //DataColumn(label: Text('Sales Rate')),
                              ],
                              rows: filteredList.asMap().entries.map((entry) {
                                final index = entry.key;
                                final item = entry.value;
                                final bool isIn =
                                    item.mode.toLowerCase().contains("in");
                                return DataRow(
                                  color: WidgetStateProperty.all(index % 2 != 0
                                      ? Colors.grey.shade50
                                      : Colors.white),
                                  cells: [
                                    DataCell(Text((index + 1).toString())),
                                    DataCell(Text(item.productCode)),
                                    DataCell(Text(
                                        _displayFormat.format(item.addedDate))),
                                    //DataCell(Text(item.invoiceNo)),
                                    DataCell(
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 8.w, vertical: 4.h),
                                        decoration: BoxDecoration(
                                          color: isIn
                                              ? Colors.green.withOpacity(0.1)
                                              : Colors.red.withOpacity(0.1),
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        child: Text(
                                          item.mode,
                                          style: TextStyle(
                                            color: isIn
                                                ? Colors.green
                                                : Colors.red,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    DataCell(Text(
                                      !isIn ? "${item.qty}" : "-",
                                      style: TextStyle(
                                          color: !isIn
                                              ? Colors.red
                                              : Colors.black,
                                          fontWeight: !isIn
                                              ? FontWeight.bold
                                              : null),
                                    )),
                                    // DataCell(
                                    //     Text("${item.salesRate ?? '0'}")),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

// ── Reusable date picker field widget ──────────────────────────────────────────
class _DatePickerField extends StatelessWidget {
  final String label;
  final String? value;
  final VoidCallback onTap;

  const _DatePickerField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasValue = value != null;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: hasValue ? Colors.green : Colors.grey.shade300,
            width: hasValue ? 1.5 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_today_outlined,
              size: 16.sp,
              color: hasValue ? Colors.green : Colors.grey.shade500,
            ),
            SizedBox(width: 6.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.grey.shade500,
                      height: 1.2,
                    ),
                  ),
                  Text(
                    hasValue ? value! : 'Select',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight:
                          hasValue ? FontWeight.w600 : FontWeight.normal,
                      color: hasValue ? Colors.black87 : Colors.grey.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}