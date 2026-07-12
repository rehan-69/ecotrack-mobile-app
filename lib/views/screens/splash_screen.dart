import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: context.height * 0.120,
              width: context.width * 0.60,
              decoration: BoxDecoration(
                color: Color(0xFF837DEB),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Container(
                  height: context.height * 0.060,
                  width: context.width * 0.30,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
            SizedBox(height: context.height*0.02,),
            Text(
              'Aurora',
              style: GoogleFonts.inter(
                color: Color(0xFFFFFFFF),
                fontSize: context.width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: context.height*0.02,),

            Text(
              'Stop the world, elegantly',
              style: GoogleFonts.inter(
                color: const Color(0xFFD6D7E8),
                fontSize: context.width * 0.04,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
