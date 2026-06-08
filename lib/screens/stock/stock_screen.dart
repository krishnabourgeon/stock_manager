// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:stock_manager/screens/stock/add_product.dart';
// import 'package:stock_manager/screens/stock/add_stock.dart';
// import 'package:stock_manager/screens/stock/aded_category.dart';
// import 'package:stock_manager/screens/stock/product_sales_report_screen.dart';
// import 'package:stock_manager/screens/stock/add_supplier_screen.dart';
// import 'package:stock_manager/screens/stock/view_product.dart';
// import 'package:stock_manager/screens/stock/view_purchase.dart';
// import 'package:stock_manager/screens/stock/view_stock.dart';

// class StockScreen extends StatefulWidget {
//   const StockScreen({super.key});

//   @override
//   State<StockScreen> createState() => _StockScreenState();
// }

// class _StockScreenState extends State<StockScreen> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       // appBar: AppBar(
//       //   title: const Text("Stock"),
//       //   centerTitle: true,
//       // ),

//       ///  4 CONTAINERS
//       body: SingleChildScrollView(
//         child: Column(
//           //mainAxisAlignment: MainAxisAlignment.center,
//           children: [
        
//            Stack(
//             children: [
//               Image.asset(
//                 'assets/image/green_dashboard.jpeg',
//                 width: double.maxFinite,
//                 fit: BoxFit.contain,
//               ),
//               Positioned(
//                 top: 45.h,
//                 left: 20.w,
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     InkWell(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: const Icon(
//                         Icons.home,
//                         color: Colors.white,
//                         size: 30,
//                       ),
//                     ),
//                     SizedBox(
//                       height: 10.h,
//                     ),
//                   Text(
//                     'Stock Management',
//                     style: TextStyle(
//                       color: Colors.white, fontSize: 21.sp),
//                   ),
//                   Text(
//                     'Manage your inventory efficiently',
//                     style: TextStyle(
//                       color: Colors.white, fontSize: 14.sp),
//                   ),
//                 ],
//               ),
//               )
//             ],
//           ),
//             Padding(
//               padding: const EdgeInsets.all(15),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Row(
//                 children: [
//                   Expanded(
//                     child: buildContainer(
//                       title: "Add Category",
//                       color:const Color(0xFF9C27B0) ,
//                       onTap: () {
//                          Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const AddCategoryScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   20.horizontalSpace,
        
//                   Expanded(
//                     child: buildContainer(
//                       title: "Add Supplier",
//                       color:Colors.orangeAccent,
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const SupplierScreen(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               20.verticalSpace,
//                   Row(
//                     children: [
//                       Expanded(
//                         child: buildContainer(
//                           title: "Add Product",
//                           color:Color.fromARGB(255, 137, 175, 76),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const AddProduct(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
                      
//                       20.horizontalSpace,
//                       Expanded(
//                         child: buildContainer(
//                           title: "View Product",
//                           color: const Color.fromARGB(255, 10, 66, 112),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const ViewProduct(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   20.verticalSpace,
//                   Row(
//                     children: [
//                       Expanded(
//                         child: buildContainer(
//                           title: "Add Purchase",
//                           color:Color(0xFF4CAF50),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const AddStock(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
                      
//                       20.horizontalSpace,
//                       Expanded(
//                         child: buildContainer(
//                           title: "View Purchase",
//                           color: const Color(0xFF2196F3),
//                           onTap: () {
//                             Navigator.push(
//                               context,
//                               MaterialPageRoute(
//                                 builder: (context) => const ViewStock(),
//                               ),
//                             );
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
                    
//               20.verticalSpace,
                    
//               ///  ROW 2
//               Row(
//                 children: [
//                   Expanded(
//                     child: buildContainer(
//                       title: "View Stock",
//                       color: const Color(0xFFFFC107),
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                             builder: (context) => const ViewStock(),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                   20.horizontalSpace,
//                   // Expanded(
//                   //   child: buildContainer(
//                   //     title: "Sales Report",
//                   //     color:const Color(0xFFF44336),
//                   //     onTap: () {
//                   //        Navigator.push(
//                   //         context,
//                   //         MaterialPageRoute(
//                   //           builder: (context) => const ProductSalesReportScreen(),
//                   //         ),
//                   //       );
//                   //     },
//                   //   ),
//                   // ),
//                 ],
//               ),
//               20.verticalSpace,
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   ///  COMMON CONTAINER
//   Widget buildContainer({
//     required String title,
//     required Color color,
//     required VoidCallback onTap,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       child: Container(
//         height: 150.h,
//           width: 150.w,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           color: color,
//           borderRadius: BorderRadius.circular(12),
//         ),
//         child: Text(
//           title,
//           textAlign: TextAlign.center,
//           style: const TextStyle(
//             color: Colors.white,
//             fontSize: 16,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_manager/screens/stock/add_damage_screen.dart';
import 'package:stock_manager/screens/stock/add_product.dart';
import 'package:stock_manager/screens/stock/add_stock.dart';
import 'package:stock_manager/screens/stock/aded_category.dart';
import 'package:stock_manager/screens/stock/add_supplier_screen.dart';
import 'package:stock_manager/screens/stock/view_damage_screen.dart';
import 'package:stock_manager/screens/stock/view_product.dart';
import 'package:stock_manager/screens/stock/view_purchase.dart';
import 'package:stock_manager/screens/stock/view_stock.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animController;

  final List<_MenuItemData> _menuItems = [
    _MenuItemData(
      title: "Add Category",
      subtitle: "Create new groups",
      icon: Icons.category_outlined,
      accentColor: Color(0xFFB06AE8),
    ),
    _MenuItemData(
      title: "Add Supplier",
      subtitle: "Register vendors",
      icon: Icons.storefront_outlined,
      accentColor: Color(0xFFFF8C42),
    ),
    _MenuItemData(
      title: "Add Product",
      subtitle: "List new items",
      icon: Icons.inventory_2_outlined,
      accentColor: Color(0xFF2EAF73),
    ),
    _MenuItemData(
      title: "View Product",
      subtitle: "Browse catalog",
      icon: Icons.view_list_outlined,
      accentColor: Color(0xFF2878C8),
    ),
    _MenuItemData(
      title: "Add Purchase",
      subtitle: "Record buying",
      icon: Icons.add_shopping_cart_outlined,
      accentColor: Color(0xFF27AE60),
    ),
    _MenuItemData(
      title: "View Purchase",
      subtitle: "Purchase history",
      icon: Icons.receipt_long_outlined,
      accentColor: Color(0xFF0288D1),
    ),
    _MenuItemData(
      title: "View Stock",
      subtitle: "Current inventory",
      icon: Icons.warehouse_outlined,
      accentColor: Color(0xFFF5A623),
    ),
    _MenuItemData(
      title: "Damage Stock",
      subtitle: "Add damaged items",
      icon: Icons.remove,
      accentColor: Color(0xFFF5A623),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  void _navigate(BuildContext context, int index) {
    final routes = [
      const AddCategoryScreen(),
      const SupplierScreen(),
      const AddProduct(),
      const ViewProduct(),
      const AddStock(),
      const ViewPurchase(),
      const ViewStock(),
      const ViewDamageScreen()
    ];
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => routes[index]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),
      body: CustomScrollView(
        slivers: [
          // ─── HEADER ──────────────────────────────────────────────────────
          SliverToBoxAdapter(child: _buildHeader(context)),

          // ─── STATS ROW ───────────────────────────────────────────────────
          //SliverToBoxAdapter(child: _buildStatsRow()),

          // ─── SECTION LABEL ───────────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.fromLTRB(20.w, 24.h, 20.w, 14.h),
              child: Row(
                children: [
                  Container(
                    width: 3.w,
                    height: 18.h,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    "QUICK ACTIONS",
                    style: GoogleFonts.rajdhani(
                      color: Colors.black54,
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 2.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── GRID ────────────────────────────────────────────────────────
          SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final delay = index * 0.08;
                  final animation = CurvedAnimation(
                    parent: _animController,
                    curve: Interval(
                      delay.clamp(0.0, 1.0),
                      (delay + 0.4).clamp(0.0, 1.0),
                      curve: Curves.easeOutCubic,
                    ),
                  );
                  return AnimatedBuilder(
                    animation: animation,
                    builder: (_, child) => Opacity(
                      opacity: animation.value,
                      child: Transform.translate(
                        offset: Offset(0, 24 * (1 - animation.value)),
                        child: child,
                      ),
                    ),
                    child: _buildMenuCard(context, _menuItems[index], index),
                  );
                },
                childCount: _menuItems.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 14.h,
                crossAxisSpacing: 14.w,
                childAspectRatio: 1.15,
              ),
            ),
          ),

          SliverToBoxAdapter(child: SizedBox(height: 32.h)),
        ],
      ),
    );
  }

  // ─── HEADER ────────────────────────────────────────────────────────────
  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 56.h, 20.w, 28.h),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B5E20),
            Color(0xFF2E7D32),
            Color(0xFF388E3C),
          ],
        ),
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE), width: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: const Color(0xFFE0E0E0)),
                  ),
                  child: const Icon(
                    Icons.home_outlined,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              // Container(
              //   padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFFE8F5E9),
              //     borderRadius: BorderRadius.circular(20),
              //     border: Border.all(color: const Color(0xFFA5D6A7)),
              //   ),
              //   child: Row(
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Container(
              //         width: 6,
              //         height: 6,
              //         decoration: const BoxDecoration(
              //           color: Color(0xFF27AE60),
              //           shape: BoxShape.circle,
              //         ),
              //       ),
              //       SizedBox(width: 6.w),
              //       Text(
              //         "LIVE",
              //         style: GoogleFonts.rajdhani(
              //           color: const Color(0xFF27AE60),
              //           fontSize: 11.sp,
              //           fontWeight: FontWeight.w700,
              //           letterSpacing: 1.5,
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
            ],
          ),

          SizedBox(height: 22.h),

          Text(
            "Stock",
            style: GoogleFonts.rajdhani(
              color: const Color(0xFFF5A623),
              fontSize: 13.sp,
              fontWeight: FontWeight.w700,
              letterSpacing: 3,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            "Management",
            style: GoogleFonts.rajdhani(
              color:  Colors.white,
              fontSize: 34.sp,
              fontWeight: FontWeight.w700,
              height: 1.0,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            "Manage your inventory efficiently",
            style: GoogleFonts.rajdhani(
              color: Colors.white,
              fontSize: 14.sp,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // ─── STATS ROW ─────────────────────────────────────────────────────────
  Widget _buildStatsRow() {
    return Container(
      margin: EdgeInsets.fromLTRB(16.w, 20.h, 16.w, 0),
      padding: EdgeInsets.symmetric(vertical: 14.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: const Color(0xFFE8E8E8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildStatItem("7", "Modules", const Color(0xFFF5A623)),
          _buildStatDivider(),
          _buildStatItem("Active", "Status", const Color(0xFF27AE60)),
          _buildStatDivider(),
          _buildStatItem("v2.0", "Version", const Color(0xFF2878C8)),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, Color color) {
    return Expanded(
      child: Column(
        children: [
          Text(
            value,
            style: GoogleFonts.rajdhani(
              color: color,
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 2.h),
          Text(
            label,
            style: GoogleFonts.rajdhani(
              color: Colors.black38,
              fontSize: 11.sp,
              letterSpacing: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 30.h,
      color: const Color(0xFFE8E8E8),
    );
  }

  // ─── MENU CARD ─────────────────────────────────────────────────────────
  Widget _buildMenuCard(BuildContext context, _MenuItemData item, int index) {
    return GestureDetector(
      onTap: () => _navigate(context, index),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: item.accentColor.withOpacity(0.2),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: item.accentColor.withOpacity(0.1),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background tint orb
            Positioned(
              top: -18,
              right: -18,
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.accentColor.withOpacity(0.07),
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Icon box
                  Container(
                    width: 44.w,
                    height: 44.h,
                    decoration: BoxDecoration(
                      color: item.accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: item.accentColor.withOpacity(0.3),
                      ),
                    ),
                    child: Icon(
                      item.icon,
                      color: item.accentColor,
                      size: 22,
                    ),
                  ),

                  // Text section
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.rajdhani(
                          color: const Color(0xFF1A1A2E),
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.3,
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.subtitle,
                            style: GoogleFonts.rajdhani(
                              color: Colors.black38,
                              fontSize: 11.sp,
                              letterSpacing: 0.3,
                            ),
                          ),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: item.accentColor.withOpacity(0.12),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: item.accentColor,
                              size: 10,
                            ),
                          ),
                        ],
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
}

// ─── DATA MODEL ──────────────────────────────────────────────────────────────
class _MenuItemData {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  const _MenuItemData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.accentColor,
  });
}