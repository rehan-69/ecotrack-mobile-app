import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/auth_provider.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_text_field.dart';

class ResetPasswordScreen extends StatelessWidget {
  final formKeyReset = GlobalKey<FormState>();
  final String email;
  final String otp;

  ResetPasswordScreen({super.key, required this.email, required this.otp});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return Scaffold(
          backgroundColor: AppColors.scaffoldColor,

          appBar: AppBar(
            backgroundColor: AppColors.scaffoldColor,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              "Reset Password",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
            ),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            ),
          ),

          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * .06),
                child: Column(
                  children: [
                    SizedBox(height: context.height * .05),

                    Container(
                      height: context.width * .22,
                      width: context.width * .22,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEDEEFF),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Icon(
                        Icons.lock_reset_rounded,
                        color: AppColors.primaryColor,
                        size: context.width * .09,
                      ),
                    ),

                    SizedBox(height: context.height * .04),

                    Text(
                      "Create New Password",
                      style: GoogleFonts.inter(
                        fontSize: context.width * .065,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    SizedBox(height: context.height * .015),

                    Text(
                      "Your new password must be different from the previous password.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        color: Colors.grey,
                        fontSize: context.width * .037,
                      ),
                    ),

                    SizedBox(height: context.height * .05),

                    Form(
                      key: formKeyReset,
                      child: Column(
                        children: [
                          CustomTextField(
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Please enter new password";
                              }

                              if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }

                              return null;
                            },
                            title: "New Password",
                            labelText: "New Password",
                            controller: value.newPasswordController,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: value.newPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onSuffixTap: value.toggleNewPassword,
                            obscureText: value.newPasswordObscure,
                            borderRadius: context.width * .04,
                            fontSize: context.width * 0.041,
                            height: context.height * .07,
                            color: Colors.white,
                            iconColor: AppColors.primaryColor,
                          ),

                          SizedBox(height: context.height * .025),

                          CustomTextField(
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return "Please confirm your password";
                              }

                              if (val !=
                                  value.newPasswordController.text.trim()) {
                                return "Passwords do not match";
                              }

                              return null;
                            },
                            title: "Confirm Password",
                            labelText: "Confirm Password",
                            controller: value.confirmPasswordController,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: value.confirmPasswordObscure
                                ? Icons.visibility_off
                                : Icons.visibility,
                            onSuffixTap: value.toggleConfirmPassword,
                            obscureText: value.confirmPasswordObscure,
                            borderRadius: context.width * .04,
                            fontSize: context.width * 0.041,
                            height: context.height * .07,
                            color: Colors.white,
                            iconColor: AppColors.primaryColor,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.height * .06),

                    CustomButton(
                      text: "Change Password",
                      isLoading: value.isLoading,
                      onPressed: () async {
                        if (formKeyReset.currentState!.validate()) {
                          bool success = await value.resetPassword(
                            email,
                            otp,
                          );

                          if (success) {
                            Fluttertoast.showToast(
                              msg: "Password updated successfully.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: const Color(0xFF33A444),
                              textColor: Colors.white,
                              fontSize: 14,
                            );

                            Navigator.popUntil(
                              context,
                              (route) => route.isFirst,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Unable to update password.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: const Color(0xFFB91C1C),
                              textColor: Colors.white,
                              fontSize: 14,
                            );
                          }
                        }
                      },
                      width: context.width * .9,
                      height: context.height * .07,
                      borderRadius: context.width * .04,
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
