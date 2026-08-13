import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final Color? color;
  final String title;
  final double height;
  final int? maxLines;
  final double fontSize;
  final Color? iconColor;
  final bool obscureText;
  final String? labelText;
  final Color? borderColor;
  final IconData? prefixIcon;
  final double borderRadius;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final TextInputType keyboardType;
  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;

  const CustomTextField({
    super.key,
    this.maxLines,
    this.onChanged,
    this.validator,
    this.suffixIcon,
    this.onSuffixTap,
    required this.title,
    required this.fontSize,
    this.borderColor,
    this.color,
    required this.height,
    this.labelText,
    this.iconColor,
    this.controller,
    this.prefixIcon,
    this.obscureText = false,
    required this.borderRadius,
    this.keyboardType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      width: double.infinity,
      height: height,
      child: TextFormField(
        controller: controller,
        validator: validator,
        onChanged: onChanged,
         maxLines: maxLines ?? 1,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: size.width * 0.042,
          color: Colors.black87,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: title,
          labelText: labelText,
          labelStyle: TextStyle(color: AppColors.primaryColor),
          hintStyle: GoogleFonts.inter(
            color: Color(0xFF9CA3AF),
            fontSize: fontSize,
            fontWeight: FontWeight.w400,
          ),

          filled: true,
          fillColor: color,

          prefixIcon: prefixIcon != null
              ? Icon(prefixIcon, color: iconColor, size: size.width * 0.06)
              : null,

          suffixIcon: suffixIcon != null
              ? InkWell(
                  onTap: onSuffixTap,
                  child: Icon(
                    suffixIcon,
                    color: iconColor,
                    size: size.width * 0.06,
                  ),
                )
              : null,

          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.045,
            vertical: size.height * 0.018,
          ),

          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor ?? Colors.black,
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(
              color: borderColor ?? const Color(0xFF2E7D32),
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.red),
          ),

          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
        ),
      ),
    );
  }
}
