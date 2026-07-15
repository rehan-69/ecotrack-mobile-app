import 'package:flutter/material.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/views/screens/forgetpassword_screen.dart';
import 'package:project/views/screens/signup_screen.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_text_field.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductProvider>(
      builder: (context, value, child) {
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: context.width * 0.07),
                child: Column(
                  children: [
                    SizedBox(height: context.height * 0.09),

                    Text(
                      "Welcome Back",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: context.width * 0.085,
                        fontWeight: FontWeight.w700,
                        color: AppColors.primaryColor,
                        letterSpacing: .3,
                      ),
                    ),

                    SizedBox(height: context.height * 0.018),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * .04,
                      ),
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: context.width * .041,
                            color: Colors.grey.shade600,
                            height: 1.55,
                            fontWeight: FontWeight.w400,
                          ),
                          children: const [
                            TextSpan(
                              text: "Sign in with your email and password\n",
                            ),
                            TextSpan(text: "or continue with social media"),
                          ],
                        ),
                      ),
                    ),

                    SizedBox(height: context.height * .050),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * .01,
                      ),
                      child: CustomTextField(
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
                        height: context.height * .072,
                        color: AppColors.appWhiteColor,
                        borderRadius: context.width * .04,
                        prefixIcon: Icons.email_outlined,
                        title: "Email",
                        labelText: "Email",
                        iconColor: Colors.grey.shade600,
                      ),
                    ),

                    SizedBox(height: context.height * .018),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * .01,
                      ),
                      child: CustomTextField(
                        controller: value.passwordController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Please enter a valid password';
                          }
                          return null;
                        },
                        onChanged: (value) {},
                        height: context.height * .072,
                        color: AppColors.appWhiteColor,
                        borderRadius: context.width * .04,
                        prefixIcon: Icons.lock_outline,
                        suffixIcon: Icons.visibility_off_outlined,
                        title: "Password",
                        iconColor: Colors.grey.shade600,
                        labelText: "Password",
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),

                    SizedBox(height: context.height * .012),
                    Row(
                      children: [
                        Transform.scale(
                          scale: 0.90,
                          child: Checkbox(
                            value: value.checkBox,
                            activeColor: AppColors.primaryColor,
                            side: BorderSide(
                              color: Colors.grey.shade400,
                              width: 1.2,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5),
                            ),
                            onChanged: (_) {
                              value.checkBoxTap();
                            },
                          ),
                        ),

                        Text(
                          "Remember me",
                          style: TextStyle(
                            fontSize: context.width * .038,
                            color: Colors.black87,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(width: context.width * .1),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgetPasswordscreen(),
                              ),
                            );
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              fontSize: context.width * .038,
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: context.height * 0.035),

                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: context.width * 0.01,
                      ),
                      child: CustomButton(
                        text: "Continue",
                        onPressed: () {},
                        width: context.width * 0.85,
                        height: context.height * 0.065,
                        borderRadius: context.width * 0.040,
                        fontSize: context.width * 0.043,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.height * .035,
                        horizontal: context.width * .05,
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1.2,
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: context.width * .04,
                            ),
                            child: Text(
                              "OR",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontWeight: FontWeight.w600,
                                fontSize: context.width * .038,
                              ),
                            ),
                          ),

                          Expanded(
                            child: Divider(
                              color: Colors.grey.shade300,
                              thickness: 1.2,
                            ),
                          ),
                        ],
                      ),
                    ),

                    CustomButton(
                      text: "Login with Google",
                      onPressed: () {},
                      image: "assets/google.png",
                      color: Theme.of(context).scaffoldBackgroundColor,
                      textColor: AppColors.primaryColor,
                      border: Border.all(
                        color: AppColors.primaryColor,
                        width: 1.2,
                      ),
                      width: context.width * 0.85,
                      height: context.height * 0.065,
                      borderRadius: context.width * 0.040,
                      fontSize: context.width * 0.045,
                      fontWeight: FontWeight.w700,
                    ),

                    SizedBox(height: context.height * 0.040),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Don't have an account?",
                          style: TextStyle(
                            fontSize: context.width * 0.039,
                            color: Colors.grey.shade600,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(width: context.width * 0.035),

                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Signupscreen(),
                              ),
                            );
                          },

                          child: Text(
                            "Sign Up",
                            style: TextStyle(
                              fontSize: context.width * 0.040,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
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
