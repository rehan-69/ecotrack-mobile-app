import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/onboarding/onboarding1_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 1), () {
      if (!mounted) return;

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const Onboarding1Screen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xff7164F7), Color(0xff5C4EF2)],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  /// Logo
                  Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xff8E7DFF).withOpacity(.35),
                          blurRadius: 35,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Image.asset(
                      "assets/logo.png",
                      width: context.width * .44,
                      height: context.width * .44,
                    ),
                  ),

                  SizedBox(height: context.height * .02),

                  /// App Name
                  Text(
                    "Aurora",
                    style: GoogleFonts.inter(
                      fontSize: context.width * .095,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 1.2,
                      color: AppColors.appWhiteColor,
                    ),
                  ),

                  SizedBox(height: context.height * .012),

                  /// Tagline
                  Text(
                    "Stop the world, elegantly",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: context.width * .043,
                      fontWeight: FontWeight.w500,
                      color: AppColors.appWhite70,
                      letterSpacing: .3,
                    ),
                  ),

                  SizedBox(height: context.height * .045),

                  /// Loader
                  const SizedBox(
                    width: 28,
                    height: 28,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.8,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        AppColors.appWhiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
