import 'package:flutter/material.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/views/widgets/bottom_sheet.dart';
import 'package:project/views/widgets/custom_complaint_filter_chip.dart';
import 'package:project/views/widgets/custom_recent_complaint.dart';
import 'package:project/views/widgets/custom_text_field.dart';
import 'package:project/views/widgets/info_row.dart';
import 'package:provider/provider.dart';

class MyComplaintScreen extends StatelessWidget {
  const MyComplaintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'My Complaints',
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
                    horizontal: context.width * 0.040,
                    vertical: context.height * 0.010,
                  ),
                  child: CustomTextField(
                    controller: value.complaintController,
                    onChanged: (value) {},
                    height: context.height * 0.072,
                    color: Color.fromARGB(255, 247, 247, 252),
                    borderRadius: context.width * 0.040,
                    prefixIcon: Icons.search,
                    fontSize: context.width * 0.037,
                    title: 'Search by ID, type or ward',
                    iconColor: Colors.grey.shade600,
                    borderColor: const Color(0xFFE5E7EB),
                  ),
                ),

                SizedBox(height: context.height * .010),

                Row(
                  children: [
                    SizedBox(width: context.width * 0.035),

                    for (String title in [
                      'All',
                      'Pending',
                      'In Progress',
                      'Done',
                    ])
                      Padding(
                        padding: EdgeInsets.only(right: context.width * 0.010),
                        child: ComplaintFilterChip(title: title),
                      ),
                  ],
                ),

                SizedBox(height: context.height * 0.020),

                RecentComplaint(
                  image: 'assets/waste1.png',
                  title: 'ECO-1042',
                  subTitle1: 'Household Waste',
                  infoRow: InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: '12 Mar 2026',
                  ),
                  progress: 'In Progress',
                  height: context.width * 0.20,
                  width: context.width * 0.20,
                  progressColor: const Color.fromARGB(255, 238, 151, 1),
                ),

                SizedBox(height: context.height * 0.020),

                RecentComplaint(
                  image: 'assets/waste2.png',
                  title: 'ECO-1038',
                  subTitle1: 'Construction Debris',
                  infoRow: InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: '08 Mar 2026',
                  ),
                  progress: 'Completed',
                  height: context.width * 0.20,
                  width: context.width * 0.20,
                  progressColor: Color(0xFF28BF5E),
                ),

                SizedBox(height: context.height * 0.020),

                RecentComplaint(
                  image: 'assets/waste3.png',
                  title: 'ECO-1031',
                  subTitle1: 'Garden Waste',
                  infoRow: InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: '02 Mar 2026',
                  ),
                  progress: 'Completed',
                  height: context.width * 0.20,
                  width: context.width * 0.20,
                  progressColor: Color(0xFF28BF5E),
                ),

                SizedBox(height: context.height * 0.020),

                RecentComplaint(
                  image: 'assets/waste1.png',
                  title: 'ECO-1031',
                  subTitle1: 'Plastic Waste',
                  infoRow: InfoRow(
                    icon: Icons.calendar_today_outlined,
                    text: '27 Feb 2026',
                  ),
                  progress: 'Pending',
                  height: context.width * 0.20,
                  width: context.width * 0.20,
                  progressColor: Colors.red,
                ),
              ],
            ),
          ),
          bottomNavigationBar: CustomBottomNavigationBar(),
        );
      },
    );
  }
}
