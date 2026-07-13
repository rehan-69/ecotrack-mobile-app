import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_onboarding_text.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: context.height * 0.03),
                      CustomOnboardingText(
                        title: "Welcome to Aurora",
                        subtitle: "Sign in to continue shopping.",
                        textAlign: TextAlign.left,
                        crossAxisAlignment: CrossAxisAlignment.start,
                      ),

                      SizedBox(height: context.height * 0.04),

                      CustomButton(
                        text: "Sign in",
                        onPressed: () {},
                        width: context.width * 0.85,
                        height: context.height * 0.070,
                        borderRadius: context.width * 0.063,
                        fontSize: context.width * 0.043,
                        fontWeight: FontWeight.w700,
                      ),

                      SizedBox(height: context.height * 0.015),

                      CustomButton(
                        text: "Create account",
                        onPressed: () {},
                        border: Border.all(
                          color: const Color(0xFFC7C3FF),
                          width: 1.2,
                        ),
                        color: Theme.of(context).scaffoldBackgroundColor,
                        textColor: AppColors.primaryColor,
                        width: context.width * 0.85,
                        height: context.height * 0.070,
                        borderRadius: context.width * 0.063,
                        fontSize: context.width * 0.043,
                        fontWeight: FontWeight.w700,
                      ),

                      SizedBox(height: context.height * 0.02),

                      Center(
                        child: Text(
                          "Continue as guest",
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
          ),
        );
      },
    );
  }
}
