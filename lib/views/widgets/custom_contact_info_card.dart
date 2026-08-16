import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';

class CustomContactInfoCard extends StatelessWidget {
  final String email;
  final String phone;

  const CustomContactInfoCard({
    super.key,
    required this.email,
    required this.phone,
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
          border: Border.all(color: const Color(0xFFE5E7EB), width: 1),
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
            Row(
              children: [
                Container(
                  height: context.width * 0.12,
                  width: context.width * 0.12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF4F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.email_outlined,
                    size: context.width * 0.055,
                    color: const Color(0xFF79808C),
                  ),
                ),

                SizedBox(width: context.width * 0.040),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Email',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.030,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF79808C),
                      ),
                    ),

                    SizedBox(height: context.height * 0.002),

                    Text(
                      email,
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ],
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

            // Phone
            Row(
              children: [
                Container(
                  height: context.width * 0.12,
                  width: context.width * 0.12,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF4F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.phone_android_outlined,
                    size: context.width * 0.055,
                    color: const Color(0xFF79808C),
                  ),
                ),

                SizedBox(width: context.width * 0.040),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Phone',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.030,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF79808C),
                      ),
                    ),

                    SizedBox(height: context.height * 0.002),

                    Text(
                      phone,
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.035,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
