import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_page_indicator.dart';
import 'package:project/views/widgets/custom_onboarding_text.dart';

class OnboardingPage1 extends StatelessWidget {
  const OnboardingPage1({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: context.width * 0.06),
            child: Column(
              children: [
                SizedBox(height: context.height * 0.10),

                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Image.asset(
                      'assets/image1.png',
                      width: context.width * 0.82,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),

                /// Bottom Content
                Column(
                  children: [
                    CustomPageIndicator(
                      controller: value.pageController,
                      count: 3,
                    ),

                    SizedBox(height: context.height * 0.03),

                    const CustomOnboardingText(
                      title: "Keep Your City Clean",
                      subtitle:
                          "Report waste problems and help keep your\nneighborhood clean and green.",
                    ),

                    SizedBox(height: context.height * 0.04),

                    /// Next Button
                    CustomButton(
                      text: "Next",
                      onPressed: () {
                        value.nextPage();
                      },
                      width: context.width * 0.85,
                      height: context.height * 0.070,
                      borderRadius: context.width * 0.063,
                      fontSize: context.width * 0.043,
                      fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: context.height * 0.02),

                    /// Skip
                    GestureDetector(
                      onTap: () {
                        value.skipPage();
                      },
                      child: Text(
                        "Skip",
                        style: GoogleFonts.inter(
                          fontSize: context.width * 0.040,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),
                    ),

                    SizedBox(height: context.height * 0.035),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
