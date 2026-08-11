import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';

class ComplaintFilterChip extends StatelessWidget {
  final String title;
  const ComplaintFilterChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.050,
        vertical: context.height * 0.015,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Color(0xFFE5E7EB)),
      ),
      child: Text(
        title,
        style: GoogleFonts.inter(
          color: Color(0xFF6B7280),
          fontWeight: FontWeight.bold,
          fontSize: context.width * 0.030,
        ),
      ),
    );
  }
}
