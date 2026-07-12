import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';

class CustomOnboardingText extends StatelessWidget {
  final String title;
  final String subtitle;

  const CustomOnboardingText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: context.width * 0.068,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
          ),
        ),

        SizedBox(height: context.height * 0.012),

        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: context.width * 0.040,
            color: const Color(0xFF9CA3AF),
            height: 1.5,
          ),
        ),
      ],
    );
  }
}