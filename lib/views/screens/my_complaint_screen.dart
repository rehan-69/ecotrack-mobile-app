import 'package:flutter/material.dart';
import 'package:project/views/widgets/complaint_list_shimmer.dart';
import 'package:provider/provider.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/complaint_provider.dart';
import 'package:project/views/widgets/custom_text_field.dart';
import 'package:project/views/widgets/custom_recent_complaint.dart';
import 'package:project/views/widgets/custom_complaint_filter_chip.dart';

class MyComplaintScreen extends StatelessWidget {
  const MyComplaintScreen({super.key});

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
    final complaintProvider = context.watch<ComplaintProvider>();

    if (!complaintProvider.myComplaintsLoaded) {
      Future.microtask(() {
        context.read<ComplaintProvider>().getMyComplaints();
      });
    }
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

            Consumer<ComplaintProvider>(
              builder: (context, value, child) {
                return Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.040,
                    vertical: context.height * 0.010,
                  ),
                  child: CustomTextField(
                    controller: value.searchController,
                    onChanged: (val) {
                      value.searchComplaints();
                    },
                    height: context.height * 0.072,
                    color: Color.fromARGB(255, 247, 247, 252),
                    borderRadius: context.width * 0.040,
                    prefixIcon: Icons.search,
                    fontSize: context.width * 0.037,
                    title: 'Search by ID or type',
                    iconColor: Colors.grey.shade600,
                    borderColor: const Color(0xFFE5E7EB),
                  ),
                );
              },
            ),

            SizedBox(height: context.height * .010),

            Row(
              children: [
                SizedBox(width: context.width * 0.035),

                for (String title in [
                  'All',
                  'Pending',
                  'In Progress',
                  'Completed',
                ])
                  Padding(
                    padding: EdgeInsets.only(right: context.width * 0.010),
                    child: ComplaintFilterChip(title: title),
                  ),
              ],
            ),

            SizedBox(height: context.height * 0.020),

            Consumer<ComplaintProvider>(
              builder: (context, value, child) {
                if (!value.myComplaintsLoaded) {
                  return const ComplaintListShimmer();
                }

                if (value.filteredComplaints.isEmpty) {
                  return SizedBox(
                    height: context.height * 0.55,
                    child: Center(
                      child: Text(
                        'No complaints found',
                        style: TextStyle(
                          fontSize: context.width * 0.040,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                }

                return Column(
                  children: value.filteredComplaints.map((complaint) {
                    return Column(
                      children: [
                        CustomRecentComplaint(
                          complaint: complaint,
                          height: context.width * 0.20,
                          width: context.width * 0.20,
                          progressColor: _getStatusColor(complaint.status),
                        ),
                        SizedBox(height: context.height * 0.020),
                      ],
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
