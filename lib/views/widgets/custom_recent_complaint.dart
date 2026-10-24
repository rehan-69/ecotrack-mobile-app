import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/home_models.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/services/complaint_service.dart';
import 'package:project/views/screens/my_complaint_detail_screen.dart';

class CustomRecentComplaint extends StatelessWidget {
  final RecentComplaint complaint;
  final double? width;
  final double? height;

  final Widget? infoRow;

  final Color progressColor;

  const CustomRecentComplaint({
    super.key,
    this.infoRow,
    required this.complaint,
    required this.width,
    required this.height,
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
        onTap: () async {
          try {
            final complaintService = ComplaintService();

            // Backend se latest complaint + status history lao
            final complaintDetail = await complaintService.getComplaintById(
              complaint.id,
            );

            if (!context.mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ComplaintDetailScreen(complaint: complaintDetail),
              ),
            );
          } catch (e) {
            if (!context.mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to load complaint details')),
            );
          }
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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          iconTheme: IconThemeData(color: Colors.white),
                        ),
                        body: PhotoView(
                          imageProvider: complaint.image?.isNotEmpty == true
                              ? NetworkImage(
                                  'http://https://ecotrack-mobile-backend.onrender.com${complaint.image!.first}',
                                )
                              : const AssetImage('assets/waste1.png'),
                        ),
                      ),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: complaint.image?.isNotEmpty == true
                      ? Image.network(
                          'http://https://ecotrack-mobile-backend.onrender.com${complaint.image!.first}',
                          height: height,
                          width: width,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            print('IMAGE ERROR: $error');
                            print('IMAGE URL: ${complaint.image!.first}');
                            return const Icon(Icons.image_not_supported);
                          },
                        )
                      : Image.asset(
                          'assets/waste1.png',
                          height: height,
                          width: width,
                          fit: BoxFit.cover,
                        ),
                ),
              ),

              SizedBox(width: context.width * 0.040),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      complaint.complaintId,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.040,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF1F2937),
                      ),
                    ),

                    Text(
                      complaint.wasteType,
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
                      complaint.location,
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
                  complaint.status,
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
