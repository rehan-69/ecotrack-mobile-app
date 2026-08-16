import 'package:flutter/material.dart';
import 'package:project/constants/mediaquery.dart';


class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;
  const CustomBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

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
          GestureDetector(
            onTap: () {
              onItemSelected(0);
            },
            child: Column(
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
          ),

          // GestureDetector(
          //   onTap: () {
          //     onItemSelected(1);
          //   },
          //   child: Column(
          //     mainAxisSize: MainAxisSize.min,
          //     children: [
          //       Icon(
          //         Icons.add,
          //         size: context.width * 0.060,
          //         color: const Color(0xFF6B7280),
          //       ),
          //       SizedBox(height: context.height * 0.004),
          //       Text(
          //         'Report',
          //         style: TextStyle(
          //           fontSize: context.width * 0.032,
          //           fontWeight: FontWeight.w500,
          //           color: const Color(0xFF6B7280),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),

          GestureDetector(
            onTap: () {
              onItemSelected(1);
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
              onItemSelected(2);
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
