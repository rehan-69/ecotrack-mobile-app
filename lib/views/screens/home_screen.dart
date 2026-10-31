import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/viewmodel/navigation_provider.dart';
import 'package:project/views/screens/eco_tips_screen.dart';
import 'package:project/views/widgets/custom_statuscard.dart';
import 'package:project/views/screens/my_complaint_screen.dart';
import 'package:project/views/widgets/home_screen_shimmer.dart';
import 'package:project/views/screens/report_complaint_screen.dart';
import 'package:project/views/widgets/custom_recent_complaint.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Completed':
        return const Color(0xFF28BF5E);

      case 'In Progress':
        return const Color(0xFFFF9701);

      case 'Pending':
        return const Color(0xFFFFA000);

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();
    final recentComplaints = homeProvider.homeData?.recentComplaints ?? [];
    final hour = DateTime.now().hour;
    String greeting;

    if (hour >= 5 && hour < 12) {
      greeting = 'Good morning,';
    } else if (hour >= 12 && hour < 17) {
      greeting = 'Good afternoon,';
    } else if (hour >= 17 && hour < 21) {
      greeting = 'Good evening,';
    } else {
      greeting = 'Good night,';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('jwt_token');

      if (!context.mounted) return;

      if (token != null &&
          token.isNotEmpty &&
          homeProvider.homeData == null &&
          !homeProvider.isLoading) {
        await context.read<HomeProvider>().getHomeDatas();
      }
    });

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF1F8F1),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: homeProvider.isLoading
            ? const HomeScreenShimmer()
            : homeProvider.homeData == null
            ? Center(
                child: Text(
                  homeProvider.errorMessage ?? 'Unable to load home data',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Color(0xFF9CA3AF),
                  ),
                  textAlign: TextAlign.center,
                ),
              )
            : SafeArea(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        width: double.infinity,
                        color: const Color(0xFFF1F8F1),
                        child: Padding(
                          padding: EdgeInsets.only(
                            left: context.width * 0.070,
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
                                      context
                                          .read<NavigationProvider>()
                                          .changeIndex(2);
                                    },
                                    child: FutureBuilder<SharedPreferences>(
                                      future: SharedPreferences.getInstance(),
                                      builder: (context, snapshot) {
                                        final photoUrl = snapshot.data
                                            ?.getString('profile_image_url');

                                        return CircleAvatar(
                                          backgroundImage: photoUrl != null
                                              ? NetworkImage(photoUrl)
                                              : const AssetImage(
                                                  'assets/avatar.png',
                                                ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: context.width * 0.030),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        greeting,
                                        style: GoogleFonts.inter(
                                          fontSize: context.width * 0.036,
                                          color: const Color(0xFF6B7280),
                                        ),
                                      ),
                                      Text(
                                        homeProvider.homeData?.user.name ??
                                            'User',
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
                                      left: context.width * 0.32,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) =>
                                                const EcoTipsScreen(),
                                          ),
                                        );
                                      },
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
                                        child: const Icon(
                                          Icons.eco_outlined,
                                          color: Color(0xFF33A444),
                                          size: 26,
                                        ),
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
                                builder: (context) =>
                                    const ReportComplaintScreen(),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                              title:
                                  '${homeProvider.homeData?.overview.total ?? 0}',
                              subtitle: 'Total',
                              cardBorder: Border.all(
                                color: Color.fromARGB(255, 199, 197, 197),
                              ),
                              cardColor: const Color(0xFFF9FAFC),
                              textTitleColor: Colors.black,
                              textSubtitleColor: Color.fromARGB(
                                255,
                                199,
                                197,
                                197,
                              ),
                            ),
                          ),

                          SizedBox(width: context.width * 0.040),

                          Expanded(
                            child: StatusCard(
                              title:
                                  '${homeProvider.homeData?.overview.pending ?? 0}',
                              subtitle: 'Pending',
                              cardBorder: Border.all(
                                color: const Color.fromARGB(255, 245, 194, 106),
                              ),
                              cardColor: const Color(0xFFFEF7E7),
                              textTitleColor: const Color(0xFFFFA000),
                              textSubtitleColor: Color.fromARGB(
                                255,
                                199,
                                197,
                                197,
                              ),
                            ),
                          ),

                          SizedBox(width: context.width * 0.040),

                          Expanded(
                            child: StatusCard(
                              title:
                                  '${homeProvider.homeData?.overview.completed ?? 0}',
                              subtitle: 'Completed',
                              cardBorder: Border.all(
                                color: const Color.fromARGB(255, 150, 248, 184),
                              ),
                              cardColor: const Color(0xFFEEFBF1),
                              textTitleColor: const Color(0xFF28BF5E),
                              textSubtitleColor: Color.fromARGB(
                                255,
                                199,
                                197,
                                197,
                              ),
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

                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MyComplaintScreen(),
                                ),
                              );
                            },
                            child: Text(
                              'View all',
                              style: GoogleFonts.inter(
                                fontSize: context.width * 0.038,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: context.height * 0.015),

                      homeProvider.homeData?.recentComplaints.isEmpty ?? true
                          ? SizedBox(
                              height: context.height * 0.28,
                              width: double.infinity,
                              child: Center(
                                child: Text(
                                  'No recent complaint',
                                  style: TextStyle(
                                    fontSize: context.width * 0.040,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            )
                          : Column(
                              children: [
                                ...recentComplaints.map((complaint) {
                                  return Column(
                                    children: [
                                      CustomRecentComplaint(
                                        complaint: complaint,
                                        height: context.width * 0.20,
                                        width: context.width * 0.20,
                                        progressColor: _getStatusColor(
                                          complaint.status,
                                        ),
                                      ),
                                      SizedBox(height: context.height * 0.020),
                                    ],
                                  );
                                }).toList(),
                              ],
                            ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
