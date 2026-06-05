// // import 'dart:async';
// // import 'dart:developer';
// // // import 'package:blue_thermal_printer/blue_thermal_printer.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:flutter_screenutil/flutter_screenutil.dart';
// // import 'package:flutter_svg/svg.dart';
// // import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// // // import 'package:permission_handler/permission_handler.dart';
// // import 'package:provider/provider.dart';
// // import 'package:stock_manager/common/color_palette.dart';
// // import 'package:stock_manager/common/common_button.dart';
// // import 'package:stock_manager/common/common_functions.dart';
// // import 'package:stock_manager/common/extension.dart';
// // import 'package:stock_manager/common/select_card.dart';
// // import 'package:stock_manager/providers/billing_provider.dart';
// // import 'package:stock_manager/providers/home_provider.dart';
// // // import 'package:stock_manager/screens/home/quick_bill.dart';
// // import 'package:stock_manager/screens/login/login.dart';
// // import 'package:stock_manager/services/app_config.dart';
// // import 'package:stock_manager/services/helpers.dart';
// // import 'package:stock_manager/services/provider_helper_class.dart';
// // import 'package:stock_manager/services/shared_preference_helper.dart';
// // import 'package:stock_manager/models/counters_model.dart';
// // import 'package:url_launcher/url_launcher.dart';

// // class Home extends StatefulWidget {
// //   const Home({super.key});
// //   @override
// //   State<Home> createState() => _HomeState();
// // }

// // class _HomeState extends State<Home> {
// //   List<String> titleCards = [
// //     "Billing",
// //     "Bill List",
// //     'Sales Summary',
// //     //'Counter Wise Summary',
// //     "Stock"
// //   ];
// //   // BlueThermalPrinter printer = BlueThermalPrinter.instance;
// //   // List<BluetoothDevice> devices = [];
// //   // BluetoothDevice? selectedDevice;

// //   final _drawerController = ZoomDrawerController();
// //   @override
// //   void initState() {
// //     // devices.clear();
// //     // WidgetsBinding.instance.addPostFrameCallback((_) => _getDevices());
// //     final home = context.read<BillingProvider>();
// //     home.version?.data![0].androidVersion != AppConfig.version
// //         ? null
// //         : getCounterID();

// //     super.initState();
// //   }

// //   Future<Uint8List> assetImageToUint8List(String assetPath) async {
// //     ByteData data = await rootBundle.load(assetPath);
// //     return data.buffer.asUint8List();
// //   }

// //   // Future<void> _getDevices() async {
// //   //   bool? connect = await printer.isConnected;
// //   //   if (connect == true) {
// //   //     await printer.disconnect();
// //   //   }

// //   //   List<BluetoothDevice> devicesList = await printer.getBondedDevices();

// //   //   setState(() {
// //   //     devices = devicesList;
// //   //   });
// //   //   await _connectToPrinter();
// //   //   bool? conect = await printer.isConnected;
// //   //   if (conect == true) {
// //   //     Helpers.successToast("Bluetooth device connected successfully");
// //   //   } else {
// //   //     Helpers.successToast("Please check printer is available");
// //   //   }
// //   // }

// //   // Future<void> _connectToPrinter() async {
// //   //   selectedDevice = devices.firstWhere(
// //   //     (device) => device.name == 'CN811-UB',
// //   //     orElse: () => BluetoothDevice('not found', ''),
// //   //   );
// //   //   if (selectedDevice?.name == 'CN811-UB') {
// //   //     await printer.connect(selectedDevice!);

// //   //     Helpers.successToast("Bluetooth device connected successfully");
// //   //   }
// //   // }
// //   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<BillingProvider>(
// //       builder: (context, home, child) => Scaffold(
// //         bottomSheet: home.version?.data![0].androidVersion != AppConfig.version
// //             ? BottomSheet(
// //                 onClosing: () {},
// //                 builder: (BuildContext context) {
// //                   return Container(
// //                       decoration: BoxDecoration(
// //                         color: Colors.white,
// //                         boxShadow: [
// //                           BoxShadow(
// //                               color: Colors.grey,
// //                               blurRadius: 20.r,
// //                               offset: const Offset(0, 5))
// //                         ],
// //                       ),
// //                       height: 320.h,
// //                       child: Column(
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //                           Column(
// //                             children: [
// //                               Row(
// //                                 children: [
// //                                   SizedBox(
// //                                       height: 25.h,
// //                                       width: 25.w,
// //                                       child: SvgPicture.asset(
// //                                         "assets/image/google_play.svg",
// //                                         fit: BoxFit.contain,
// //                                       )),
// //                                   8.horizontalSpace,
// //                                   Text(
// //                                     "Google Play",
// //                                     style: TextStyle(
// //                                         color: Colors.blueGrey,
// //                                         fontSize: 14.sp,
// //                                         fontWeight: FontWeight.w500),
// //                                   ),
// //                                 ],
// //                               ),
// //                               25.verticalSpace,
// //                               Row(
// //                                 children: [
// //                                   Text(
// //                                     "Update available",
// //                                     style: TextStyle(
// //                                         color: Colors.black,
// //                                         fontSize: 17.sp,
// //                                         fontWeight: FontWeight.w700),
// //                                   ),
// //                                 ],
// //                               ),
// //                               15.verticalSpace,
// //                               Row(
// //                                 children: [
// //                                   Text(
// //                                     "To use this app, download the latest version",
// //                                     style: TextStyle(
// //                                         color: Colors.grey,
// //                                         fontSize: 11.sp,
// //                                         fontWeight: FontWeight.w400),
// //                                   ),
// //                                 ],
// //                               ),
// //                               10.verticalSpace,
// //                               Row(
// //                                 crossAxisAlignment: CrossAxisAlignment.center,
// //                                 children: [
// //                                   Container(
// //                                     height: 50.h,
// //                                     width: 55.w,
// //                                     decoration: BoxDecoration(
// //                                       image: const DecorationImage(
// //                                           image: AssetImage(
// //                                               "assets/image/icon.png"),
// //                                           fit: BoxFit.cover),
// //                                       color: HexColor("#791AB1"),
// //                                     ),
// //                                   ),
// //                                   15.horizontalSpace,
// //                                   Column(
// //                                     children: [
// //                                       Text(
// //                                         "stock_manager",
// //                                         style: TextStyle(
// //                                             color: Colors.black,
// //                                             fontSize: 14.sp,
// //                                             fontWeight: FontWeight.w600),
// //                                       ),
// //                                     ],
// //                                   )
// //                                 ],
// //                               )
// //                             ],
// //                           ),
// //                           Row(
// //                             mainAxisAlignment: MainAxisAlignment.end,
// //                             children: [
// //                               CommonButton(
// //                                 onPressed: () async {
// //                                   await launchUrl(Uri.parse(
// //                                       "https://play.google.com/store/apps/details?id=com.stockmanager.app"));
// //                                 },
// //                                 width: 150.w,
// //                                 title: "Update",
// //                               ),
// //                             ],
// //                           )
// //                         ],
// //                       ).horizontalPadding(25.w).verticalPadding(30.h));
// //                 },
// //               )
// //             : null,
// //         resizeToAvoidBottomInset: false,
// //         key: scaffoldKey,
// //         appBar: AppBar(
// //             toolbarHeight: 0,
// //             elevation: 0,
// //             systemOverlayStyle: SystemUiOverlayStyle(
// //               statusBarColor: ColorPalette.orange,
// //               statusBarIconBrightness: Brightness.dark,
// //               statusBarBrightness: Brightness.light,
// //             )),
// //         backgroundColor: ColorPalette.orange,
// //         body: Consumer<BillingProvider>(builder: (context, provider, _) {
// //           return IgnorePointer(
// //             ignoring:
// //                 provider.version?.data![0].androidVersion == AppConfig.version
// //                     ? false
// //                     : true,
// //             child: RefreshIndicator(
// //               onRefresh: () async {},
// //               child: ZoomDrawer(
// //                 controller: _drawerController,
// //                 style: DrawerStyle.defaultStyle,
// //                 menuScreen: Container(
// //                   width: double.maxFinite,
// //                   color: ColorPalette.orange,
// //                   child: ListView(
// //                     padding: const EdgeInsets.all(0),
// //                     children: [
// //                       DrawerHeader(
// //                         decoration: BoxDecoration(
// //                           color: ColorPalette.orange,
// //                         ), //BoxDecoration
// //                         child: UserAccountsDrawerHeader(
// //                           decoration: BoxDecoration(color: ColorPalette.orange),
// //                           accountName: Text(
// //                             "User",
// //                             style: TextStyle(fontSize: 18.sp),
// //                           ),
// //                           accountEmail: const Text("online"),
// //                           currentAccountPictureSize: const Size.square(50),
// //                           currentAccountPicture: const CircleAvatar(
// //                               // backgroundColor: Color.fromARGB(255, 165, 255, 137),
// //                               backgroundColor: Colors.white,
// //                               child: Icon(Icons.person)
// //                               // Text(
// //                               //   "A",
// //                               //   style:
// //                               //       TextStyle(fontSize: 30.0, color: ColorPalette.orange),
// //                               // ), //Text
// //                               ), //circleAvatar
// //                         ), //UserAccountDrawerHeader
// //                       ), //DrawerHeader

