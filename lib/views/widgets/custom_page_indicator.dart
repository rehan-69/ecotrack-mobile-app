import 'package:flutter/material.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CustomPageIndicator extends StatelessWidget {
  final PageController controller;
  final int count;

  const CustomPageIndicator({
    super.key,
    required this.controller,
    required this.count,
  });

  @override
  Widget build(BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: count,
      effect: ExpandingDotsEffect(
        activeDotColor: const Color(0xFF4F46E5),
        dotColor: Colors.grey.shade300,
        dotHeight: context.width * 0.02,
        dotWidth: context.width * 0.02,
        spacing: context.width * 0.015,
        expansionFactor: 3,
      ),
    );
  }
}