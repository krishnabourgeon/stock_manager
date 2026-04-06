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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<StockProvider>().getViewProductStock(widget.productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<StockProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          widget.productName,
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: provider.loaderState == LoaderState.loading
          ? const Center(child: CircularProgressIndicator())
          : provider.viewProductStockList.isEmpty
              ? const Center(child: Text("No stock found"))
              : Padding(
                  padding: EdgeInsets.all(10.w),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        headingRowColor: WidgetStateProperty.all(Colors.green),
                        headingTextStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14.sp,
                        ),
                        columnSpacing: 25.w,
                        border: TableBorder.all(color: Colors.grey.shade200),
                        columns: const [
                          DataColumn(label: Text('Sl.No')),
                          DataColumn(label: Text('Code')),
                          DataColumn(label: Text('Date')),
                          DataColumn(label: Text('Invoice No')),
                          DataColumn(label: Text('Mode')),
                          DataColumn(label: Text('Qty')),
                         // DataColumn(label: Text('Qty Out')),
                          DataColumn(label: Text('Sales Rate')),
                        ],
                        rows: provider.viewProductStockList
                            .asMap()
                            .entries
                            .map((entry) {
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
                                DateFormat('dd-MM-yyyy').format(item.addedDate))),
                            DataCell(Text(item.invoiceNo)),
                            DataCell(
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 4.h),
                                decoration: BoxDecoration(
                                  color: isIn
                                      ? Colors.green.withOpacity(0.1)
                                      : Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(
                                  item.mode,
                                  style: TextStyle(
                                    color: isIn ? Colors.green : Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            // DataCell(Text(
                            //   isIn ? "${item.qty}" : "-",
                            //   style: TextStyle(
                            //       color: isIn ? Colors.green : Colors.black,
                            //       fontWeight: isIn ? FontWeight.bold : null),
                            // )),
                            DataCell(Text(
                              !isIn ? "${item.qty}" : "-",
                              style: TextStyle(
                                  color: !isIn ? Colors.red : Colors.black,
                                  fontWeight: !isIn ? FontWeight.bold : null),
                            )),
                            DataCell(Text("${item.salesRate ?? '0'}")),
                          ],
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ),
    );
  }
}
