import 'package:flutter/material.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/views/onboarding/onboarding_page1.dart';
import 'package:project/views/onboarding/onboarding_page2.dart';
import 'package:project/views/onboarding/onboarding_page3.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: AppColors.appWhiteColor,
          body: PageView(
            controller: value.pageController,

            onPageChanged: (index) {
              value.changePage(index);
            },

            children: const [
              OnboardingPage1(),
              OnboardingPage2(),
              OnboardingPage3(),
            ],
          ),
        );
      },
    );
  }
}