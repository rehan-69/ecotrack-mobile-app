import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class ComplaintDetailScreen extends StatelessWidget {
  const ComplaintDetailScreen({super.key});

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

          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.05,
              vertical: context.height * 0.02,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(context.width * 0.05),
              child: Stack(
                children: [
                  Image.asset(
                    'assets/waste1.png',
                    width: double.infinity,
                    height: context.height * 0.23,
                    fit: BoxFit.cover,
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
                        'ECO-1042',
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

          Padding(
            padding: EdgeInsets.only(right: context.width * 0.44),
            child: Text(
              'Household Waste',
              style: GoogleFonts.inter(
                fontSize: context.width * 0.050,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
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
                  'In Progress',
                  style: GoogleFonts.inter(
                    fontSize: context.width * 0.032,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 238, 151, 1),
                  ),
                ),
              ),

              SizedBox(width: context.width * 0.03),

              Text(
                'Submitted 12 Mar 2026',
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
                    'Ward 07, MG Road, Nashik 422001',
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
            // padding: EdgeInsets.only(left: context.width * 0.055,right: context.width * 0.050),
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.060),
            child: Text(
              'Garbage bin near the bus stop has been overflowing for three '
              'days. Strong smell and stray animals around it.',
              style: GoogleFonts.inter(
                fontSize: context.width * 0.037,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF6B7280),
                height: 1.4,
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
                TimelineTile(
                  alignment: TimelineAlign.start,
                  isFirst: true,
                  indicatorStyle: IndicatorStyle(
                    width: context.width * 0.055,
                    color: const Color(0xFF2E7D32),
                    iconStyle: IconStyle(
                      iconData: Icons.check,
                      color: Colors.white,
                      fontSize: context.width * 0.035,
                    ),
                  ),
                  afterLineStyle: const LineStyle(
                    color: Color(0xFF2E7D32),
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
                          '12 Mar · 09:12 AM',
                          style: GoogleFonts.inter(
                            fontSize: context.width * 0.030,
                            fontWeight: FontWeight.w400,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                TimelineTile(
                  alignment: TimelineAlign.start,
                  indicatorStyle: IndicatorStyle(
                    width: context.width * 0.055,
                    color: const Color(0xFF2E7D32),
                    iconStyle: IconStyle(
                      iconData: Icons.check,
                      color: Colors.white,
                      fontSize: context.width * 0.035,
                    ),
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Color(0xFF2E7D32),
                    thickness: 2,
                  ),
                  afterLineStyle: const LineStyle(
                    color: Color(0xFFE5E7EB),
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
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                        Text(
                          '12 Mar · 02:40 PM',
                          style: GoogleFonts.inter(
                            fontSize: context.width * 0.030,
                            color: const Color(0xFF9CA3AF),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                TimelineTile(
                  alignment: TimelineAlign.start,
                  isLast: true,
                  indicatorStyle: IndicatorStyle(
                    width: context.width * 0.055,
                    color: Colors.white,
                    indicator: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFFE5E7EB),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                  beforeLineStyle: const LineStyle(
                    color: Color(0xFFE5E7EB),
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
                            color: const Color(0xFF6B7280),
                          ),
                        ),
                        Text(
                          'Awaiting confirmation',
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
                      color: const Color(0xFF2E7D32),
                    ),
                  ),

                  SizedBox(height: context.height * 0.008),

                  Text(
                    'Collection vehicle assigned to Ward 07. '
                    'Clearance scheduled before 6 PM today.',
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
    );
  }
}
