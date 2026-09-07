import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),

      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(
          'Help & Support',
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
            Text(
              'Frequently Asked Questions',
              style: GoogleFonts.inter(
                fontSize: context.width * 0.045,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),

            SizedBox(height: context.height * 0.015),

            _faqTile(
              context,
              question: 'How do I report a complaint?',
              answer:
                  'Go to the Report Complaint section from the Home screen. '
                  'Enter the required complaint details, select the waste type, '
                  'add a photo if needed, and select your current location. '
                  'Then tap Submit Complaint.',
            ),

            _faqTile(
              context,
              question: 'How do I check my complaint status?',
              answer:
                  'Open the My Complaints section to see all your submitted '
                  'complaints. Each complaint displays its current status such '
                  'as Pending, In Progress, or Completed.',
            ),

            _faqTile(
              context,
              question: 'How does location detection work?',
              answer:
                  'EcoTrack uses your device GPS to detect your current '
                  'location. Make sure location services are turned on and '
                  'allow location permission when requested.',
            ),

            _faqTile(
              context,
              question: 'What do the complaint statuses mean?',
              answer:
                  'Pending means your complaint has been submitted and is '
                  'waiting for action. In Progress means the complaint is '
                  'currently being handled. Completed means the complaint '
                  'has been resolved.',
            ),

            SizedBox(height: context.height * 0.030),

            Text(
              'Need more help?',
              style: GoogleFonts.inter(
                fontSize: context.width * 0.045,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),

            SizedBox(height: context.height * 0.012),

            Container(
              width: double.infinity,
              padding: EdgeInsets.all(context.width * 0.045),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(context.width * 0.035),
                border: Border.all(color: const Color(0xFFE5E7EB)),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.email_outlined,
                    size: context.width * 0.060,
                    color: AppColors.primaryColor,
                  ),

                  SizedBox(width: context.width * 0.030),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Email Support',
                        style: GoogleFonts.inter(
                          fontSize: context.width * 0.035,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF374151),
                        ),
                      ),

                      SizedBox(height: context.height * 0.004),

                      Text(
                        'support@ecotrack.com',
                        style: GoogleFonts.inter(
                          fontSize: context.width * 0.033,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF6B7280),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _faqTile(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: context.height * 0.012),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(context.width * 0.035),
        border: Border.all(color: const Color(0xFFE5E7EB)),
      ),
      child: ExpansionTile(
        tilePadding: EdgeInsets.symmetric(horizontal: context.width * 0.040),
        childrenPadding: EdgeInsets.only(
          left: context.width * 0.040,
          right: context.width * 0.040,
          bottom: context.height * 0.020,
        ),
        title: Text(
          question,
          style: GoogleFonts.inter(
            fontSize: context.width * 0.035,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1F2937),
          ),
        ),
        iconColor: AppColors.primaryColor,
        collapsedIconColor: const Color(0xFF79808C),
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              answer,
              style: GoogleFonts.inter(
                fontSize: context.width * 0.032,
                height: 1.5,
                color: const Color(0xFF6B7280),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
