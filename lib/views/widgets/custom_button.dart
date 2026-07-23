import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double width;
  final double height;
  final String? image;
  final double borderRadius;
  final double fontSize;
  final Border border;
  final FontWeight fontWeight;
  final bool isLoading;

  const CustomButton({
    super.key,
    this.image,
    required this.text,
    required this.onPressed,
    this.color = AppColors.primaryColor,
    this.textColor = AppColors.appWhiteColor,
    this.border = const Border(),
    required this.width,
    required this.height,
    required this.borderRadius,
    required this.fontSize,
    required this.fontWeight,
    this.isLoading = false,
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
            if (image != null)
              Image.asset(
                image!,
                height: context.width * 0.047,
                width: context.width * 0.047,
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
