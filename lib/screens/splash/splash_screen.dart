import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/common/color_palette.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/providers/home_provider.dart';
import 'package:stock_manager/screens/login/login.dart';
import 'package:stock_manager/services/app_config.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/services/shared_preference_helper.dart';
import '../home/home.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    checkLogged();
    super.initState();
  }

  checkLogged() async {
    await SharedPreferenceHelper.getToken();
    Future.delayed(const Duration(seconds: 2), () => navToScreen());
  }

  navToScreen() async {
    final home = context.read<HomeProvider>();
    final billingProvider = context.read<BillingProvider>();
    if ((AppConfig.accessToken ?? '').isNotEmpty) {
      await billingProvider.getversion(context);
      await home.getquickbill();
      await billingProvider.getStars();
      await billingProvider.getgothra();
      await billingProvider.getrashi();

      if (!mounted) return;
      billingProvider.getPaymentModes(context,
          onFailure: () => Helpers.successToast(
              'Error occurred while fetching payment modes ....!'));

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Home()),
          (route) => false);
    } else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const Login()),
          (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorPalette.orange,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          )),
      body: Container(
        height: double.maxFinite,
        width: double.maxFinite,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
              ColorPalette.darkGreen,
              ColorPalette.lightGreen,
            ])),
        // child: Center(
        //     child: 
        // //     Image.asset(
        // //   'assets/image/logo.png',
        // //   width: 300.w,
        // //   height: 300.w,
        // //   fit: BoxFit.fill,
        // // )
        // Textz
        // ),
      ),
    );
  }
}
