import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color color;
  final double width;
  final double height;
  final String? image;
  final Border border;
  final bool isLoading;
  final IconData? icon;
  final double fontSize;
  final Color textColor;
  final double borderRadius;
  final FontWeight fontWeight;
  final VoidCallback onPressed;


  const CustomButton({
    super.key,
    this.icon,
    this.image,
    required this.text,
    required this.width,
    required this.height,
    required this.fontSize,
    this.isLoading = false,
    required this.onPressed,
    required this.fontWeight,
    required this.borderRadius,
    this.border = const Border(),
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.appWhiteColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          border: border,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (image != null && !isLoading)
              Image.asset(
                image!,
                height: context.width * 0.047,
                width: context.width * 0.047,
              ),

            if (icon != null && !isLoading)
              Icon(
                icon,
                size: context.width * 0.055,
                color: const Color(0xFFF58585),
              ),

            SizedBox(width: context.width * 0.03),

            isLoading
                ? SizedBox(
                    width: context.width * 0.055,
                    height: context.width * 0.055,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: textColor,
                    ),
                  )
                : Text(
                    text,
                    style: GoogleFonts.inter(
                      color: textColor,
                      fontSize: fontSize,
                      fontWeight: fontWeight,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
