// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:stock_manager/common/color_palette.dart';
// import 'package:stock_manager/providers/billing_provider.dart';
// import 'package:stock_manager/providers/home_provider.dart';
// import 'package:stock_manager/screens/login/login.dart';
// import 'package:stock_manager/services/app_config.dart';
// import 'package:stock_manager/services/helpers.dart';
// import 'package:stock_manager/services/shared_preference_helper.dart';
// import '../home/home.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});
//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     checkLogged();
//     super.initState();
//   }

//   checkLogged() async {
//     await SharedPreferenceHelper.getToken();
//     Future.delayed(const Duration(seconds: 2), () => navToScreen());
//   }

//   navToScreen() async {
//     final home = context.read<HomeProvider>();
//     final billingProvider = context.read<BillingProvider>();
//     if ((AppConfig.accessToken ?? '').isNotEmpty) {
//       await billingProvider.getversion(context);
//       await home.getquickbill();
//       await billingProvider.getStars();
//       await billingProvider.getgothra();
//       await billingProvider.getrashi();

//       if (!mounted) return;
//       billingProvider.getPaymentModes(context,
//           onFailure: () => Helpers.successToast(
//               'Error occurred while fetching payment modes ....!'));

//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const Home()),
//           (route) => false);
//     } else {
//       Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const Login()),
//           (route) => false);
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//           toolbarHeight: 0,
//           elevation: 0,
//           systemOverlayStyle: SystemUiOverlayStyle(
//             statusBarColor: ColorPalette.orange,
//             statusBarIconBrightness: Brightness.dark,
//             statusBarBrightness: Brightness.light,
//           )),
//       body: Container(
//         height: double.maxFinite,
//         width: double.maxFinite,
//         decoration: BoxDecoration(
//             gradient: LinearGradient(
//                 begin: Alignment.centerLeft,
//                 end: Alignment.centerRight,
//                 colors: [
//               ColorPalette.darkGreen,
//               ColorPalette.lightGreen,
//             ])),
//         // child: Center(
//         //     child: 
//         // //     Image.asset(
//         // //   'assets/image/logo.png',
//         // //   width: 300.w,
//         // //   height: 300.w,
//         // //   fit: BoxFit.fill,
//         // // )
//         // Textz
//         // ),
//       ),
//     );
//   }
// }




import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:stock_manager/common/color_palette.dart';
import 'package:stock_manager/providers/billing_provider.dart';
import 'package:stock_manager/providers/home_provider.dart';
import 'package:stock_manager/screens/login/login.dart';
import 'package:stock_manager/services/app_config.dart';
import 'package:stock_manager/services/helpers.dart';
import 'package:stock_manager/services/shared_preference_helper.dart';
import '../home/home.dart';

