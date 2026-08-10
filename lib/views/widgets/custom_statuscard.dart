import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';

class StatusCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Border cardBorder;
  final Color cardColor;
  final Color textSubtitleColor;
  final Color textTitleColor;

  const StatusCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.cardBorder,
    required this.cardColor,
    required this.textSubtitleColor,
    required this.textTitleColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(context.width * 0.040),
      decoration: BoxDecoration(
        color: cardColor,
        border: cardBorder,
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 221, 219, 219),
            blurRadius: 8,
            spreadRadius: 1,
            offset: Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(context.width * 0.030),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              title,
              style:  GoogleFonts.inter(
                fontSize: context.width * 0.045,
                fontWeight: FontWeight.w700,
                color: textTitleColor,
              ),
            ),
          ),

          SizedBox(height: context.height * 0.006),

          Center(
            child: Text(
              subtitle,
              style:  GoogleFonts.inter(
                fontSize: context.width * 0.034,
                fontWeight: FontWeight.w400,
                color: textSubtitleColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
