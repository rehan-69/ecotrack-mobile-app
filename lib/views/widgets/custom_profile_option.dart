import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';

class CustomProfileOption extends StatelessWidget {
  final VoidCallback? onHelpSupport;
  final VoidCallback? onAboutEcoTrack;

  const CustomProfileOption({
    super.key,
    this.onHelpSupport,
    this.onAboutEcoTrack,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: context.width * 0.040,
        vertical: context.height * 0.020,
      ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.040,
          vertical: context.height * 0.015,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: const Color(0xFFE5E7EB),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [
            BoxShadow(
              color: Color(0x12000000),
              blurRadius: 8,
              spreadRadius: 0,
              offset: Offset(0, 3),
            ),
          ],
        ),

        child: Column(
          children: [
            // Help & Support
            GestureDetector(
              onTap: onHelpSupport,
              child: Row(
                children: [
                  Container(
                    height: context.width * 0.12,
                    width: context.width * 0.12,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F7F1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.help_outline,
                      size: context.width * 0.055,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  SizedBox(
                    width: context.width * 0.040,
                  ),

                  Expanded(
                    child: Text(
                      'Help & Support',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.040,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    size: context.width * 0.060,
                    color: const Color(0xFF9CA3AF),
                  ),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.only(
                left: context.width * 0.13,
                right: context.width * 0.01,
              ),
              child: Divider(
                color: const Color(0xFFE5E7EB),
                thickness: 1,
                height: context.height * 0.025,
              ),
            ),

            // About EcoTrack
            GestureDetector(
              onTap: onAboutEcoTrack,
              child: Row(
                children: [
                  Container(
                    height: context.width * 0.12,
                    width: context.width * 0.12,
                    decoration: const BoxDecoration(
                      color: Color(0xFFF1F7F1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.info_outline,
                      size: context.width * 0.055,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  SizedBox(
                    width: context.width * 0.040,
                  ),

                  Expanded(
                    child: Text(
                      'About EcoTrack',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.040,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ),

                  Icon(
                    Icons.chevron_right,
                    size: context.width * 0.060,
                    color: const Color(0xFF9CA3AF),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}