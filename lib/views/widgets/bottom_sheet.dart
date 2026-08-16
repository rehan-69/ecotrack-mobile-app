import 'package:flutter/material.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/screens/my_complaint_screen.dart';
import 'package:project/views/screens/profile_screen.dart';
import 'package:project/views/screens/report_complaint_screen.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.height * 0.080,
      width: double.infinity,
      padding: EdgeInsets.only(bottom: context.height * 0.005),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        boxShadow: [
          BoxShadow(
            color: Color(0x18000000),
            blurRadius: 10,
            spreadRadius: 0,
            offset: Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.home_outlined,
                size: context.width * 0.060,
                color: const Color(0xFF6B7280),
              ),
              SizedBox(height: context.height * 0.004),
              Text(
                'Home',
                style: TextStyle(
                  fontSize: context.width * 0.032,
                  fontWeight: FontWeight.w500,
                  color: const Color(0xFF6B7280),
                ),
              ),
            ],
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ReportComplaintScreen(),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.add,
                  size: context.width * 0.060,
                  color: const Color(0xFF6B7280),
                ),
                SizedBox(height: context.height * 0.004),
                Text(
                  'Report',
                  style: TextStyle(
                    fontSize: context.width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MyComplaintScreen(),
                ),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.format_list_bulleted,
                  size: context.width * 0.060,
                  color: const Color(0xFF6B7280),
                ),
                SizedBox(height: context.height * 0.004),
                Text(
                  'Complaints',
                  style: TextStyle(
                    fontSize: context.width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProfileScreen()),
              );
            },
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_outline,
                  size: context.width * 0.060,
                  color: const Color(0xFF6B7280),
                ),
                SizedBox(height: context.height * 0.004),
                Text(
                  'Profile',
                  style: TextStyle(
                    fontSize: context.width * 0.032,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
