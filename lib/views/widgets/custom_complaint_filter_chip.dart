import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:provider/provider.dart';

class ComplaintFilterChip extends StatelessWidget {
  final String title;

  const ComplaintFilterChip({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return GestureDetector(
          onTap: () {
            value.selectFilter(title);
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.width * 0.050,
              vertical: context.height * 0.015,
            ),
            decoration: BoxDecoration(
              color: value.selectedFilter == title
                  ? AppColors.primaryColor
                  : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: value.selectedFilter == title
                    ? Colors.white
                    : AppColors.primaryColor,
              ),
            ),
            child: Text(
              title,
              style: GoogleFonts.inter(
                color: value.selectedFilter == title
                    ? Colors.white
                    : AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: context.width * 0.030,
              ),
            ),
          ),
        );
      },
    );
  }
}
