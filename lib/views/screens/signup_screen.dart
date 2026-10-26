import 'package:flutter/material.dart';
import 'package:project/views/widgets/main_navigation_screen.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/auth_provider.dart';
import 'package:project/views/screens/login_screen.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/viewmodel/complaint_provider.dart';
import 'package:project/views/widgets/custom_text_field.dart';

class Signupscreen extends StatelessWidget {
  final formKeySignup = GlobalKey<FormState>();

  final bool isGoogleProfileCompletion;

  Signupscreen({super.key, this.isGoogleProfileCompletion = false});

  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  Widget build(BuildContext context) {
    return Consumer2<AuthProvider, ComplaintProvider>(
      builder: (context, authValue, complaintValue, child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: BackButton(color: Colors.black),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * .05),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: context.height * .03),

                    Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: context.width * .075,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
                    ),

                    SizedBox(height: context.height * .015),

                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          fontSize: context.width * .042,
                          color: Colors.grey.shade600,
                          height: 1.5,
                        ),
                        children: const [
                          TextSpan(
                            text:
                                "Complete your details to register and start\n",
                          ),
                          TextSpan(text: "exploring."),
                        ],
                      ),
                    ),

                    SizedBox(height: context.height * .035),

                    Form(
                      key: formKeySignup,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: authValue.nameController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }

                              if (value.trim().length < 3) {
                                return 'Name must be at least 3 characters';
                              }

                              if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
                                return 'Name can contain only letters';
                              }

                              return null;
                            },
                            onChanged: (value) {},
                            height: context.height * .075,
                            color: AppColors.appWhiteColor,
                            borderRadius: context.width * .04,
                            fontSize: context.width * 0.041,
                            prefixIcon: Icons.person_outline,
                            title: "Name",
                            labelText: "Name",
                            iconColor: Colors.grey.shade600,
                          ),

                          SizedBox(height: context.height * .016),

                          CustomTextField(
                            controller: authValue.signupEmailController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your email';
                              }

                              if (!emailRegex.hasMatch(value)) {
                                return 'Please enter a valid email';
                              }

                              return null;
                            },
                            onChanged: (value) {},
                            height: context.height * .075,
                            fontSize: context.width * 0.041,
                            color: AppColors.appWhiteColor,
                            borderRadius: context.width * .04,
                            prefixIcon: Icons.email_outlined,
                            title: "Email",
                            labelText: "Email",
                            iconColor: Colors.grey.shade600,
                          ),

                          SizedBox(height: context.height * .016),

                          CustomTextField(
                            controller: authValue.mobileController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              }

                              if (!RegExp(
                                r'^[0-9]{10}$',
                              ).hasMatch(value.trim())) {
                                return 'Please enter a valid 10-digit mobile number';
                              }

                              return null;
                            },
                            onChanged: (value) {},
                            height: context.height * .075,
                            color: AppColors.appWhiteColor,
                            borderRadius: context.width * .04,
                            prefixIcon: Icons.phone_outlined,
                            fontSize: context.width * 0.041,
                            title: "Mobile",
                            labelText: "Mobile",
                            iconColor: Colors.grey.shade600,
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(height: context.height * .016),

                          if (!isGoogleProfileCompletion) ...[
                            CustomTextField(
                              controller: authValue.signupPasswordController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your password';
                                }

                                if (value.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              height: context.height * .075,
                              color: AppColors.appWhiteColor,
                              borderRadius: context.width * .04,
                              prefixIcon: Icons.lock_outline,
                              fontSize: context.width * 0.041,
                              suffixIcon: authValue.newPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              onSuffixTap: authValue.toggleNewPassword,
                              obscureText: authValue.newPasswordObscure,
                              title: "Password",
                              labelText: "Password",
                              iconColor: Colors.grey.shade600,
                              keyboardType: TextInputType.visiblePassword,
                            ),

                            SizedBox(height: context.height * .016),

                            CustomTextField(
                              controller: authValue.confirmPasswordController,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return 'Please enter confirm password';
                                }

                                if (val !=
                                    authValue.signupPasswordController.text) {
                                  return 'Password does not match';
                                }

                                return null;
                              },
                              onChanged: (value) {},
                              height: context.height * .075,
                              color: AppColors.appWhiteColor,
                              borderRadius: context.width * .04,
                              fontSize: context.width * 0.041,
                              prefixIcon: Icons.lock_outline,
                              suffixIcon: authValue.confirmPasswordObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              onSuffixTap: authValue.toggleConfirmPassword,
                              obscureText: authValue.confirmPasswordObscure,
                              title: "Confirm Password",
                              labelText: "Confirm Password",
                              iconColor: Colors.grey.shade600,
                              keyboardType: TextInputType.visiblePassword,
                            ),
                          ],
                        ],
                      ),
                    ),

                    SizedBox(height: context.height * .03),

                    CustomButton(
                      text: isGoogleProfileCompletion
                          ? "Complete Profile"
                          : "Sign Up",
                      isLoading: authValue.isLoading,
                      color: AppColors.primaryColor,
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                        color: const Color(0xFFC7C3FF),
                        width: 1.2,
                      ),
                      onPressed: () async {
                        FocusManager.instance.primaryFocus?.unfocus();

                        if (!formKeySignup.currentState!.validate()) return;

                        if (isGoogleProfileCompletion) {
                          final result = await authValue
                              .completeGoogleProfile();

                          // Baaki Google profile completion code
                        }

                        if (complaintValue.selectedLocation == null ||
                            complaintValue.selectedLocation!.isEmpty) {
                          Fluttertoast.showToast(
                            msg: "Unable to get current location",
                            backgroundColor: const Color(0xFFB91C1C),
                            textColor: Colors.white,
                          );
                          return;
                        }

                        if (isGoogleProfileCompletion) {
                          final result = await authValue
                              .completeGoogleProfile();

                          if (!context.mounted) return;

                          if (result["success"] == true) {
                            Fluttertoast.showToast(
                              msg: "Profile completed successfully",
                              backgroundColor: const Color(0xFF33A444),
                              textColor: Colors.white,
                            );

                            authValue.clearControllers();

                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MainNavigationScreen(),
                              ),
                              (route) => false,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg:
                                  result["message"] ??
                                  "Unable to save mobile number",
                              backgroundColor: const Color(0xFFB91C1C),
                              textColor: Colors.white,
                            );
                          }

                          return;
                        }

                        final error = await authValue.signUp(
                          location: complaintValue.selectedLocation!,
                        );

                        if (!context.mounted) return;

                        if (error == null) {
                          Fluttertoast.showToast(
                            msg: "Account created successfully.",
                            backgroundColor: const Color(0xFF33A444),
                            textColor: Colors.white,
                          );

                          authValue.clearControllers();

                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (_) => LoginScreen()),
                          );
                        } else {
                          Fluttertoast.showToast(
                            msg: error,
                            backgroundColor: const Color(0xFFB91C1C),
                            textColor: Colors.white,
                          );
                        }
                      },
                      width: context.width * 0.95,
                      height: context.height * 0.070,
                      borderRadius: context.width * 0.040,
                      fontSize: context.width * 0.043,
                      fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: context.height * .045),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already have an account?",
                          style: TextStyle(
                            fontSize: context.width * .041,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(width: context.width * .035),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Log In",
                            style: TextStyle(
                              fontSize: context.width * .042,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
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
