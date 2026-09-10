import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/screens/login_screen.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/viewmodel/onboarding_provider.dart';
import 'package:project/views/widgets/custom_page_indicator.dart';
import 'package:project/views/widgets/custom_onboarding_text.dart';

class OnboardingPage3 extends StatelessWidget {
  const OnboardingPage3({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingProvider>(
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
                      'assets/image3.png',
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
                      title: "Make a Greener Difference",
                      subtitle:
                          "Track your reports and work together for a\ncleaner and healthier city.",
                    ),

                    SizedBox(height: context.height * 0.04),

                    /// Get Started Button
                    CustomButton(
                      text: "Get Started",
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (_) => LoginScreen()),
                        );
                      },
                      width: context.width * 0.85,
                      height: context.height * 0.070,
                      borderRadius: context.width * 0.063,
                      fontSize: context.width * 0.043,
                      fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: context.height * 0.080),
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
