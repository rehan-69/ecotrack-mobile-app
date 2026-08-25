import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/custom_statuscard.dart';
import 'package:project/views/screens/report_complaint_screen.dart';
import 'package:project/views/widgets/custom_recent_complaint.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (homeProvider.homeData == null && !homeProvider.isLoading) {
        context.read<HomeProvider>().getHomeData();
      }
    });
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF1F8F1),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  color: const Color(0xFFF1F8F1),
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: context.width * 0.080,
                      top: context.height * 0.010,
                      bottom: context.height * 0.010,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                context.read<ProductProvider>().changeIndex(2);
                              },
                              child: CircleAvatar(
                                radius: context.width * 0.087,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: context.width * 0.077,
                                  backgroundImage: const AssetImage(
                                    'assets/avatar.png',
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: context.width * 0.030),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Good morning,',
                                  style: GoogleFonts.inter(
                                    fontSize: context.width * 0.036,
                                    color: const Color(0xFF6B7280),
                                  ),
                                ),
                                Text(
                                  'Rahul Sharma',
                                  style: GoogleFonts.inter(
                                    fontSize: context.width * 0.046,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF1F2937),
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                left: context.width * 0.2,
                              ),
                              child: Container(
                                height: context.width * 0.115,
                                width: context.width * 0.115,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0x1A000000),
                                      blurRadius: 8,
                                      spreadRadius: 1,
                                      offset: Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Icon(
                                  Icons.notifications_none_outlined,
                                  size: context.width * 0.055,
                                  color: const Color(0xFF1F2937),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: context.height * 0.020),

                        Text(
                          'Keep Your City',
                          style: GoogleFonts.inter(
                            fontSize: context.width * 0.065,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF1F2937),
                          ),
                        ),

                        Row(
                          children: [
                            Text(
                              'Clean',
                              style: GoogleFonts.inter(
                                fontSize: context.width * 0.065,
                                fontWeight: FontWeight.w700,
                                color: AppColors.primaryColor,
                              ),
                            ),
                            Icon(
                              Icons.eco,
                              size: context.width * 0.065,
                              color: AppColors.primaryColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportComplaintScreen(),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor,

                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 8,
                            spreadRadius: 1,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      height: context.height * 0.085,
                      child: Row(
                        children: [
                          SizedBox(width: context.width * 0.060),
                          Container(
                            height: context.width * 0.10,
                            width: context.width * 0.10,
                            decoration: const BoxDecoration(
                              color: Colors.white24,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt_outlined,
                              size: context.width * 0.055,
                              color: Colors.white,
                            ),
                          ),

                          SizedBox(width: context.width * 0.040),

                          Padding(
                            padding: EdgeInsets.only(
                              top: context.height * 0.0125,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Report Complaint',
                                  style: GoogleFonts.inter(
                                    fontSize: context.width * 0.050,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),

                                Text(
                                  'Snap, locate & submit in 30s',
                                  style: GoogleFonts.inter(
                                    fontSize: context.width * 0.034,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          SizedBox(width: context.width * 0.16),

                          Icon(
                            Icons.chevron_right,
                            size: context.width * 0.060,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SizedBox(height: context.height * 0.002),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Overview',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.055,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),

                    SizedBox(width: context.width * 0.30),

                    Text(
                      'This month',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.034,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.020),

                Row(
                  children: [
                    SizedBox(width: context.width * 0.040),

                    Expanded(
                      child: StatusCard(
                        title: '12',
                        subtitle: 'Total',
                        cardBorder: Border.all(
                          color: Color.fromARGB(255, 199, 197, 197),
                        ),
                        cardColor: const Color(0xFFF9FAFC),
                        textTitleColor: Colors.black,
                        textSubtitleColor: Color.fromARGB(255, 199, 197, 197),
                      ),
                    ),

                    SizedBox(width: context.width * 0.040),

                    Expanded(
                      child: StatusCard(
                        title: '04',
                        subtitle: 'Pending',
                        cardBorder: Border.all(
                          color: const Color.fromARGB(255, 245, 194, 106),
                        ),
                        cardColor: const Color(0xFFFEF7E7),
                        textTitleColor: const Color(0xFFFFA000),
                        textSubtitleColor: Color.fromARGB(255, 199, 197, 197),
                      ),
                    ),

                    SizedBox(width: context.width * 0.040),

                    Expanded(
                      child: StatusCard(
                        title: '08',
                        subtitle: 'Completed',
                        cardBorder: Border.all(
                          color: const Color.fromARGB(255, 150, 248, 184),
                        ),
                        cardColor: const Color(0xFFEEFBF1),
                        textTitleColor: const Color(0xFF28BF5E),
                        textSubtitleColor: Color.fromARGB(255, 199, 197, 197),
                      ),
                    ),

                    SizedBox(width: context.width * 0.040),
                  ],
                ),

                SizedBox(height: context.height * 0.020),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Recent Complaints',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.050,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),

                    SizedBox(width: context.width * 0.13),

                    Text(
                      'View all',
                      style: GoogleFonts.inter(
                        fontSize: context.width * 0.038,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: context.height * 0.015),

                RecentComplaint(
                  image: 'assets/waste1.png',
                  title: 'ECO-1042',
                  subTitle1: 'Household Waste',
                  subTitle2: '12 Mar 2026 Ward 07',
                  progress: 'In Progress',
                  height: context.width * 0.15,
                  width: context.width * 0.15,
                  progressColor: const Color.fromARGB(255, 238, 151, 1),
                ),

                SizedBox(height: context.height * 0.020),

                RecentComplaint(
                  image: 'assets/waste2.png',
                  title: 'ECO-1038',
                  subTitle1: 'Construction Debris',
                  subTitle2: '08 Mar 2026 Ward 07',
                  progress: 'Completed',
                  height: context.width * 0.15,
                  width: context.width * 0.15,
                  progressColor: Color(0xFF28BF5E),
                ),

                SizedBox(height: context.height * 0.020),

                RecentComplaint(
                  image: 'assets/waste3.png',
                  title: 'ECO-1031',
                  subTitle1: 'Garden Waste',
                  subTitle2: '02 Mar 2026 Ward 04',
                  progress: 'Completed',
                  height: context.width * 0.15,
                  width: context.width * 0.15,
                  progressColor: Color(0xFF28BF5E),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
