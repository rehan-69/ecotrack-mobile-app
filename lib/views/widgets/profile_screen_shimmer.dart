import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ProfileScreenShimmer extends StatelessWidget {
  const ProfileScreenShimmer({super.key});

  Widget skeleton({
    required double width,
    required double height,
    double radius = 6,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Column(
        children: [
          // Name and Location
          skeleton(width: width * 0.42, height: 18),
          const SizedBox(height: 10),
          skeleton(width: width * 0.30, height: 13),

          const SizedBox(height: 25),

          // Contact Information Card
          Container(
            width: width * 0.90,
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                skeleton(width: width * 0.25, height: 14),
                const SizedBox(height: 12),
                skeleton(width: width * 0.70, height: 17),
                const SizedBox(height: 22),
                skeleton(width: width * 0.25, height: 14),
                const SizedBox(height: 12),
                skeleton(width: width * 0.55, height: 17),
              ],
            ),
          ),
        ],
      ),
    );
  }
}