// ─────────────────────────────────────────────────────────────────────────────
// SPLASH SCREEN
// ─────────────────────────────────────────────────────────────────────────────
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // ── Animation Controllers ──────────────────────────────────────────────────
  late AnimationController _masterController;
  late AnimationController _pulseController;
  late AnimationController _particleController;

  // ── Logo animations ────────────────────────────────────────────────────────
  late Animation<double> _logoScale;
  late Animation<double> _logoOpacity;
  late Animation<double> _logoRotate;

  // ── Text animations ────────────────────────────────────────────────────────
  late Animation<double> _titleOpacity;
  late Animation<Offset> _titleSlide;
  late Animation<double> _subtitleOpacity;
  late Animation<Offset> _subtitleSlide;

  // ── Bottom bar animation ───────────────────────────────────────────────────
  late Animation<double> _barOpacity;
  late Animation<double> _barWidth;

  // ── Pulse glow ────────────────────────────────────────────────────────────
  late Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _setupAnimations();
    _masterController.forward();
    checkLogged();
  }

  void _setupAnimations() {
    // Master: 1.6s total
    _masterController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    );

    // Pulse loop for glow ring
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    )..repeat(reverse: true);

    // Particle float loop
    _particleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000),
    )..repeat();

    // Logo: scale + opacity + slight rotate
    _logoScale = Tween<double>(begin: 0.3, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.55, curve: Curves.elasticOut),
      ),
    );
    _logoOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.3, curve: Curves.easeIn),
      ),
    );
    _logoRotate = Tween<double>(begin: -0.15, end: 0.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.0, 0.55, curve: Curves.elasticOut),
      ),
    );

    // Title slides up
    _titleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.45, 0.72, curve: Curves.easeOut),
      ),
    );
    _titleSlide = Tween<Offset>(
      begin: const Offset(0, 0.6),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.45, 0.72, curve: Curves.easeOut),
      ),
    );

    // Subtitle slides up after title
    _subtitleOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.60, 0.85, curve: Curves.easeOut),
      ),
    );
    _subtitleSlide = Tween<Offset>(
      begin: const Offset(0, 0.8),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.60, 0.85, curve: Curves.easeOut),
      ),
    );

    // Bottom loading bar
    _barOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.75, 0.92, curve: Curves.easeIn),
      ),
    );
    _barWidth = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _masterController,
        curve: const Interval(0.78, 1.0, curve: Curves.easeInOut),
      ),
    );

    // Pulse ring glow
    _pulse = Tween<double>(begin: 0.85, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  checkLogged() async {
    await SharedPreferenceHelper.getToken();
    Future.delayed(const Duration(seconds: 3), () => navToScreen());
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
  void dispose() {
    _masterController.dispose();
    _pulseController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color(0xFF1B5E20),
          statusBarIconBrightness: Brightness.light,
          statusBarBrightness: Brightness.dark,
        ),
      ),
      body: Stack(
        children: [
          // ── Background gradient ──────────────────────────────────────────
          _buildBackground(),

          // ── Floating particles ───────────────────────────────────────────
          _buildParticles(),

          // ── Wave decoration bottom ───────────────────────────────────────
          _buildBottomWave(),

          // ── Main content ─────────────────────────────────────────────────
          _buildContent(),
        ],
      ),
    );
  }

  // ── BACKGROUND ────────────────────────────────────────────────────────────
  Widget _buildBackground() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B5E20), // deep forest green
            Color(0xFF2E7D32), // rich green
            Color(0xFF388E3C), // medium green
            Color(0xFF1B5E20), // back to deep
          ],
          stops: [0.0, 0.35, 0.65, 1.0],
        ),
      ),
    );
  }

  // ── FLOATING PARTICLES (leaves/seeds) ─────────────────────────────────────
  Widget _buildParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, _) {
        return CustomPaint(
          painter: _ParticlePainter(_particleController.value),
          child: const SizedBox.expand(),
        );
      },
    );
  }

  // ── BOTTOM WAVE ───────────────────────────────────────────────────────────
  Widget _buildBottomWave() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: CustomPaint(
        painter: _WavePainter(),
        child: SizedBox(height: 160.h),
      ),
    );
  }

  // ── MAIN CONTENT ──────────────────────────────────────────────────────────
  Widget _buildContent() {
    return SafeArea(
      child: Column(
        children: [
          const Spacer(flex: 2),

          // ── Logo area ──────────────────────────────────────────────────
          AnimatedBuilder(
            animation: Listenable.merge([
              _masterController,
              _pulseController,
            ]),
            builder: (context, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  // Outer pulse ring
                  Transform.scale(
                    scale: _pulse.value * (_logoScale.value.clamp(0.0, 1.0)),
                    child: Container(
                      width: 130.w,
                      height: 130.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.12),
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),

                  // Inner ring
                  Transform.scale(
                    scale: _logoScale.value,
                    child: Opacity(
                      opacity: _logoOpacity.value,
                      child: Container(
                        width: 110.w,
                        height: 110.w,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 1,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Logo circle
                  Transform.scale(
                    scale: _logoScale.value,
                    child: Transform.rotate(
                      angle: _logoRotate.value,
                      child: Opacity(
                        opacity: _logoOpacity.value,
                        child: Container(
                          width: 90.w,
                          height: 90.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white.withOpacity(0.15),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.4),
                              width: 2,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 24,
                                spreadRadius: 2,
                              ),
                              BoxShadow(
                                color: const Color(0xFF81C784).withOpacity(0.3),
                                blurRadius: 30,
                                spreadRadius: 4,
                              ),
                            ],
                          ),
                          child: Center(
                            child: _buildLogoIcon(),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),

          SizedBox(height: 36.h),

          // ── App name ───────────────────────────────────────────────────
          AnimatedBuilder(
            animation: _masterController,
            builder: (context, _) {
              return FadeTransition(
                opacity: _titleOpacity,
                child: SlideTransition(
                  position: _titleSlide,
                  child: Column(
                    children: [
                      Text(
                        "KrishiConnect",
                        style: GoogleFonts.rajdhani(
                          fontSize: 38.sp,
                          fontWeight: FontWeight.w800,
                          color: Colors.white,
                          letterSpacing: 6,
                          height: 1.0,
                          shadows: [
                            Shadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      // Accent line under title
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30.w,
                            height: 1.5,
                            color: Colors.white.withOpacity(0.4),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            width: 8.w,
                            height: 8.w,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Color(0xFFA5D6A7),
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Container(
                            width: 30.w,
                            height: 1.5,
                            color: Colors.white.withOpacity(0.4),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),

          SizedBox(height: 12.h),

          // ── Subtitle ───────────────────────────────────────────────────
          AnimatedBuilder(
            animation: _masterController,
            builder: (context, _) {
              return FadeTransition(
                opacity: _subtitleOpacity,
                child: SlideTransition(
                  position: _subtitleSlide,
                  child: Text(
                    "Agricultural Stock Management",
                    style: GoogleFonts.rajdhani(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white.withOpacity(0.7),
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              );
            },
          ),

          const Spacer(flex: 2),

          // ── Loading bar ────────────────────────────────────────────────
          AnimatedBuilder(
            animation: _masterController,
            builder: (context, _) {
              return FadeTransition(
                opacity: _barOpacity,
                child: Column(
                  children: [
                    Text(
                      "Loading...",
                      style: GoogleFonts.rajdhani(
                        fontSize: 11.sp,
                        color: Colors.white.withOpacity(0.5),
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 60.w),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Stack(
                          children: [
                            // Track
                            Container(
                              height: 3.h,
                              width: double.infinity,
                              color: Colors.white.withOpacity(0.15),
                            ),
                            // Fill
                            FractionallySizedBox(
                              widthFactor: _barWidth.value,
                              child: Container(
                                height: 3.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  gradient: const LinearGradient(
                                    colors: [
                                      Color(0xFFA5D6A7),
                                      Color(0xFF66BB6A),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          SizedBox(height: 40.h),
        ],
      ),
    );
  }

  // ── SVG-STYLE LOGO ICON ───────────────────────────────────────────────────
  Widget _buildLogoIcon() {
    return Stack(
      alignment: Alignment.center,
      children: [
        // Wheat/leaf icon using CustomPaint
        CustomPaint(
          size: Size(42.w, 42.w),
          painter: _LeafLogoPainter(),
        ),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// LEAF LOGO PAINTER — draws a stylized wheat/leaf icon
// ─────────────────────────────────────────────────────────────────────────────
class _LeafLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final stemPaint = Paint()
      ..color = Colors.white.withOpacity(0.9)
      ..strokeWidth = 2.5
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final leafPaint = Paint()
      ..color = Colors.white.withOpacity(0.85)
      ..style = PaintingStyle.fill;

    // Main stem
    canvas.drawLine(
      Offset(cx, cy + size.height * 0.45),
      Offset(cx, cy - size.height * 0.45),
      stemPaint,
    );

    // Draw 3 pairs of leaves up the stem
    final leafPositions = [0.1, -0.05, -0.2];
    final leafSizes = [0.22, 0.18, 0.14];

    for (int i = 0; i < leafPositions.length; i++) {
      final y = cy + size.height * leafPositions[i];
      final lw = size.width * leafSizes[i];
      final lh = size.height * leafSizes[i] * 0.55;

      // Left leaf
      final leftPath = Path()
        ..moveTo(cx, y)
        ..quadraticBezierTo(cx - lw, y - lh, cx - lw * 0.8, y - lh * 1.8)
        ..quadraticBezierTo(cx - lw * 0.3, y - lh * 0.5, cx, y);
      canvas.drawPath(leftPath, leafPaint);

      // Right leaf
      final rightPath = Path()
        ..moveTo(cx, y)
        ..quadraticBezierTo(cx + lw, y - lh, cx + lw * 0.8, y - lh * 1.8)
        ..quadraticBezierTo(cx + lw * 0.3, y - lh * 0.5, cx, y);
      canvas.drawPath(rightPath, leafPaint);
    }

    // Tip grain bead
    canvas.drawCircle(
      Offset(cx, cy - size.height * 0.44),
      3.5,
      Paint()..color = Colors.white,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// ─────────────────────────────────────────────────────────────────────────────
// PARTICLE PAINTER — tiny floating seed/leaf dots
// ─────────────────────────────────────────────────────────────────────────────
class _ParticlePainter extends CustomPainter {
  final double progress;

  _ParticlePainter(this.progress);

  static final List<_Particle> _particles = List.generate(18, (i) {
    final rng = Random(i * 7 + 3);
    return _Particle(
      x: rng.nextDouble(),
      y: rng.nextDouble(),
      size: rng.nextDouble() * 3 + 1.5,
      speed: rng.nextDouble() * 0.18 + 0.06,
      opacity: rng.nextDouble() * 0.25 + 0.08,
      drift: rng.nextDouble() * 0.04 - 0.02,
    );
  });

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in _particles) {
      final y = ((p.y - progress * p.speed) % 1.0 + 1.0) % 1.0;
      final x = p.x + sin(progress * 2 * pi + p.y * 10) * p.drift;

      canvas.drawCircle(
        Offset(x * size.width, y * size.height),
        p.size,
        Paint()
          ..color = Colors.white.withOpacity(p.opacity)
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter old) =>
      old.progress != progress;
}

class _Particle {
  final double x, y, size, speed, opacity, drift;
  const _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.drift,
  });
}

// ─────────────────────────────────────────────────────────────────────────────
// WAVE PAINTER — decorative bottom wave
// ─────────────────────────────────────────────────────────────────────────────
class _WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.05)
      ..style = PaintingStyle.fill;

    // Wave 1
    final path1 = Path()
      ..moveTo(0, size.height * 0.55)
      ..cubicTo(
        size.width * 0.25, size.height * 0.35,
        size.width * 0.55, size.height * 0.75,
        size.width, size.height * 0.50,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path1, paint);

    // Wave 2 (lighter, higher)
    final paint2 = Paint()
      ..color = Colors.white.withOpacity(0.04)
      ..style = PaintingStyle.fill;

    final path2 = Path()
      ..moveTo(0, size.height * 0.70)
      ..cubicTo(
        size.width * 0.3, size.height * 0.45,
        size.width * 0.65, size.height * 0.85,
        size.width, size.height * 0.62,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}