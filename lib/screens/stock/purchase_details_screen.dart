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
              ? const Center(child: Text("No stock history found"))
              : ListView.builder(
                  padding: const EdgeInsets.all(20),
                  itemCount: provider.viewProductStockList.length,
                  itemBuilder: (context, index) {
                    final item = provider.viewProductStockList[index];

                    return Container(
                      margin: EdgeInsets.only(bottom: 15.h),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey.shade300)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                "Product Name: ",
                                style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.productName,
                                style: TextStyle(fontSize: 18.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Text(
                                "Product Code: ",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.productCode,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 9.h),
                          Row(
                            children: [
                              Text(
                                "Invoice Number: ",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.invoiceNo,
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 9.h),
                          Row(
                            children: [
                              Text(
                                "Date: ",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                DateFormat('dd-MM-yyyy').format(item.addedDate),
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 9.h),
                          Row(
                            children: [
                              Text(
                                "Mode: ",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                item.mode,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: item.mode.toLowerCase().contains("in") 
                                    ? Colors.green 
                                    : Colors.red,
                                  fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 9.h),
                          Row(
                            children: [
                              Text(
                                "Quantity: ",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${item.qty}",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                          SizedBox(height: 9.h),
                          Row(
                            children: [
                              Text(
                                "Sales Rate: ",
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "${item.salesRate ?? '0'}",
                                style: TextStyle(fontSize: 16.sp),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
    );
  }
}
