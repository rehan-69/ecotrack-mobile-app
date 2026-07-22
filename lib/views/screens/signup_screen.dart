import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/screens/login_screen.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_text_field.dart';

class Signupscreen extends StatelessWidget {
  Signupscreen({super.key});
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
                      key: value.formKeySignup,
                      child: Column(
                        children: [
                          CustomTextField(
                            controller: value.nameController,
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
                            prefixIcon: Icons.person_outline,
                            title: "Name",
                            labelText: "Name",
                            iconColor: Colors.grey.shade600,
                          ),

                          SizedBox(height: context.height * .016),

                          CustomTextField(
                            controller: value.emailController,
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
                            color: AppColors.appWhiteColor,
                            borderRadius: context.width * .04,
                            prefixIcon: Icons.email_outlined,
                            title: "Email",
                            labelText: "Email",
                            iconColor: Colors.grey.shade600,
                          ),

                          SizedBox(height: context.height * .016),

                          CustomTextField(
                            controller: value.mobileController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your mobile number';
                              }
                              if (value.length != 10) {
                                return 'Please enter a valid mobile number';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            height: context.height * .075,
                            color: AppColors.appWhiteColor,
                            borderRadius: context.width * .04,
                            prefixIcon: Icons.phone_outlined,
                            title: "Mobile",
                            labelText: "Mobile",
                            iconColor: Colors.grey.shade600,
                            keyboardType: TextInputType.phone,
                          ),

                          SizedBox(height: context.height * .016),

                          CustomTextField(
                            controller: value.passwordController,
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
                            suffixIcon: Icons.visibility_off_outlined,
                            title: "Password",
                            labelText: "Password",
                            iconColor: Colors.grey.shade600,
                            keyboardType: TextInputType.visiblePassword,
                          ),

                          SizedBox(height: context.height * .016),

                          CustomTextField(
                            controller: value.confirmPasswordController,
                            validator: (val) {
                              if (val == null || val.isEmpty) {
                                return 'Please enter confirm password';
                              }
                              if (val != value.passwordController.text) {
                                return 'Password does not match';
                              }
                              return null;
                            },
                            onChanged: (value) {},
                            height: context.height * .075,
                            color: AppColors.appWhiteColor,
                            borderRadius: context.width * .04,
                            prefixIcon: Icons.lock_outline,
                            suffixIcon: Icons.visibility_off_outlined,
                            title: "Confirm Password",
                            labelText: "Confirm Password",
                            iconColor: Colors.grey.shade600,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: context.height * .03),

                    CustomButton(
                      text: "Sign Up",
                      color: AppColors.primaryColor,
                      textColor: Theme.of(context).scaffoldBackgroundColor,
                      border: Border.all(
                        color: const Color(0xFFC7C3FF),
                        width: 1.2,
                      ),
                      onPressed: () async {
                        bool success = await value.signUp();
                        if (value.formKeySignup.currentState!.validate()) {
                          if (success) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                            );
                            Fluttertoast.showToast(
                              msg: "Signup Successful",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              backgroundColor: const Color(
                                0xFF2E7D32,
                              ), // Material Green 800
                              textColor: Colors.white,
                              fontSize: 13,
                            );
                          } else {
                            Fluttertoast.showToast(
                              msg: "Signup Failed",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.TOP,
                              backgroundColor: const Color(
                                0xFFD32F2F,
                              ), // Material Red 700
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
