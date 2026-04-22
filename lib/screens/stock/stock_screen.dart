import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stock_manager/screens/stock/add_product.dart';
import 'package:stock_manager/screens/stock/add_stock.dart';
import 'package:stock_manager/screens/stock/aded_category.dart';
import 'package:stock_manager/screens/stock/view_product.dart';
import 'package:stock_manager/screens/stock/view_purchase.dart';
import 'package:stock_manager/screens/stock/view_stock.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("Stock"),
      //   centerTitle: true,
      // ),

      ///  4 CONTAINERS
      body: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
           Stack(
            children: [
              Image.asset(
                'assets/image/green_dashboard.jpeg',
                width: double.maxFinite,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 45.h,
                left: 20.w,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Icon(
                        Icons.home,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                  Text(
                    'Stock Management',
                    style: TextStyle(
                      color: Colors.white, fontSize: 21.sp),
                  ),
                  Text(
                    'Manage your inventory efficiently',
                    style: TextStyle(
                      color: Colors.white, fontSize: 14.sp),
                  ),
                ],
              ),
              )
            ],
          ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: buildContainer(
                          title: "View Purchase",
                          color:Color(0xFF4CAF50),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ViewPurchase(),
                              ),
                            );
                          },
                        ),
                      ),
                      
                      20.horizontalSpace,
                      Expanded(
                        child: buildContainer(
                          title: "Add Purchase",
                          color: const Color(0xFF2196F3),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AddStock(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                    
              20.verticalSpace,
                    
              ///  ROW 2
              Row(
                children: [
                  Expanded(
                    child: buildContainer(
                      title: "View Stock",
                      color: const Color(0xFFFFC107),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewStock(),
                          ),
                        );
                      },
                    ),
                  ),
                  20.horizontalSpace,
                  Expanded(
                    child: buildContainer(
                      title: "Add Product",
                      color:const Color(0xFFF44336),
                      onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddProduct(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
              20.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: buildContainer(
                      title: "View Product",
                      color:const Color(0xFF9C27B0) ,
                      onTap: () {
                         Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ViewProduct(),
                          ),
                        );
                      },
                    ),
                  ),
                  20.horizontalSpace,
        
                  Expanded(
                    child: buildContainer(
                      title: "Add Category",
                      color:Colors.orangeAccent,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AddCategoryScreen(),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  ///  COMMON CONTAINER
  Widget buildContainer({
    required String title,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 150.h,
          width: 150.w,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}