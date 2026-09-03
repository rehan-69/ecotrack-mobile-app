import 'package:flutter/material.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/info_row.dart';
import 'package:project/views/widgets/custom_text_field.dart';
import 'package:project/views/widgets/custom_recent_complaint.dart';
import 'package:project/views/widgets/custom_complaint_filter_chip.dart';

class MyComplaintScreen extends StatelessWidget {
  const MyComplaintScreen({super.key});

  String _formatDate(DateTime date) {
    final months = const [
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
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text(
              'My Complaints',
              style: TextStyle(
                fontSize: context.width * 0.060,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1F2937),
              ),
            ),
            centerTitle: true,
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

                ...homeProvider.homeData!.recentComplaints.map((complaint) {
                  return Column(
                    children: [
                      RecentComplaint(
                        image:
                            complaint.image?.isNotEmpty == true &&
                                !complaint.image!.first.startsWith('/data')
                            ? complaint.image!.first
                            : 'assets/waste1.png',
                        title: complaint.wasteType,
                        subTitle1: complaint.location,
                        subTitle2:
                            '${_formatDate(complaint.createdAt)} ${complaint.location}',
                        progress: complaint.status,
                        height: context.width * 0.20,
                        width: context.width * 0.20,
                        progressColor: _getStatusColor(complaint.status),
                      ),
                      
                      SizedBox(height: context.height * 0.020),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        );
      },
    );
  }
}