// //                       ListTile(
// //                         leading: const Icon(Icons.logout, color: Colors.white),
// //                         title: const Text(
// //                           'Logout',
// //                           style: TextStyle(color: Colors.white),
// //                         ),
// //                         onTap: () async {
// //                           final model = context.read<BillingProvider>();
// //                           // final prefs = await SharedPreferences.getInstance();
// //                           // prefs.clear();
// //                           await SharedPreferenceHelper.clearWholeData();
// //                           await model.logoutclear();

// //                           CommonFunctions.afterInit(() =>
// //                               Navigator.pushAndRemoveUntil(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: (context) => const Login()),
// //                                   (route) => false));
// //                         },
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //                 mainScreen:
// //                     Consumer<HomeProvider>(builder: (context, provider, _) {
// //                   return Container(
// //                     color: Colors.white,
// //                     child: Column(
// //                       children: [
// //                         // TextButton(
// //                         //   child: Text("Select Counter"),
// //                         //   onPressed: () async {
// //                         //     await printer.printCustom(
// //                         //         "________________________________________", 1, 1);
// //                         //     await printer.printCustom(
// //                         //         "========================================", 1, 1);
// //                         //   },
// //                         // ),

// //                         Stack(
// //                           children: [
// //                             Image.asset(
// //                               'assets/image/green_dashboard.jpeg',
// //                               width: double.maxFinite,
// //                               fit: BoxFit.contain,
// //                             ),
// //                             Positioned(
// //                               top: 45.h,
// //                               left: 20.w,
// //                               child: Column(
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: [
// //                                   InkWell(
// //                                     onTap: provider.loaderState ==
// //                                             LoaderState.loading
// //                                         ? null
// //                                         : () {
// //                                             _drawerController.open!();
// //                                           },
// //                                     child: SizedBox(
// //                                         height: 30.w,
// //                                         width: 30.w,
// //                                         child: Center(
// //                                             child: Image.asset(
// //                                                 'assets/image/menu.png'))),
// //                                   ),
// //                                   SizedBox(
// //                                     height: 10.h,
// //                                   ),
// //                                   Text(
// //                                     'Dashboard',
// //                                     style: TextStyle(
// //                                         color: Colors.white, fontSize: 21.sp),
// //                                   ),
// //                                   Text(
// //                                     'Online Product Booking',
// //                                     style: TextStyle(
// //                                         color: Colors.white, fontSize: 14.sp),
// //                                   ),
// //                                 ],
// //                               ),
// //                             )
// //                           ],
// //                         ),
// //                         // 5.verticalSpace,
// //                         provider.loaderState == LoaderState.loading
// //                             ? const Center(child: CircularProgressIndicator())
// //                             : Expanded(
// //                                 child: Column(
// //                                   children: [
// //                                     Expanded(
// //                                       child: SizedBox(
// //                                         // color: Colors.red,
// //                                         height:
// //                                             MediaQuery.of(context).size.height *
// //                                                 .48,
// //                                         child: GridView.count(
// //                                             physics:
// //                                                 const BouncingScrollPhysics(),
// //                                             padding: EdgeInsets.symmetric(
// //                                                 horizontal: 20.w),
// //                                             crossAxisCount: 2,
// //                                             crossAxisSpacing: 5.w,
// //                                             mainAxisSpacing: 5.w,
// //                                             children: List.generate(
// //                                                 titleCards.length, (index) {
// //                                               return Center(
// //                                                 child: SelectCard(
// //                                                   title: titleCards[index],
// //                                                   onTap: () {
// //                                                     provider.navigationSwitch(
// //                                                       context,
// //                                                       index,
// //                                                     );
// //                                                   },
// //                                                 ),
// //                                               );
// //                                             })),
// //                                       ),
// //                                     ),
// //                                     // 8.verticalSpace,
// //                                     // InkWell(
// //                                     //   onTap: () {
// //                                     //     final home = context.read<HomeProvider>();
// //                                     //     home.data.clear();
// //                                     //     Navigator.of(context).push(MaterialPageRoute(
// //                                     //       builder: (context) =>
// //                                     //           const QuickBillScreen(),
// //                                     //     ));
// //                                     //   },
// //                                     //   child: Container(
// //                                     //     height: 65.h,
// //                                     //     width:
// //                                     //         MediaQuery.of(context).size.width / 1.18,
// //                                     //     decoration: BoxDecoration(
// //                                     //         borderRadius: BorderRadius.circular(25.r),
// //                                     //         gradient: LinearGradient(colors: [
// //                                     //           ColorPalette.primaryColor,
// //                                     //           ColorPalette.orange
// //                                     //         ])),
// //                                     //     child: Center(
// //                                     //         child: Text(
// //                                     //       "Quick Bill",
// //                                     //       style: TextStyle(
// //                                     //           color: Colors.white, fontSize: 18.sp),
// //                                     //     )),
// //                                     //   ),
// //                                     // ),
// //                                   ],
// //                                 ),
// //                               ),
// //                       ],
// //                     ),
// //                   );
// //                 }),
// //                 borderRadius: 24.0,
// //                 showShadow: true,
// //                 angle: -12.0,
// //                 drawerShadowsBackgroundColor: Colors.grey.shade300,
// //                 slideWidth: MediaQuery.of(context).size.width * .65,
// //                 openCurve: Curves.fastOutSlowIn,
// //                 closeCurve: Curves.bounceIn,
// //               ),
// //             ),
// //           );
// //         }),
// //       ),
// //     );
// //   }

// //   String? _chosenValue;
// //   String? selectedCounterID;
// //   void _showCounters() {
// //     Future.microtask(
// //       () {
// //         context.read<HomeProvider>().getCounter().then((value) {
// //           showDialog<bool>(
// //             barrierDismissible: false,
// //             context: context,
// //             builder: (BuildContext context) {
// //               return Consumer<BillingProvider>(builder: (context, provider, _) {
// //                 return IgnorePointer(
// //                   ignoring: provider.version?.data![0].androidVersion ==
// //                           AppConfig.version
// //                       ? false
// //                       : true,
// //                   child: StatefulBuilder(
// //                     builder: (BuildContext context, StateSetter setState) {
// //                       return PopScope(
// //                         canPop: false,
// //                         child: Consumer<HomeProvider>(
// //                             builder: (context, provider, _) {
// //                           return AlertDialog(
// //                             title: const Text("Choose Branch"),
// //                             content: Column(
// //                                 mainAxisSize: MainAxisSize.min,
// //                                 crossAxisAlignment: CrossAxisAlignment.start,
// //                                 children: <Widget>[
// //                                   const Text("Please select a Branch."),
// //                                   SingleChildScrollView(
// //                                       scrollDirection: Axis.horizontal,
// //                                       child: DropdownButton<String>(
// //                                         hint: const Text('Select your option'),
// //                                         value: _chosenValue,
// //                                         underline: Container(),
// //                                         items: provider.counterName
// //                                             .map((String value) {
// //                                           return DropdownMenuItem<String>(
// //                                             value: value,
// //                                             child: Text(
// //                                               value,
// //                                               style: const TextStyle(
// //                                                   fontWeight: FontWeight.w500),
// //                                             ),
// //                                           );
// //                                         }).toList(),
// //                                         onChanged: (value) async {
// //                                           setState(() {
// //                                             _chosenValue = value;
// //                                             for (int i = 0;
// //                                                 i < provider.counterName.length;
// //                                                 i++) {
// //                                               if (provider.counterName[i] ==
// //                                                   _chosenValue) {
// //                                                 selectedCounterID =
// //                                                     provider.counterId[i];
// //                                                 log(selectedCounterID
// //                                                     .toString());
// //                                               }
// //                                             }
// //                                           });
// //                                         },
// //                                       )),
// //                                 ]),
// //                             actions: <Widget>[
// //                               TextButton(
// //                                 child: const Text("SAVE"),
// //                                 onPressed: () async {
// //                                   final home = context.read<HomeProvider>();
// //                                   final billingProvider =
// //                                       context.read<BillingProvider>();

// //                                   if ((selectedCounterID != null)) {
// //                                     // Save storeId from the selected counter's Datum
// //                                     final selectedDatum =
// //                                         home.counterdata?.firstWhere(
// //                                       (d) => '${d.id}' == selectedCounterID,
// //                                       orElse: () => Datum(),
// //                                     );
// //                                     await SharedPreferenceHelper.saveStoreID(
// //                                         '${selectedDatum?.store ?? ""}');

// //                                     await SharedPreferenceHelper.saveCounterID(
// //                                             selectedCounterID ?? "")
// //                                         .then((value) async {
// //                                       await home.getquickbill();
// //                                       await billingProvider.getStars();
// //                                       await billingProvider.getgothra();
// //                                       await billingProvider.getrashi();

// //                                       billingProvider.getPaymentModes(context,
// //                                           onFailure: () => Helpers.successToast(
// //                                               'Error occurred while fetching payment modes ....!'));

// //                                       Navigator.of(context).pop();
// //                                     });
// //                                   } else {
// //                                     Helpers.successToast(
// //                                         "Should Select Branch");
// //                                   }
// //                                 },
// //                               ),
// //                             ],
// //                           );
// //                         }),
// //                       );
// //                     },
// //                   ),
// //                 );
// //               });
// //             },
// //           );
// //         });
// //       },
// //     );
// //   }

// //   getCounterID() async {
// //     String id = await SharedPreferenceHelper.getCounterID();
// //     String storeId = await SharedPreferenceHelper.getStoreID();
// //     if (id == '') {
// //       _showCounters();
// //     } else if (storeId == '') {
// //       // Counter was already saved but storeId wasn't (existing sessions before fix).
// //       // Fetch the counter list, look up the matching counter, and save its storeId.
// //       final home = context.read<HomeProvider>();
// //       await home.getCounter();
// //       final selectedDatum = home.counterdata?.firstWhere(
// //         (d) => '${d.id}' == id,
// //         orElse: () => Datum(),
// //       );
// //       if (selectedDatum?.store != null) {
// //         await SharedPreferenceHelper.saveStoreID('${selectedDatum!.store}');
// //       }
// //     }
// //   }
// // }

// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/common/color_palette.dart';
// import 'package:stock_manager/common/common_button.dart';
// import 'package:stock_manager/common/common_functions.dart';
// import 'package:stock_manager/common/extension.dart';
// import 'package:stock_manager/providers/billing_provider.dart';
// import 'package:stock_manager/providers/home_provider.dart';
// import 'package:stock_manager/screens/login/login.dart';
// import 'package:stock_manager/services/app_config.dart';
// import 'package:stock_manager/services/helpers.dart';
// import 'package:stock_manager/services/provider_helper_class.dart';
// import 'package:stock_manager/services/shared_preference_helper.dart';
// import 'package:stock_manager/models/counters_model.dart';
// import 'package:url_launcher/url_launcher.dart';

// // ─────────────────────────────────────────────────────────────────────────────
// // CARD DATA MODEL
// // ─────────────────────────────────────────────────────────────────────────────
// class _CardItem {
//   final String title;
//   final String subtitle;
//   final IconData icon;
//   final Color color;
//   final Color bgColor;

//   const _CardItem({
//     required this.title,
//     required this.subtitle,
//     required this.icon,
//     required this.color,
//     required this.bgColor,
//   });
// }

// // ─────────────────────────────────────────────────────────────────────────────
// // HOME SCREEN
// // ─────────────────────────────────────────────────────────────────────────────
// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
//   // Nullable so build never crashes before initState completes
//   AnimationController? _animController;

//   List<String> titleCards = [
//     "Billing",
//     "Bill List",
//     'Sales Summary',
//     "Stock",
//   ];

//   final List<_CardItem> _cardItems = const [
//     _CardItem(
//       title: "Billing",
//       subtitle: "Create invoices",
//       icon: Icons.receipt_long_outlined,
//       color: Color(0xFF2E7D32),
//       bgColor: Color(0xFFE8F5E9),
//     ),
//     _CardItem(
//       title: "Bill List",
//       subtitle: "View all bills",
//       icon: Icons.format_list_bulleted_outlined,
//       color: Color(0xFF1565C0),
//       bgColor: Color(0xFFE3F2FD),
//     ),
//     _CardItem(
//       title: "Sales Summary",
//       subtitle: "Track revenue",
//       icon: Icons.bar_chart_outlined,
//       color: Color(0xFFE65100),
//       bgColor: Color(0xFFFFF3E0),
//     ),
//     _CardItem(
//       title: "Stock",
//       subtitle: "Manage inventory",
//       icon: Icons.warehouse_outlined,
//       color: Color(0xFF6A1B9A),
//       bgColor: Color(0xFFF3E5F5),
//     ),
//   ];

//   final _drawerController = ZoomDrawerController();

//   @override
//   void initState() {
//     super.initState();
//     _animController = AnimationController(
//       vsync: this,
//       duration: const Duration(milliseconds: 800),
//     )..forward();

//     final home = context.read<BillingProvider>();
//     home.version?.data![0].androidVersion != AppConfig.version
//         ? null
//         : getCounterID();
//   }

//   @override
//   void dispose() {
//     _animController?.dispose();
//     super.dispose();
//   }

//   final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

//   // ─── BUILD ─────────────────────────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     return Consumer<BillingProvider>(
//       builder: (context, home, child) => Scaffold(
//         backgroundColor: const Color(0xFFF5F6FA),
//         appBar: AppBar(
//           toolbarHeight: 0,
//           elevation: 0,
//           systemOverlayStyle: const SystemUiOverlayStyle(
//             statusBarColor: Color(0xFF1B5E20),
//             statusBarIconBrightness: Brightness.light,
//             statusBarBrightness: Brightness.dark,
//           ),
//         ),

//         // ── Update bottom sheet ─────────────────────────────────────────────
//         bottomSheet: home.version?.data![0].androidVersion != AppConfig.version
//             ? _buildUpdateSheet()
//             : null,

//         resizeToAvoidBottomInset: false,
//         key: scaffoldKey,

//         body: Consumer<BillingProvider>(builder: (context, provider, _) {
//           return IgnorePointer(
//             ignoring:
//                 provider.version?.data![0].androidVersion == AppConfig.version
//                     ? false
//                     : true,
//             child: ZoomDrawer(
//               controller: _drawerController,
//               style: DrawerStyle.defaultStyle,
//               menuScreen: _buildDrawerMenu(),
//               mainScreen: _buildMainScreen(),
//               borderRadius: 28.0,
//               showShadow: true,
//               angle: -10.0,
//               drawerShadowsBackgroundColor: Colors.grey.shade300,
//               slideWidth: MediaQuery.of(context).size.width * .65,
//               openCurve: Curves.fastOutSlowIn,
//               closeCurve: Curves.bounceIn,
//             ),
//           );
//         }),
//       ),
//     );
//   }

//   // ─── DRAWER MENU ───────────────────────────────────────────────────────────
//   Widget _buildDrawerMenu() {
//     return Container(
//       width: double.maxFinite,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topCenter,
//           end: Alignment.bottomCenter,
//           colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
//         ),
//       ),
//       child: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 30.h),

//             // Avatar
//             Container(
//               width: 72.w,
//               height: 72.w,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Colors.white.withOpacity(0.15),
//                 border:
//                     Border.all(color: Colors.white.withOpacity(0.4), width: 2),
//               ),
//               child: const Icon(Icons.person_outline,
//                   color: Colors.white, size: 36),
//             ),
//             SizedBox(height: 12.h),

//             Text(
//               "User",
//               style: GoogleFonts.rajdhani(
//                 color: Colors.white,
//                 fontSize: 20.sp,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             Text(
//               "● Online",
//               style: GoogleFonts.rajdhani(
//                 color: const Color(0xFFA5D6A7),
//                 fontSize: 12.sp,
//                 letterSpacing: 1,
//               ),
//             ),

//             SizedBox(height: 30.h),
//             Divider(
//                 color: Colors.white.withOpacity(0.15),
//                 indent: 20,
//                 endIndent: 20),
//             SizedBox(height: 10.h),

//             // Logout
//             ListTile(
//               leading: Container(
//                 padding: const EdgeInsets.all(8),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withOpacity(0.12),
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: const Icon(Icons.logout_outlined,
//                     color: Colors.white, size: 18),
//               ),
//               title: Text(
//                 'Logout',
//                 style: GoogleFonts.rajdhani(
//                   color: Colors.white,
//                   fontSize: 15.sp,
//                   fontWeight: FontWeight.w600,
//                 ),
//               ),
//               onTap: () async {
//                 final model = context.read<BillingProvider>();
//                 await SharedPreferenceHelper.clearWholeData();
//                 await model.logoutclear();
//                 CommonFunctions.afterInit(() => Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (context) => const Login()),
//                     (route) => false));
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ─── MAIN SCREEN ───────────────────────────────────────────────────────────
//   Widget _buildMainScreen() {
//     return Consumer<HomeProvider>(builder: (context, provider, _) {
//       return Container(
//         color: const Color(0xFFF5F6FA),
//         child: Column(
//           children: [
//             // ── Header ───────────────────────────────────────────────────────
//             _buildHeader(provider),

//             // ── Body ─────────────────────────────────────────────────────────
//             provider.loaderState == LoaderState.loading
//                 ? const Expanded(
//                     child: Center(child: CircularProgressIndicator()))
//                 : Expanded(child: _buildDashboard(provider)),
//           ],
//         ),
//       );
//     });
//   }

//   // ─── HEADER ────────────────────────────────────────────────────────────────
//   Widget _buildHeader(HomeProvider provider) {
//     return Container(
//       width: double.infinity,
//       decoration: const BoxDecoration(
//         gradient: LinearGradient(
//           begin: Alignment.topLeft,
//           end: Alignment.bottomRight,
//           colors: [
//             Color(0xFF1B5E20),
//             Color(0xFF2E7D32),
//             Color(0xFF388E3C),
//           ],
//         ),
//         borderRadius: BorderRadius.only(
//           bottomLeft: Radius.circular(28),
//           bottomRight: Radius.circular(28),
//         ),
//       ),
//       child: SafeArea(
//         bottom: false,
//         child: Padding(
//           padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Top row: menu + notification
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Menu button
//                   GestureDetector(
//                     onTap: provider.loaderState == LoaderState.loading
//                         ? null
//                         : () => _drawerController.open!(),
//                     child: Container(
//                       width: 40.w,
//                       height: 40.h,
//                       decoration: BoxDecoration(
//                         color: Colors.white.withOpacity(0.15),
//                         borderRadius: BorderRadius.circular(10),
//                         border: Border.all(
//                             color: Colors.white.withOpacity(0.25), width: 1),
//                       ),
//                       child: const Icon(Icons.menu_rounded,
//                           color: Colors.white, size: 20),
//                     ),
//                   ),

//                   // Live badge
//                   Container(
//                     padding:
//                         EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
//                     decoration: BoxDecoration(
//                       color: Colors.white.withOpacity(0.15),
//                       borderRadius: BorderRadius.circular(20),
//                       border: Border.all(
//                           color: Colors.white.withOpacity(0.25), width: 1),
//                     ),
//                     child: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: [
//                         Container(
//                           width: 6,
//                           height: 6,
//                           decoration: const BoxDecoration(
//                             color: Color(0xFFA5D6A7),
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         SizedBox(width: 6.w),
//                         Text(
//                           "LIVE",
//                           style: GoogleFonts.rajdhani(
//                             color: Colors.white,
//                             fontSize: 11.sp,
//                             fontWeight: FontWeight.w700,
//                             letterSpacing: 1.5,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),

//               SizedBox(height: 20.h),

//               // Greeting
//               Text(
//                 "Dashboard",
//                 style: GoogleFonts.rajdhani(
//                   color: Colors.white.withOpacity(0.65),
//                   fontSize: 13.sp,
//                   fontWeight: FontWeight.w600,
//                   letterSpacing: 3,
//                 ),
//               ),
//               SizedBox(height: 4.h),
//               Text(
//                 "KrishiConnect Manager",
//                 style: GoogleFonts.rajdhani(
//                   color: Colors.white,
//                   fontSize: 28.sp,
//                   fontWeight: FontWeight.w800,
//                   height: 1.1,
//                 ),
//               ),
//               SizedBox(height: 6.h),
//               Text(
//                 "Online Product Booking",
//                 style: GoogleFonts.rajdhani(
//                   color: Colors.white.withOpacity(0.55),
//                   fontSize: 13.sp,
//                   letterSpacing: 0.5,
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // ─── DASHBOARD GRID ────────────────────────────────────────────────────────
//   Widget _buildDashboard(HomeProvider provider) {
//     return SingleChildScrollView(
//       physics: const BouncingScrollPhysics(),
//       padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Section label
//           Row(
//             children: [
//               Container(
//                 width: 3.w,
//                 height: 18.h,
//                 decoration: BoxDecoration(
//                   color: const Color(0xFF2E7D32),
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),
//               SizedBox(width: 10.w),
//               Text(
//                 "QUICK ACTIONS",
//                 style: GoogleFonts.rajdhani(
//                   color: Colors.black54,
//                   fontSize: 12.sp,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 2.5,
//                 ),
//               ),
//             ],
//           ),

//           SizedBox(height: 16.h),

//           // 2x2 Grid
//           GridView.builder(
//             shrinkWrap: true,
//             physics: const NeverScrollableScrollPhysics(),
//             itemCount: _cardItems.length,
//             gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//               crossAxisCount: 2,
//               mainAxisSpacing: 14.h,
//               crossAxisSpacing: 14.w,
//               childAspectRatio: 1.1,
//             ),
//             itemBuilder: (context, index) {
//               final ctrl = _animController;
//               // Guard: if controller not yet initialized, show card without animation
//               if (ctrl == null) {
//                 return _buildDashCard(
//                   item: _cardItems[index],
//                   onTap: () => provider.navigationSwitch(context, index),
//                 );
//               }
//               final delay = index * 0.1;
//               final animation = CurvedAnimation(
//                 parent: ctrl,
//                 curve: Interval(
//                   delay.clamp(0.0, 1.0),
//                   (delay + 0.5).clamp(0.0, 1.0),
//                   curve: Curves.easeOutCubic,
//                 ),
//               );
//               return AnimatedBuilder(
//                 animation: animation,
//                 builder: (_, child) => Opacity(
//                   opacity: animation.value,
//                   child: Transform.translate(
//                     offset: Offset(0, 20 * (1 - animation.value)),
//                     child: child,
//                   ),
//                 ),
//                 child: _buildDashCard(
//                   item: _cardItems[index],
//                   onTap: () => provider.navigationSwitch(context, index),
//                 ),
//               );
//             },
//           ),

//           SizedBox(height: 24.h),

//           // Info strip
//           _buildInfoStrip(),
//         ],
//       ),
//     );
//   }

//   // ─── DASHBOARD CARD ────────────────────────────────────────────────────────
//   Widget _buildDashCard({
//     required _CardItem item,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(18),
//           border: Border.all(
//             color: item.color.withOpacity(0.15),
//             width: 1,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: item.color.withOpacity(0.08),
//               blurRadius: 16,
//               offset: const Offset(0, 4),
//             ),
//             BoxShadow(
//               color: Colors.black.withOpacity(0.04),
//               blurRadius: 6,
//               offset: const Offset(0, 2),
//             ),
//           ],
//         ),
//         child: Stack(
//           children: [
//             // Background orb
//             Positioned(
//               top: -16,
//               right: -16,
//               child: Container(
//                 width: 70,
//                 height: 70,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: item.color.withOpacity(0.06),
//                 ),
//               ),
//             ),

//             Padding(
//               padding: EdgeInsets.all(18.w),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Icon box
//                   Container(
//                     width: 46.w,
//                     height: 46.w,
//                     decoration: BoxDecoration(
//                       color: item.bgColor,
//                       borderRadius: BorderRadius.circular(12),
//                       border: Border.all(
//                         color: item.color.withOpacity(0.2),
//                         width: 1,
//                       ),
//                     ),
//                     child: Icon(item.icon, color: item.color, size: 24),
//                   ),

//                   // Text
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         item.title,
//                         style: GoogleFonts.rajdhani(
//                           color: const Color(0xFF1A1A2E),
//                           fontSize: 16.sp,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       SizedBox(height: 2.h),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             item.subtitle,
//                             style: GoogleFonts.rajdhani(
//                               color: Colors.black38,
//                               fontSize: 11.sp,
//                             ),
//                           ),
//                           Container(
//                             width: 22,
//                             height: 22,
//                             decoration: BoxDecoration(
//                               color: item.bgColor,
//                               borderRadius: BorderRadius.circular(6),
//                             ),
//                             child: Icon(
//                               Icons.arrow_forward_ios_rounded,
//                               color: item.color,
//                               size: 10,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // ─── INFO STRIP ────────────────────────────────────────────────────────────
//   Widget _buildInfoStrip() {
//     return Container(
//       padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(16),
//         border: Border.all(color: const Color(0xFFE8F5E9), width: 1),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.04),
//             blurRadius: 8,
//             offset: const Offset(0, 2),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           Container(
//             width: 40.w,
//             height: 40.w,
//             decoration: BoxDecoration(
//               color: const Color(0xFFE8F5E9),
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: const Icon(Icons.info_outline,
//                 color: Color(0xFF2E7D32), size: 20),
//           ),
//           SizedBox(width: 14.w),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   "Agricultural Stock Manager",
//                   style: GoogleFonts.rajdhani(
//                     color: const Color(0xFF1A1A2E),
//                     fontSize: 13.sp,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//                 Text(
//                   "All your farming operations in one place",
//                   style: GoogleFonts.rajdhani(
//                     color: Colors.black38,
//                     fontSize: 11.sp,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // ─── UPDATE BOTTOM SHEET ───────────────────────────────────────────────────
//   Widget _buildUpdateSheet() {
//     return BottomSheet(
//       onClosing: () {},
//       builder: (BuildContext context) {
//         return Container(
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.black.withOpacity(0.1),
//                 blurRadius: 20,
//                 offset: const Offset(0, -4),
//               ),
//             ],
//           ),
//           height: 300.h,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               // Handle
//               Container(
//                 margin: EdgeInsets.only(top: 12.h),
//                 width: 40.w,
//                 height: 4.h,
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(2),
//                 ),
//               ),

//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Row(
//                       children: [
//                         SizedBox(
//                           height: 22.h,
//                           width: 22.w,
//                           child: SvgPicture.asset(
//                             "assets/image/google_play.svg",
//                             fit: BoxFit.contain,
//                           ),
//                         ),
//                         8.horizontalSpace,
//                         Text(
//                           "Google Play",
//                           style: GoogleFonts.rajdhani(
//                             color: Colors.blueGrey,
//                             fontSize: 13.sp,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//                     16.verticalSpace,
//                     Text(
//                       "Update Available",
//                       style: GoogleFonts.rajdhani(
//                         color: const Color(0xFF1A1A2E),
//                         fontSize: 22.sp,
//                         fontWeight: FontWeight.w800,
//                       ),
//                     ),
//                     8.verticalSpace,
//                     Text(
//                       "A new version is available. Please update to continue using the app.",
//                       style: GoogleFonts.rajdhani(
//                         color: Colors.black45,
//                         fontSize: 13.sp,
//                         height: 1.4,
//                       ),
//                     ),
//                     16.verticalSpace,
//                     Row(
//                       children: [
//                         Container(
//                           height: 44.h,
//                           width: 44.w,
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(10),
//                             image: const DecorationImage(
//                               image: AssetImage("assets/image/icon.png"),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                         12.horizontalSpace,
//                         Text(
//                           "stock_manager",
//                           style: GoogleFonts.rajdhani(
//                             color: const Color(0xFF1A1A2E),
//                             fontSize: 14.sp,
//                             fontWeight: FontWeight.w700,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),

//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
//                 child: SizedBox(
//                   width: double.infinity,
//                   height: 50.h,
//                   child: ElevatedButton.icon(
//                     onPressed: () async {
//                       await launchUrl(Uri.parse(
//                           "https://play.google.com/store/apps/details?id=com.stockmanager.app"));
//                     },
//                     icon: const Icon(Icons.system_update_outlined, size: 18),
//                     label: Text(
//                       "Update Now",
//                       style: GoogleFonts.rajdhani(
//                         fontSize: 15.sp,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF2E7D32),
//                       foregroundColor: Colors.white,
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }

//   // ─── COUNTER DIALOG ────────────────────────────────────────────────────────
//   String? _chosenValue;
//   String? selectedCounterID;

//   void _showCounters() {
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       context.read<HomeProvider>().getCounter().then((value) {
//         showDialog<bool>(
//           barrierDismissible: false,
//           context: context,
//           builder: (BuildContext context) {
//             return Consumer<BillingProvider>(builder: (context, provider, _) {
//               return IgnorePointer(
//                 ignoring: provider.version?.data![0].androidVersion ==
//                         AppConfig.version
//                     ? false
//                     : true,
//                 child: StatefulBuilder(
//                   builder: (BuildContext context, StateSetter setState) {
//                     return PopScope(
//                       canPop: false,
//                       child: Consumer<HomeProvider>(
//                           builder: (context, provider, _) {
//                         return AlertDialog(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(16),
//                           ),
//                           title: Text(
//                             "Choose Branch",
//                             style: GoogleFonts.rajdhani(
//                               fontWeight: FontWeight.w800,
//                               fontSize: 18.sp,
//                             ),
//                           ),
//                           content: Column(
//                             mainAxisSize: MainAxisSize.min,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "Please select a Branch.",
//                                 style: GoogleFonts.rajdhani(
//                                     color: Colors.black54, fontSize: 13.sp),
//                               ),
//                               SizedBox(height: 12.h),
//                               Container(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 12.w, vertical: 4.h),
//                                 decoration: BoxDecoration(
//                                   color: const Color(0xFFF5F6FA),
//                                   borderRadius: BorderRadius.circular(10),
//                                   border: Border.all(
//                                       color: const Color(0xFFE0E0E0)),
//                                 ),
//                                 child: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: DropdownButton<String>(
//                                     hint: Text(
//                                       'Select your option',
//                                       style: GoogleFonts.rajdhani(
//                                           color: Colors.black45),
//                                     ),
//                                     value: _chosenValue,
//                                     underline: Container(),
//                                     icon: const Icon(
//                                         Icons.keyboard_arrow_down_rounded),
//                                     items: provider.counterName
//                                         .map((String value) {
//                                       return DropdownMenuItem<String>(
//                                         value: value,
//                                         child: Text(
//                                           value,
//                                           style: GoogleFonts.rajdhani(
//                                               fontWeight: FontWeight.w600),
//                                         ),
//                                       );
//                                     }).toList(),
//                                     onChanged: (value) async {
//                                       setState(() {
//                                         _chosenValue = value;
//                                         for (int i = 0;
//                                             i < provider.counterName.length;
//                                             i++) {
//                                           if (provider.counterName[i] ==
//                                               _chosenValue) {
//                                             selectedCounterID =
//                                                 provider.counterId[i];
//                                             log(selectedCounterID.toString());
//                                           }
//                                         }
//                                       });
//                                     },
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           actions: [
//                             TextButton(
//                               onPressed: () async {
//                                 final home = context.read<HomeProvider>();
//                                 final billingProvider =
//                                     context.read<BillingProvider>();

//                                 if (selectedCounterID != null) {
//                                   final selectedDatum =
//                                       home.counterdata?.firstWhere(
//                                     (d) => '${d.id}' == selectedCounterID,
//                                     orElse: () => Datum(),
//                                   );
//                                   await SharedPreferenceHelper.saveStoreID(
//                                       '${selectedDatum?.store ?? ""}');
//                                   await SharedPreferenceHelper.saveCounterID(
//                                           selectedCounterID ?? "")
//                                       .then((value) async {
//                                     await home.getquickbill();
//                                     await billingProvider.getStars();
//                                     await billingProvider.getgothra();
//                                     await billingProvider.getrashi();
//                                     billingProvider.getPaymentModes(context,
//                                         onFailure: () => Helpers.successToast(
//                                             'Error occurred while fetching payment modes ....!'));
//                                     Navigator.of(context).pop();
//                                   });
//                                 } else {
//                                   Helpers.successToast("Should Select Branch");
//                                 }
//                               },
//                               style: TextButton.styleFrom(
//                                 backgroundColor: const Color(0xFF2E7D32),
//                                 foregroundColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(8),
//                                 ),
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 24.w, vertical: 10.h),
//                               ),
//                               child: Text(
//                                 "SAVE",
//                                 style: GoogleFonts.rajdhani(
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 14.sp,
//                                 ),
//                               ),
//                             ),
//                           ],
//                         );
//                       }),
//                     );
//                   },
//                 ),
//               );
//             });
//           },
//         );
//       });
//     });
//   }

//   getCounterID() async {
//     String id = await SharedPreferenceHelper.getCounterID();
//     String storeId = await SharedPreferenceHelper.getStoreID();
//     if (id == '') {
//       _showCounters();
//     } else if (storeId == '') {
//       final home = context.read<HomeProvider>();
//       await home.getCounter();
//       final selectedDatum = home.counterdata?.firstWhere(
//         (d) => '${d.id}' == id,
//         orElse: () => Datum(),
//       );
//       if (selectedDatum?.store != null) {
//         await SharedPreferenceHelper.saveStoreID('${selectedDatum!.store}');
//       }
//     }
//   }
// }





import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/common/color_palette.dart';
import 'package:stock_manager/common/common_button.dart';
import 'package:stock_manager/common/common_functions.dart';
import 'package:stock_manager/common/extension.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/providers/home_provider.dart';
import 'package:stock_manager/screens/login/login.dart';
import 'package:stock_manager/services/app_config.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/services/provider_helper_class.dart';
import 'package:stock_manager/services/shared_preference_helper.dart';
import 'package:url_launcher/url_launcher.dart';

// ─────────────────────────────────────────────────────────────────────────────
// CARD DATA MODEL
// ─────────────────────────────────────────────────────────────────────────────
class _CardItem {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color color;
  final Color bgColor;

  const _CardItem({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color,
    required this.bgColor,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// HOME SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  AnimationController? _animController;

  List<String> titleCards = [
    "Billing",
    "Bill List",
    'Sales Summary',
    "Stock",
  ];

  final List<_CardItem> _cardItems = const [
    _CardItem(
      title: "Billing",
      subtitle: "Create invoices",
      icon: Icons.receipt_long_outlined,
      color: Color(0xFF2E7D32),
      bgColor: Color(0xFFE8F5E9),
    ),
    _CardItem(
      title: "Bill List",
      subtitle: "View all bills",
      icon: Icons.format_list_bulleted_outlined,
      color: Color(0xFF1565C0),
      bgColor: Color(0xFFE3F2FD),
    ),
    _CardItem(
      title: "Sales Summary",
      subtitle: "Track revenue",
      icon: Icons.bar_chart_outlined,
      color: Color(0xFFE65100),
      bgColor: Color(0xFFFFF3E0),
    ),
    _CardItem(
      title: "Stock",
      subtitle: "Manage inventory",
      icon: Icons.warehouse_outlined,
      color: Color(0xFF6A1B9A),
      bgColor: Color(0xFFF3E5F5),
    ),
  ];

  final _drawerController = ZoomDrawerController();

  @override
  void initState() {
    super.initState();
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
  }

  @override
  void dispose() {
    _animController?.dispose();
    super.dispose();
  }

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // ─── BUILD ─────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Consumer<BillingProvider>(
      builder: (context, home, child) => Scaffold(
        backgroundColor: const Color(0xFFF5F6FA),
        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Color(0xFF1B5E20),
            statusBarIconBrightness: Brightness.light,
            statusBarBrightness: Brightness.dark,
          ),
        ),

        // ── Update bottom sheet ─────────────────────────────────────────────
        bottomSheet: home.version?.data![0].androidVersion != AppConfig.version
            ? _buildUpdateSheet()
            : null,

        resizeToAvoidBottomInset: false,
        key: scaffoldKey,

        body: Consumer<BillingProvider>(builder: (context, provider, _) {
          return IgnorePointer(
            ignoring:
                provider.version?.data![0].androidVersion == AppConfig.version
                    ? false
                    : true,
            child: ZoomDrawer(
              controller: _drawerController,
              style: DrawerStyle.defaultStyle,
              menuScreen: _buildDrawerMenu(),
              mainScreen: _buildMainScreen(),
              borderRadius: 28.0,
              showShadow: true,
              angle: -10.0,
              drawerShadowsBackgroundColor: Colors.grey.shade300,
              slideWidth: MediaQuery.of(context).size.width * .65,
              openCurve: Curves.fastOutSlowIn,
              closeCurve: Curves.bounceIn,
            ),
          );
        }),
      ),
    );
  }

  // ─── DRAWER MENU ───────────────────────────────────────────────────────────
  Widget _buildDrawerMenu() {
    return Container(
      width: double.maxFinite,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1B5E20), Color(0xFF2E7D32)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30.h),

            // Avatar
            Container(
              width: 72.w,
              height: 72.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.15),
                border:
                    Border.all(color: Colors.white.withOpacity(0.4), width: 2),
              ),
              child: const Icon(Icons.person_outline,
                  color: Colors.white, size: 36),
            ),
            SizedBox(height: 12.h),

            Text(
              "User",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              "● Online",
              style: GoogleFonts.rajdhani(
                color: const Color(0xFFA5D6A7),
                fontSize: 12.sp,
                letterSpacing: 1,
              ),
            ),

            SizedBox(height: 30.h),
            Divider(
                color: Colors.white.withOpacity(0.15),
                indent: 20,
                endIndent: 20),
            SizedBox(height: 10.h),

            // Logout
            ListTile(
              leading: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.logout_outlined,
                    color: Colors.white, size: 18),
              ),
              title: Text(
                'Logout',
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 15.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              onTap: () async {
                final model = context.read<BillingProvider>();
                await SharedPreferenceHelper.clearWholeData();
                await model.logoutclear();
                CommonFunctions.afterInit(() => Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const Login()),
                    (route) => false));
              },
            ),
          ],
        ),
      ),
    );
  }

  // ─── MAIN SCREEN ───────────────────────────────────────────────────────────
  Widget _buildMainScreen() {
    return Consumer<HomeProvider>(builder: (context, provider, _) {
      return Container(
        color: const Color(0xFFF5F6FA),
        child: Column(
          children: [
            _buildHeader(provider),
            provider.loaderState == LoaderState.loading
                ? const Expanded(
                    child: Center(child: CircularProgressIndicator()))
                : Expanded(child: _buildDashboard(provider)),
          ],
        ),
      );
    });
  }

  // ─── HEADER ────────────────────────────────────────────────────────────────
  Widget _buildHeader(HomeProvider provider) {
    return Container(
      width: double.infinity,
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
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(28),
          bottomRight: Radius.circular(28),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.fromLTRB(20.w, 16.h, 20.w, 28.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top row: menu + live badge
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: provider.loaderState == LoaderState.loading
                        ? null
                        : () => _drawerController.open!(),
                    child: Container(
                      width: 40.w,
                      height: 40.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.25), width: 1),
                      ),
                      child: const Icon(Icons.menu_rounded,
                          color: Colors.white, size: 20),
                    ),
                  ),
                  // Container(
                  //   padding:
                  //       EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  //   decoration: BoxDecoration(
                  //     color: Colors.white.withOpacity(0.15),
                  //     borderRadius: BorderRadius.circular(20),
                  //     border: Border.all(
                  //         color: Colors.white.withOpacity(0.25), width: 1),
                  //   ),
                  //   child: Row(
                  //     mainAxisSize: MainAxisSize.min,
                  //     children: [
                  //       Container(
                  //         width: 6,
                  //         height: 6,
                  //         decoration: const BoxDecoration(
                  //           color: Color(0xFFA5D6A7),
                  //           shape: BoxShape.circle,
                  //         ),
                  //       ),
                  //       SizedBox(width: 6.w),
                  //       Text(
                  //         "LIVE",
                  //         style: GoogleFonts.rajdhani(
                  //           color: Colors.white,
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

              SizedBox(height: 20.h),

              Text(
                "Dashboard",
                style: GoogleFonts.rajdhani(
                  color: Colors.white.withOpacity(0.65),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 3,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                "KrishiConnect Manager",
                style: GoogleFonts.rajdhani(
                  color: Colors.white,
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),
              SizedBox(height: 6.h),
              Text(
                "Online Product Booking",
                style: GoogleFonts.rajdhani(
                  color: Colors.white.withOpacity(0.55),
                  fontSize: 13.sp,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ─── DASHBOARD GRID ────────────────────────────────────────────────────────
  Widget _buildDashboard(HomeProvider provider) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.fromLTRB(16.w, 24.h, 16.w, 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 3.w,
                height: 18.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D32),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                "QUICK ACTIONS",
                style: GoogleFonts.rajdhani(
                  color: Colors.black54,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 2.5,
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _cardItems.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14.h,
              crossAxisSpacing: 14.w,
              childAspectRatio: 1.1,
            ),
            itemBuilder: (context, index) {
              final ctrl = _animController;
              if (ctrl == null) {
                return _buildDashCard(
                  item: _cardItems[index],
                  onTap: () => provider.navigationSwitch(context, index),
                );
              }
              final delay = index * 0.1;
              final animation = CurvedAnimation(
                parent: ctrl,
                curve: Interval(
                  delay.clamp(0.0, 1.0),
                  (delay + 0.5).clamp(0.0, 1.0),
                  curve: Curves.easeOutCubic,
                ),
              );
              return AnimatedBuilder(
                animation: animation,
                builder: (_, child) => Opacity(
                  opacity: animation.value,
                  child: Transform.translate(
                    offset: Offset(0, 20 * (1 - animation.value)),
                    child: child,
                  ),
                ),
                child: _buildDashCard(
                  item: _cardItems[index],
                  onTap: () => provider.navigationSwitch(context, index),
                ),
              );
            },
          ),

          SizedBox(height: 24.h),

          _buildInfoStrip(),
        ],
      ),
    );
  }

  // ─── DASHBOARD CARD ────────────────────────────────────────────────────────
  Widget _buildDashCard({
    required _CardItem item,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: item.color.withOpacity(0.15), width: 1),
          boxShadow: [
            BoxShadow(
              color: item.color.withOpacity(0.08),
              blurRadius: 16,
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
            Positioned(
              top: -16,
              right: -16,
              child: Container(
                width: 70,
                height: 70,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: item.color.withOpacity(0.06),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(18.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 46.w,
                    height: 46.w,
                    decoration: BoxDecoration(
                      color: item.bgColor,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                          color: item.color.withOpacity(0.2), width: 1),
                    ),
                    child: Icon(item.icon, color: item.color, size: 24),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.title,
                        style: GoogleFonts.rajdhani(
                          color: const Color(0xFF1A1A2E),
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
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
                            ),
                          ),
                          Container(
                            width: 22,
                            height: 22,
                            decoration: BoxDecoration(
                              color: item.bgColor,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: item.color,
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

  // ─── INFO STRIP ────────────────────────────────────────────────────────────
  Widget _buildInfoStrip() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8F5E9), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F5E9),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.info_outline,
                color: Color(0xFF2E7D32), size: 20),
          ),
          SizedBox(width: 14.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Agricultural Stock Manager",
                  style: GoogleFonts.rajdhani(
                    color: const Color(0xFF1A1A2E),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  "All your farming operations in one place",
                  style: GoogleFonts.rajdhani(
                    color: Colors.black38,
                    fontSize: 11.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ─── UPDATE BOTTOM SHEET ───────────────────────────────────────────────────
  Widget _buildUpdateSheet() {
    return BottomSheet(
      onClosing: () {},
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius:
                const BorderRadius.vertical(top: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, -4),
              ),
            ],
          ),
          height: 300.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                margin: EdgeInsets.only(top: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          height: 22.h,
                          width: 22.w,
                          child: SvgPicture.asset(
                            "assets/image/google_play.svg",
                            fit: BoxFit.contain,
                          ),
                        ),
                        8.horizontalSpace,
                        Text(
                          "Google Play",
                          style: GoogleFonts.rajdhani(
                            color: Colors.blueGrey,
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    16.verticalSpace,
                    Text(
                      "Update Available",
                      style: GoogleFonts.rajdhani(
                        color: const Color(0xFF1A1A2E),
                        fontSize: 22.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      "A new version is available. Please update to continue using the app.",
                      style: GoogleFonts.rajdhani(
                        color: Colors.black45,
                        fontSize: 13.sp,
                        height: 1.4,
                      ),
                    ),
                    16.verticalSpace,
                    Row(
                      children: [
                        Container(
                          height: 44.h,
                          width: 44.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: const DecorationImage(
                              image: AssetImage("assets/image/icon.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        12.horizontalSpace,
                        Text(
                          "stock_manager",
                          style: GoogleFonts.rajdhani(
                            color: const Color(0xFF1A1A2E),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                child: SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      await launchUrl(Uri.parse(
                          "https://play.google.com/store/apps/details?id=com.stockmanager.app"));
                    },
                    icon: const Icon(Icons.system_update_outlined, size: 18),
                    label: Text(
                      "Update Now",
                      style: GoogleFonts.rajdhani(
                        fontSize: 15.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2E7D32),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}