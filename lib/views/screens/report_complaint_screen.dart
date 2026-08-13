import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/custom_image_picker_button.dart';

class ReportComplaintScreen extends StatelessWidget {
  const ReportComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Complaints Details',
          style: TextStyle(
            fontSize: context.width * 0.060,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1F2937),
          ),
        ),
      ),
      body: Column(
        children: [
          Divider(
            color: const Color(0xFFE5E7EB),
            thickness: 1,
            height: context.height * 0.025,
          ),

          SizedBox(height: context.height * 0.010),

          Padding(
            padding: EdgeInsets.only(right: context.width * 0.55),
            child: Text(
              'PHOTO EVIDENCE',
              style: GoogleFonts.inter(
                fontSize: context.width * 0.035,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF79808C),
              ),
            ),
          ),
          SizedBox(height: context.height * 0.010),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.05),
            child: Container(
              width: double.infinity,
              height: context.height * 0.18,
              decoration: BoxDecoration(
                color: const Color(0xFFFAFCFA),
                border: Border.all(color: Color(0xFFB5DEB7), width: 1),
                borderRadius: BorderRadius.circular(context.width * 0.050),
              ),
              child: Column(
                children: [
                  SizedBox(height: context.height * 0.025),

                  Container(
                    height: context.width * 0.12,
                    width: context.width * 0.12,
                    decoration: const BoxDecoration(
                      color: Color(0xFF2E7D32),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      size: context.width * 0.055,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: context.height * 0.015),

                  Text(
                    'Add a photo of the waste',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.038,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),

                  SizedBox(height: context.height * 0.005),

                  Text(
                    'JPG or PNG. max 5 MB',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.032,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF9CA3AF),
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: context.height * 0.02),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomImagePickerButton(
                icon: Icons.camera_alt_outlined,
                title: 'Camera',
                backgroundColor: AppColors.primaryColor,
                borderColor: AppColors.primaryColor,
                iconColor: Colors.white,
                textColor: Colors.white,
              ),

              CustomImagePickerButton(
                icon: Icons.photo_library_outlined,
                title: 'Gallery',
                backgroundColor: const Color(0xFFF2F3F5),
                borderColor: const Color(0xFFE5E7EB),
                iconColor: Colors.black,
                textColor: Colors.black,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
