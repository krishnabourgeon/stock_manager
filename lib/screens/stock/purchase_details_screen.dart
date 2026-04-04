import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PurchaseDetailsScreen extends StatelessWidget {
  const PurchaseDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          "Purchase Details",
          style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
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
                    "Product Name",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  // Text("Product Name",style: TextStyle(fontSize: 20.sp),),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  Text(
                    "Product Code: ",
                    style:
                        TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Product Code",
                    style: TextStyle(fontSize: 20.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Invoice Number: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Invoice Number",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Date: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Date",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Supplier: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Supplier",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Category: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Category",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Unit: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Unit",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Quantity: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Quantity",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Purchase Rate: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Purchase Rate",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              ),
              SizedBox(
                height: 9.h,
              ),
              Row(
                children: [
                  Text(
                    "Sales Rate: ",
                    style:
                        TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sales Rate",
                    style: TextStyle(fontSize: 16.sp),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
