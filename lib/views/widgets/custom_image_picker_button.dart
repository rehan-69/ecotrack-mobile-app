import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';

class CustomImagePickerButton extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;

  const CustomImagePickerButton({
    super.key,
    required this.icon,
    required this.title,
    required this.backgroundColor,
    required this.borderColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: context.height * 0.020,
        horizontal: context.width * 0.11,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: borderColor),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: context.width * 0.045, color: iconColor),

          SizedBox(width: context.width * 0.030),

          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: context.width * 0.035,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
