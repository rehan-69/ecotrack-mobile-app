import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/home_models.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';

class ComplaintDetailScreen extends StatelessWidget {
  final RecentComplaint complaint;
  const ComplaintDetailScreen({super.key, required this.complaint});

  @override
  Widget build(BuildContext context) {
    final imagePath = complaint.image?.isNotEmpty == true
        ? complaint.image!.first
        : null;

    final imageUrl = imagePath == null
        ? null
        : (imagePath.startsWith('http://') || imagePath.startsWith('https://'))
        ? imagePath
        : 'https://ecotrack-mobile-backend.onrender.com$imagePath';
    String _formatDate(DateTime date) {
      final months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec',
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    }

    String _formatTime(DateTime date) {
      final hour = date.hour % 12 == 0 ? 12 : date.hour % 12;
      final minute = date.minute.toString().padLeft(2, '0');
      final period = date.hour >= 12 ? 'PM' : 'AM';

      return '$hour:$minute $period';
    }

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            Divider(
              color: const Color(0xFFE5E7EB),
              thickness: 1,
              height: context.height * 0.025,
            ),

            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: context.width * 0.05,
                vertical: context.height * 0.02,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.width * 0.05),
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.width * 0.05),
                      child: SizedBox(
                        width: double.infinity,
                        height: context.height * 0.23,

                        child: Image(
                          image: imageUrl != null
                              ? NetworkImage(imageUrl)
                              : const AssetImage('assets/waste1.png')
                                    as ImageProvider,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            debugPrint('DETAIL IMAGE ERROR: $error');
                            debugPrint('DETAIL IMAGE URL: $imageUrl');

                            return Image.asset(
                              'assets/waste1.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: context.height * 0.015,
                      left: context.width * 0.025,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.035,
                          vertical: context.height * 0.007,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF26374A),
                          borderRadius: BorderRadius.circular(
                            context.width * 0.04,
                          ),
                        ),
                        child: Text(
                          complaint.complaintId,
                          style: GoogleFonts.inter(
                            fontSize: context.width * 0.030,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: context.width * 0.06),
                child: Text(
                  complaint.wasteType,
                  style: GoogleFonts.inter(
                    fontSize: context.width * 0.050,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1F2937),
                  ),
                ),
              ),
            ),
            SizedBox(height: context.height * 0.01),

            Row(
              children: [
                SizedBox(width: context.width * 0.05),

                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.030,
                    vertical: context.height * 0.008,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF6E7),
                    borderRadius: BorderRadius.circular(context.width * 0.025),
                  ),
                  child: Text(
                    complaint.status,
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.032,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 238, 151, 1),
                    ),
                  ),
                ),

                SizedBox(width: context.width * 0.03),

                Text(
                  'Submitted ${_formatDate(complaint.createdAt)}',
                  style: GoogleFonts.inter(
                    fontSize: context.width * 0.032,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
            SizedBox(height: context.height * 0.02),

            Row(
              children: [
                SizedBox(width: context.width * 0.05),

                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: context.width * 0.060,
                      color: const Color(0xFF9CA3AF),
                    ),

                    SizedBox(width: context.width * 0.015),

                    Text(
                      complaint.location,
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.035,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            SizedBox(height: context.height * 0.015),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.07),
              child: SizedBox(
                width: double.infinity,
                child: Text(
                  complaint.description,
                  textAlign: TextAlign.justify,
                  style: GoogleFonts.inter(
                    fontSize: context.width * 0.037,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6B7280),
                    height: 1.4,
                  ),
                ),
              ),
            ),

            SizedBox(height: context.height * 0.005),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.050),
              child: Divider(
                color: const Color(0xFFE5E7EB),
                thickness: 1,
                height: context.height * 0.025,
              ),
            ),

            SizedBox(height: context.height * 0.005),

            Padding(
              padding: EdgeInsets.only(right: context.width * 0.53),
              child: Text(
                'Status Timeline',
                style: GoogleFonts.inter(
                  fontSize: context.width * 0.045,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF1F2937),
                ),
              ),
            ),
            SizedBox(height: context.height * 0.01),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.090),
              child: Column(
                children: [
                  // =========================
                  // SUBMITTED
                  // =========================
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    isFirst: true,

                    indicatorStyle: IndicatorStyle(
                      width: context.width * 0.055,
                      color: AppColors.primaryColor,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: context.width * 0.035,
                      ),
                    ),

                    afterLineStyle: const LineStyle(
                      color: AppColors.primaryColor,
                      thickness: 2,
                    ),

                    endChild: Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.025,
                        bottom: context.height * 0.015,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Submitted',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.038,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                          Text(
                            '${_formatDate(complaint.createdAt)} · '
                            '${_formatTime(complaint.createdAt)}',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.030,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // =========================
                  // PENDING
                  // =========================
                  TimelineTile(
                    alignment: TimelineAlign.start,

                    indicatorStyle: IndicatorStyle(
                      width: context.width * 0.055,
                      color: AppColors.primaryColor,
                      iconStyle: IconStyle(
                        iconData: Icons.check,
                        color: Colors.white,
                        fontSize: context.width * 0.035,
                      ),
                    ),

                    beforeLineStyle: const LineStyle(
                      color: AppColors.primaryColor,
                      thickness: 2,
                    ),

                    afterLineStyle: LineStyle(
                      color: complaint.status == 'Pending'
                          ? const Color(0xFFE5E7EB)
                          : AppColors.primaryColor,
                      thickness: 2,
                    ),

                    endChild: Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.025,
                        bottom: context.height * 0.015,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Pending',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.038,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                          ),

                          // Submitted aur Pending SAME time
                          Text(
                            '${_formatDate(complaint.createdAt)} · '
                            '${_formatTime(complaint.createdAt)}',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.030,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),

                          Text(
                            'Awaiting municipal action',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.030,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // =========================
                  // IN PROGRESS
                  // =========================
                  TimelineTile(
                    alignment: TimelineAlign.start,

                    indicatorStyle: IndicatorStyle(
                      width: context.width * 0.055,
                      color:
                          complaint.status == 'In Progress' ||
                              complaint.status == 'Completed'
                          ? AppColors.primaryColor
                          : Colors.white,

                      indicator:
                          complaint.status == 'In Progress' ||
                              complaint.status == 'Completed'
                          ? null
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                  width: 2,
                                ),
                              ),
                            ),

                      iconStyle:
                          complaint.status == 'In Progress' ||
                              complaint.status == 'Completed'
                          ? IconStyle(
                              iconData: Icons.check,
                              color: Colors.white,
                              fontSize: context.width * 0.035,
                            )
                          : null,
                    ),

                    beforeLineStyle: const LineStyle(
                      color: AppColors.primaryColor,
                      thickness: 2,
                    ),

                    afterLineStyle: LineStyle(
                      color: complaint.status == 'Completed'
                          ? AppColors.primaryColor
                          : const Color(0xFFE5E7EB),
                      thickness: 2,
                    ),

                    endChild: Padding(
                      padding: EdgeInsets.only(
                        left: context.width * 0.025,
                        bottom: context.height * 0.015,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'In Progress',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.038,
                              fontWeight: FontWeight.w700,
                              color:
                                  complaint.status == 'In Progress' ||
                                      complaint.status == 'Completed'
                                  ? const Color(0xFF1F2937)
                                  : const Color(0xFF6B7280),
                            ),
                          ),

                          // DB se actual In Progress time
                          if (complaint.statusHistory.any(
                            (h) => h.status == 'In Progress',
                          ))
                            Text(
                              '${_formatDate(complaint.statusHistory.lastWhere((h) => h.status == 'In Progress').createdAt)} · ${_formatTime(complaint.statusHistory.lastWhere((h) => h.status == 'In Progress').createdAt)}',
                              style: GoogleFonts.inter(
                                fontSize: context.width * 0.030,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),

                          Text(
                            complaint.status == 'Pending'
                                ? 'Waiting for municipal action'
                                : 'Complaint is being handled',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.030,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // =========================
                  // COMPLETED
                  // =========================
                  TimelineTile(
                    alignment: TimelineAlign.start,
                    isLast: true,

                    indicatorStyle: IndicatorStyle(
                      width: context.width * 0.055,
                      color: complaint.status == 'Completed'
                          ? AppColors.primaryColor
                          : Colors.white,

                      indicator: complaint.status == 'Completed'
                          ? null
                          : Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: const Color(0xFFE5E7EB),
                                  width: 2,
                                ),
                              ),
                            ),

                      iconStyle: complaint.status == 'Completed'
                          ? IconStyle(
                              iconData: Icons.check,
                              color: Colors.white,
                              fontSize: context.width * 0.035,
                            )
                          : null,
                    ),

                    beforeLineStyle: LineStyle(
                      color: complaint.status == 'Completed'
                          ? AppColors.primaryColor
                          : const Color(0xFFE5E7EB),
                      thickness: 2,
                    ),

                    endChild: Padding(
                      padding: EdgeInsets.only(left: context.width * 0.025),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Completed',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.038,
                              fontWeight: FontWeight.w700,
                              color: complaint.status == 'Completed'
                                  ? const Color(0xFF1F2937)
                                  : const Color(0xFF6B7280),
                            ),
                          ),

                          // DB se actual Completed time
                          if (complaint.statusHistory.any(
                            (h) => h.status == 'Completed',
                          ))
                            Text(
                              '${_formatDate(complaint.statusHistory.lastWhere((h) => h.status == 'Completed').createdAt)} · ${_formatTime(complaint.statusHistory.lastWhere((h) => h.status == 'Completed').createdAt)}',
                              style: GoogleFonts.inter(
                                fontSize: context.width * 0.030,
                                color: const Color(0xFF9CA3AF),
                              ),
                            ),

                          Text(
                            complaint.status == 'Completed'
                                ? 'Complaint resolved successfully'
                                : 'Awaiting confirmation',
                            style: GoogleFonts.inter(
                              fontSize: context.width * 0.030,
                              color: const Color(0xFF9CA3AF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: context.height * 0.015),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.050),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(context.width * 0.035),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F7F1),
                  borderRadius: BorderRadius.circular(context.width * 0.035),
                  border: Border.all(
                    color: const Color.fromARGB(255, 217, 219, 224),
                    width: 1,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Municipality Remarks',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.040,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(height: context.height * 0.008),

                    Text(
                      complaint.municipalityRemark?.isNotEmpty == true
                          ? complaint.municipalityRemark!
                          : 'No municipality remark available.',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.033,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
