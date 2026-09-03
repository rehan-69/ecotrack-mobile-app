import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/viewmodel/complaint_provider.dart';
import 'package:project/views/widgets/custom_text_field.dart';
import 'package:project/views/widgets/dropdown_button_field.dart';
import 'package:project/views/widgets/custom_image_picker_button.dart';

class ReportComplaintScreen extends StatelessWidget {
  const ReportComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ComplaintProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            scrolledUnderElevation: 0,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
            title: Text(
              'Report Complaint',
              style: TextStyle(
                fontSize: context.width * 0.060,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
          ),
          body: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            physics: const BouncingScrollPhysics(),
            child: Column(
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
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.05,
                  ),
                  child: value.selectedImages.isEmpty
                      ? Container(
                          width: double.infinity,
                          height: context.height * 0.18,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFCFA),
                            border: Border.all(
                              color: Color(0xFFB5DEB7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              context.width * 0.050,
                            ),
                          ),
                          child: Column(
                            children: [
                              SizedBox(height: context.height * 0.025),

                              Container(
                                height: context.width * 0.12,
                                width: context.width * 0.12,
                                decoration: const BoxDecoration(
                                  color: AppColors.primaryColor,

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
                        )
                      : Container(
                          width: double.infinity,
                          height: context.height * 0.18,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFAFCFA),
                            border: Border.all(
                              color: const Color(0xFFB5DEB7),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(
                              context.width * 0.050,
                            ),
                          ),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: value.selectedImages.length,
                            itemBuilder: (context, index) {
                              final image = value.selectedImages[index];

                              return Padding(
                                padding: EdgeInsets.only(
                                  right: context.width * 0.025,
                                ),
                                child: Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(
                                      context.width * 0.035,
                                    ),
                                    child: Image.file(
                                      File(value.selectedImages[index].path),
                                      width: context.width * 0.42,
                                      height: context.height * 0.165,
                                      fit: BoxFit.cover,
                                      cacheWidth: 500,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                ),

                SizedBox(height: context.height * 0.02),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomImagePickerButton(
                      onTap: () {
                        value.pickImageFromCamera();
                        value.selectCameraFeature('Camera');
                      },
                      icon: Icons.camera_alt_outlined,
                      title: 'Camera',
                      backgroundColor: value.camera == 'Camera'
                          ? AppColors.primaryColor
                          : Colors.white,

                      borderColor: value.camera == 'Camera'
                          ? AppColors.primaryColor
                          : Colors.white,

                      iconColor: value.camera == 'Camera'
                          ? Colors.white
                          : AppColors.primaryColor,

                      textColor: value.camera == 'Camera'
                          ? Colors.white
                          : AppColors.primaryColor,
                    ),
                    CustomImagePickerButton(
                      onTap: () {
                        value.pickImageFromGallery();
                        value.selectCameraFeature('Gallery');
                      },

                      icon: Icons.photo_library_outlined,
                      title: 'Gallery',
                      backgroundColor: value.camera == 'Gallery'
                          ? AppColors.primaryColor
                          : Colors.white,

                      borderColor: value.camera == 'Gallery'
                          ? AppColors.primaryColor
                          : Colors.white,

                      iconColor: value.camera == 'Gallery'
                          ? Colors.white
                          : AppColors.primaryColor,

                      textColor: value.camera == 'Gallery'
                          ? Colors.white
                          : AppColors.primaryColor,
                    ),
                  ],
                ),

                SizedBox(height: context.height * 0.020),

                Padding(
                  padding: EdgeInsets.only(right: context.width * 0.58),
                  child: Text(
                    'Complaint Title',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.040,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.040,
                    vertical: context.height * 0.010,
                  ),
                  child: CustomTextField(
                    controller: value.titleController,
                    height: context.height * 0.072,
                    color: Color(0xFFFFFFFF),
                    borderRadius: context.width * 0.04,
                    fontSize: context.width * 0.041,
                    title: 'e.g. Garbage not collected',
                    borderColor: const Color(0xFFE5E7EB),
                  ),
                ),

                SizedBox(height: context.height * 0.005),

                Padding(
                  padding: EdgeInsets.only(right: context.width * 0.65),
                  child: Text(
                    'Description',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.040,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.040,
                    vertical: context.height * 0.010,
                  ),
                  child: CustomTextField(
                    controller: value.descriptionController,
                    maxLines: 5,
                    height: context.height * 0.12,
                    color: Color(0xFFFFFFFF),
                    borderRadius: context.width * 0.04,
                    fontSize: context.width * 0.041,
                    title: 'Describe the issue briefly...',
                    borderColor: const Color(0xFFE5E7EB),
                  ),
                ),

                SizedBox(height: context.height * 0.010),

                Padding(
                  padding: EdgeInsets.only(right: context.width * 0.65),
                  child: Text(
                    'Waste Type',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.040,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.040,
                    vertical: context.height * 0.010,
                  ),
                  child: DropdownButtonField(),
                ),

                SizedBox(height: context.height * 0.001),

                Padding(
                  padding: EdgeInsets.only(right: context.width * 0.70),
                  child: Text(
                    'Location',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.040,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),
                ),

                SizedBox(height: context.height * 0.005),

                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.040,
                    vertical: context.height * 0.010,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      value.getCurrentLocation();
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.040,
                        vertical: context.height * 0.018,
                      ),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F7F1),
                        borderRadius: BorderRadius.circular(
                          context.width * 0.045,
                        ),
                        border: Border.all(
                          color: const Color(0xFFB5DEB7),
                          width: 1.5,
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            size: context.width * 0.065,
                            color: AppColors.primaryColor,
                          ),

                          SizedBox(width: context.width * 0.035),

                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Use Current Location',
                                style: GoogleFonts.inter(
                                  fontSize: context.width * 0.038,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primaryColor,
                                ),
                              ),

                              SizedBox(height: context.height * 0.003),

                              Text(
                                'GPS accuracy within 8 m',
                                style: GoogleFonts.inter(
                                  fontSize: context.width * 0.032,
                                  fontWeight: FontWeight.w400,
                                  color: const Color(0xFF79808C),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: context.height * 0.010),

                CustomButton(
                  text: 'Submit Complaint',
                  onPressed: () async {
                    if (value.latitude == null || value.longitude == null) {
                      value.errorMessage =
                          'Please select your current location';
                      value.notifyListeners();
                      return;
                    }

                    final images = value.selectedImages
                        .map((image) => image.path)
                        .toList();

                    await value.createComplaint(
                      description: value.descriptionController.text,
                      image: images,
                      title: value.titleController.text,
                      wasteType: value.selectedWaste!,
                      location: value.selectedLocation ?? '',
                      latitude: value.latitude!,
                      longitude: value.longitude!,
                    );
                  },
                  width: context.width * 0.93,
                  height: context.height * 0.065,
                  borderRadius: context.width * 0.035,
                  fontSize: context.width * 0.040,
                  fontWeight: FontWeight.bold,
                ),

                SizedBox(height: context.height * 0.010),
              ],
            ),
          ),
        );
      },
    );
  }
}
