import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/views/screens/otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_text_field.dart';

class ForgetPasswordscreen extends StatelessWidget {
  final formKeyForgetPassword = GlobalKey<FormState>();

  ForgetPasswordscreen({super.key});

  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            leading: BackButton(color: Colors.black),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * .04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: context.height * .02),

                    Text(
                      "Forgot Password",
                      style: TextStyle(
                        fontSize: context.width * .075,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),

                    SizedBox(height: context.height * .025),

                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: context.width * .043,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                        children: const [
                          TextSpan(
                            text:
                                "Enter your email id for verification process,\n",
                          ),
                          TextSpan(
                            text: "We will send 4 digit code to your email",
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.height * .050),

                    Form(
                      key: formKeyForgetPassword,
                      child: CustomTextField(
                        controller: value.forgetPasswordEmailController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },

                        height: context.height * .072,
                        color: AppColors.appWhiteColor,
                        fontSize:  context.width * 0.041,
                        borderRadius: context.width * .03,
                        prefixIcon: Icons.email_outlined,
                        title: "Email Id",
                        labelText: "Email Id",
                        iconColor: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: context.height * .020),

                    CustomButton(
                      text: "Continue",
                      isLoading: value.isLoading,
                      color: AppColors.primaryColor,
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                        color: const Color(0xFFC7C3FF),
                        width: 1.2,
                      ),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (formKeyForgetPassword.currentState!.validate()) {
                          bool success = await value.forgetPassword();
                          if (success) {
                            Fluttertoast.showToast(
                              msg: "Verification code sent to your email.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: const Color(
                                0xFF4F46E5,
                              ), // Primary Purple
                              textColor: Colors.white,
                              fontSize: 14,
                            );

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const OtpVerificationScreen(),
                              ),
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Email address not found.",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: const Color(
                                0xFFB91C1C,
                              ), // Soft Dark Red
                              textColor: Colors.white,
                              fontSize: 14,
                            );
                          }
                        }
                      },
                      width: context.width * 0.95,
                      height: context.height * 0.070,
                      borderRadius: context.width * 0.040,
                      fontSize: context.width * 0.043,
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
