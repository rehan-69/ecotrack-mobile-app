
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreenShimmer extends StatelessWidget {
  const HomeScreenShimmer({super.key});

  Widget _box({
    double? width,
    required double height,
    double radius = 10,
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
    final size = MediaQuery.sizeOf(context);

    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      period: const Duration(milliseconds: 1400),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header skeleton
              Container(
                width: double.infinity,
                color: const Color(0xFFF1F8F1),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        _box(width: 48, height: 48, radius: 30),
                        const SizedBox(width: 12),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _box(width: 105, height: 12),
                            const SizedBox(height: 8),
                            _box(width: 145, height: 17),
                          ],
                        ),
                        const Spacer(),
                        _box(width: 42, height: 42, radius: 30),
                      ],
                    ),
                    const SizedBox(height: 28),
                    _box(width: 190, height: 24),
                    const SizedBox(height: 10),
                    _box(width: 115, height: 24),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Report complaint card
                    _box(
                      width: double.infinity,
                      height: size.height * 0.085,
                      radius: 15,
                    ),
                    const SizedBox(height: 24),

                    // Overview heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _box(width: 105, height: 19),
                        _box(width: 75, height: 13),
                      ],
                    ),
                    const SizedBox(height: 18),

                    // Three overview cards
                    Row(
                      children: [
                        Expanded(
                          child: _box(height: 100, radius: 12),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _box(height: 100, radius: 12),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: _box(height: 100, radius: 12),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    // Recent complaints heading
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _box(width: 160, height: 18),
                        _box(width: 55, height: 14),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Recent complaint cards
                    ...List.generate(
                      3,
                      (index) => Padding(
                        padding: const EdgeInsets.only(bottom: 14),
                        child: _box(
                          width: double.infinity,
                          height: 100,
                          radius: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
