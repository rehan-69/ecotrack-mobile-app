import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/viewmodel/auth_provider.dart';
import 'package:project/views/screens/signup_screen.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/viewmodel/navigation_provider.dart';
import 'package:project/viewmodel/google_auth_provider.dart';
import 'package:project/views/widgets/custom_text_field.dart';
import 'package:project/views/screens/forgetpassword_screen.dart';
import 'package:project/views/widgets/main_navigation_screen.dart';

class LoginScreen extends StatelessWidget {
  final formKeyLogin = GlobalKey<FormState>();

  LoginScreen({super.key});

  final RegExp emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final googleProvider = context.read<GoogleAuthProvider>();

    return Consumer<AuthProvider>(
      builder: (context, value, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: SingleChildScrollView(
                keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.width * 0.07,
                  ),
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

                      Form(
                        key: formKeyLogin,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: context.width * .01,
                              ),
                              child: CustomTextField(
                                controller: value.loginEmailController,
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
                                fontSize: context.width * 0.041,
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
                                controller: value.loginPasswordController,
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
                                suffixIcon: value.password
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility,
                                onSuffixTap: value.togglePassword,
                                fontSize: context.width * 0.041,
                                obscureText: value.password,
                                title: "Password",
                                iconColor: Colors.grey.shade600,
                                labelText: "Password",
                                keyboardType: TextInputType.visiblePassword,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: context.height * .015),

                      Padding(
                        padding: EdgeInsets.only(right: context.width * 0.020),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: GestureDetector(
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
                        ),
                      ),

                      SizedBox(height: context.height * 0.020),

                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: context.width * 0.01,
                        ),
                        child: CustomButton(
                          text: "Continue",
                          isLoading: value.isLoading,
                          onPressed: () async {
                            FocusManager.instance.primaryFocus?.unfocus();

                            if (formKeyLogin.currentState!.validate()) {
                              bool success = await value.login();

                              if (success) {
                                Fluttertoast.showToast(
                                  msg: "Welcome back!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: const Color(0xFF33A444),
                                  textColor: Colors.white,
                                  fontSize: 14,
                                );

                                if (success) {
                                  navigationProvider.changeIndex(0);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          MainNavigationScreen(),
                                    ),
                                  );
                                }
                              } else {
                                Fluttertoast.showToast(
                                  msg: "Invalid email or password.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                  backgroundColor: const Color(0xFFB91C1C),
                                  textColor: Colors.white,
                                  fontSize: 14,
                                );
                              }
                            }
                          },
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
                        isLoading: googleProvider.isLoading,
                        onPressed: () async {
                          if (googleProvider.isLoading) return;

                          googleProvider.setLoading(true);

                          try {
                            final success = await googleProvider.googleLogin();

                            if (!context.mounted) return;

                            if (success) {
                              navigationProvider.changeIndex(0);

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => MainNavigationScreen(),
                                ),
                                (route) => false,
                              );
                            } else {
                              Fluttertoast.showToast(
                                msg: "Google Sign In Failed",
                                backgroundColor: const Color(0xFFB91C1C),
                                textColor: Colors.white,
                              );
                            }
                          } catch (e) {
                            debugPrint("Google Button Error: $e");

                            if (!context.mounted) return;

                            Fluttertoast.showToast(
                              msg: "Google Sign In Failed",
                              backgroundColor: const Color(0xFFB91C1C),
                              textColor: Colors.white,
                            );
                          } finally {
                            googleProvider.setLoading(false);
                          }
                        },
                        image: "assets/google.png",
                        color: Colors.white,
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
          ),
        );
      },
    );
  }
}
