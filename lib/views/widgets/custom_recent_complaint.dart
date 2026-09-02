import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/screens/my_complaint_detail_screen.dart';

class RecentComplaint extends StatelessWidget {
  final String title;
  final String image;
  final double? width;
  final double? height;
  final String progress;
  final Widget? infoRow;
  final String subTitle1;
  final String? subTitle2;
  final Color progressColor;

  const RecentComplaint({
    super.key,
    this.infoRow,
    this.subTitle2,
    required this.title,
    required this.image,
    required this.width,
    required this.height,
    required this.progress,
    required this.subTitle1,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: context.width * 0.035,
        right: context.width * 0.035,
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ComplaintDetailScreen()),
          );
        },
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x30000000),
                blurRadius: 6,
                spreadRadius: -2,
                offset: Offset(0, 5),
              ),
            ],
          ),
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.network(
                  'http://192.168.0.106:3000$image',
                  height: height,
                  width: width,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    print('IMAGE ERROR: $error');
                    print('IMAGE URL: $image');
                    return const Icon(Icons.image_not_supported);
                  },
                ),
              ),

              SizedBox(width: context.width * 0.040),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.040,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),

                    Text(
                      subTitle1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.035,
                        fontWeight: FontWeight.w300,
                        color: const Color(0xFF6B7280),
                      ),
                    ),

                    SizedBox(height: context.height * 0.005),

                    if (infoRow != null) infoRow!,

                    Text(
                      subTitle2 ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.032,
                        color: Color.fromARGB(255, 199, 197, 197),
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.width * 0.030,
                  vertical: context.height * 0.008,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFFBFBFC),
                  borderRadius: BorderRadius.circular(context.width * 0.025),
                ),
                child: Text(
                  progress,
                  style: GoogleFonts.inter(
                    fontSize: context.width * 0.032,
                    fontWeight: FontWeight.bold,
                    color: progressColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
