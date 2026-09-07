import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';

class AboutEcoTrackScreen extends StatelessWidget {
  const AboutEcoTrackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'About EcoTrack',
          style: GoogleFonts.inter(
            fontSize: context.width * 0.050,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.040,
          vertical: context.height * 0.025,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  Container(
                    height: context.width * 0.22,
                    width: context.width * 0.22,
                    decoration: BoxDecoration(
                      color: AppColors.primaryColor.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.eco_outlined,
                      size: context.width * 0.12,
                      color: AppColors.primaryColor,
                    ),
                  ),

                  SizedBox(height: context.height * 0.015),

                  Text(
                    'EcoTrack',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.060,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),

                  SizedBox(height: context.height * 0.005),

                  Text(
                    'Smart Waste Complaint System',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.035,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF79808C),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.height * 0.030),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.width * 0.045),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.width * 0.035),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Text(
                'EcoTrack is a platform that helps citizens '
                'report waste and cleanliness issues in their '
                'local area.',
                style: GoogleFonts.inter(
                  fontSize: context.width * 0.035,
                  height: 1.5,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ),

            SizedBox(height: context.height * 0.025),

            Text(
              'What you can do',
              style: GoogleFonts.inter(
                fontSize: context.width * 0.045,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),

            SizedBox(height: context.height * 0.012),

            _featureItem(
              context,
              icon: Icons.report_problem_outlined,
              text: 'Report waste-related complaints',
            ),

            _featureItem(
              context,
              icon: Icons.camera_alt_outlined,
              text: 'Add photos of the issue',
            ),

            _featureItem(
              context,
              icon: Icons.location_on_outlined,
              text: 'Share your current location',
            ),

            _featureItem(
              context,
              icon: Icons.track_changes_outlined,
              text: 'Track the status of submitted complaints',
            ),

            SizedBox(height: context.height * 0.030),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.width * 0.045),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.width * 0.035),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Column(
                children: [
                  Text(
                    'Version',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.033,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF79808C),
                    ),
                  ),

                  SizedBox(height: context.height * 0.005),

                  Text(
                    '1.0.4',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.040,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),

                  SizedBox(height: context.height * 0.015),

                  Text(
                    '© 2026 Municipal Corporation',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.030,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF79808C),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _featureItem(
    BuildContext context, {
    required IconData icon,
    required String text,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: context.height * 0.010),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(
          horizontal: context.width * 0.040,
          vertical: context.height * 0.018,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(context.width * 0.030),
          border: Border.all(color: const Color(0xFFE5E7EB)),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: context.width * 0.055,
              color: AppColors.primaryColor,
            ),

            SizedBox(width: context.width * 0.030),

            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: context.width * 0.034,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF374151),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
