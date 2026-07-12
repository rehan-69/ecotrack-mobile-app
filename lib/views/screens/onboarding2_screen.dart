import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_onboarding_text.dart';
import 'package:project/views/widgets/custome_page_indicator.dart';
import 'package:provider/provider.dart';

class Onboarding2Screen extends StatelessWidget {
  const Onboarding2Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: context.width * 0.06),
              child: Column(
                children: [
                  /// Image yaha aayegi
                  Expanded(child: Container()),

                  /// Bottom Content
                  Column(
                    children: [
                      CustomPageIndicator(
                        controller: value.pageController,
                        count: 3,
                      ),

                      SizedBox(height: context.height * 0.03),

                      CustomOnboardingText(
                        title: "Buy in a tap",
                        subtitle:
                            "Saved cards, one-click checkout, doorstep\ndelivery.",
                      ),

                      SizedBox(height: context.height * 0.04),

                      CustomButton(
                        text: "Next",
                        onPressed: () {},
                        width: context.width * 0.90,
                        height: context.height * 0.065,
                        borderRadius: context.width * 0.045,
                        fontSize: context.width * 0.043,
                        fontWeight: FontWeight.w700,
                      ),

                      SizedBox(height: context.height * 0.02),

                      Text(
                        "Skip",
                        style: GoogleFonts.inter(
                          fontSize: context.width * 0.040,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF9CA3AF),
                        ),
                      ),

                      SizedBox(height: context.height * 0.035),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
