import 'package:flutter/material.dart';
import 'package:project/constants/app_colors.dart';
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
      height: context.height * 0.085,
      width: double.infinity,

      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 12,
            spreadRadius: 0,
            offset: const Offset(0, -3),
          ),
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [
          _navigationItem(
            context,
            index: 0,
            icon: Icons.home_outlined,
            label: 'Home',
          ),

          _navigationItem(
            context,
            index: 1,
            icon: Icons.format_list_bulleted,
            label: 'Complaints',
          ),

          _navigationItem(
            context,
            index: 2,
            icon: Icons.person_outline,
            label: 'Profile',
          ),
        ],
      ),
    );
  }

  Widget _navigationItem(
    BuildContext context, {
    required int index,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,

        onTap: () {
          onItemSelected(index);
        },

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: [
            Icon(
              icon,

              size: context.width * 0.065,

              color: isSelected
                  ? AppColors.primaryColor
                  : const Color(0xFF6B7280),
            ),

            SizedBox(height: context.height * 0.005),

            Text(
              label,

              style: TextStyle(
                fontSize: context.width * 0.035,

                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,

                color: isSelected ? AppColors.primaryColor :const Color(0xFF4B5563),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
