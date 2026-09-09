import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/viewmodel/auth_provider.dart';
import 'package:project/viewmodel/otp_provider.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/screens/reset_password_screen.dart';

class OtpVerificationScreen extends StatefulWidget {
  const OtpVerificationScreen({super.key});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<OtpProvider>().startOtpTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, OtpProvider>(
      builder: (context, authValue, otpValue, child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.scaffoldColor,
            elevation: 0,
            centerTitle: true,

            title: const Text(
              'Verify',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Color(0xFF1F2937),
              ),
            ),

            leading: Padding(
              padding: const EdgeInsets.only(left: 16),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF3F4F6),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    size: 18,
                    color: Color(0xFF1F2937),
                  ),
                ),
              ),
            ),
          ),

          backgroundColor: AppColors.scaffoldColor,

          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * .06),
                child: Column(
                  children: [
                    SizedBox(height: context.height * 0.06),

                    /// Mail Icon
                    Container(
                      height: context.width * .22,
                      width: context.width * .22,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEEFF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      child: Icon(
                        Icons.mail_outline_rounded,
                        color: AppColors.primaryColor,
                        size: context.width * .085,
                      ),
                    ),

                    SizedBox(height: context.height * .04),

                    Text(
                      "Enter verification code",
                      style: GoogleFonts.inter(
                        fontSize: context.width * .067,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1F2937),
                      ),
                    ),

                    SizedBox(height: context.height * .012),

                    Text(
                      "We sent a 4-digit code to ${authValue.forgetPasswordEmailController.text}",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: context.width * .036,
                        color: const Color(0xFF9CA3AF),
                        height: 1.5,
                      ),
                    ),

                    SizedBox(height: context.height * .05),

                    /// OTP Boxes
                    Pinput(
                      keyboardType: TextInputType.number,
                      closeKeyboardWhenCompleted: true,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      controller: authValue.otpController,
                      length: 4,
                      defaultPinTheme: PinTheme(
                        width: context.width * .15,
                        height: context.width * .15,
                        textStyle: GoogleFonts.inter(
                          fontSize: context.width * .05,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: const Color(0xFFE5E7EB),
                            width: 1.8,
                          ),
                        ),
                      ),
                      focusedPinTheme: PinTheme(
                        width: context.width * .15,
                        height: context.width * .15,
                        textStyle: GoogleFonts.inter(
                          fontSize: context.width * .05,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1F2937),
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.appWhiteColor,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.primaryColor,
                            width: 1.8,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(height: context.height * .04),

                    otpValue.remainingSeconds > 0
                        ? RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Resend in ",
                                  style: TextStyle(
                                    color: Color(0xFF9CA3AF),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                TextSpan(
                                  text:
                                      "${(otpValue.remainingSeconds ~/ 60).toString().padLeft(2, '0')}:${(otpValue.remainingSeconds % 60).toString().padLeft(2, '0')}",
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : GestureDetector(
                            onTap: () async {
                              bool success = await authValue.forgetPassword();

                              if (success) {
                                otpValue.startOtpTimer();
                              }
                            },
                            child: const Text(
                              "Resend OTP",
                              style: TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),

                    SizedBox(height: context.height * .05),

                    CustomButton(
                      text: "Verify",
                      isLoading: authValue.isLoading,
                      onPressed: () async {
                        bool success = await authValue.verifyOTP();

                        if (success) {
                          Fluttertoast.showToast(
                            msg: "OTP verified successfully.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xFF33A444),
                            textColor: Colors.white,
                            fontSize: 14,
                          );

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ResetPasswordScreen(
                                email: authValue
                                    .forgetPasswordEmailController
                                    .text
                                    .trim(),
                              ),
                            ),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: "Invalid or expired verification code.",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            backgroundColor: const Color(0xFFB91C1C),
                            textColor: Colors.white,
                            fontSize: 14,
                          );
                        }
                      },
                      width: context.width * .90,
                      height: context.height * .070,
                      borderRadius: context.width * .06,
                      fontSize: context.width * .045,
                      fontWeight: FontWeight.w700,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
