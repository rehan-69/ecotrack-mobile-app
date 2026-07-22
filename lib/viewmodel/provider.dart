import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKeyLogin = GlobalKey<FormState>();
  final formKeySignup = GlobalKey<FormState>();
  final formKeyReset = GlobalKey<FormState>();
  final formKeyForgetPassword = GlobalKey<FormState>();
  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;
  bool checkBox = false;
  int currentIndex = 0;

  @override
  void dispose() {
    otpController.dispose();
    pageController.dispose();
    nameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void checkBoxTap() {
    checkBox = !checkBox;
    notifyListeners();
  }

  void changePage(int index) {
    currentIndex = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentIndex < 2) {
      pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skipPage() {
    pageController.animateToPage(
      2,
      duration: Duration(microseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void toggleNewPassword() {
    newPasswordObscure = !newPasswordObscure;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    confirmPasswordObscure = !confirmPasswordObscure;
    notifyListeners();
  }

  Future<bool> signUp() async {
    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text.trim(),
          "email": emailController.text.trim(),
          "mobile": mobileController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('Signup Error: $e');
      return false;
    }
  }

  Future<bool> login() async {
    try {
      debugPrint("Login API Called");

      final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint(data["token"]);
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Login Error: $e");
      return false;
    }
  }

  Future<bool> forgetPassword() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/forgot-password'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": emailController.text.trim()}),
      );

      debugPrint('status code : ${response.statusCode}');
      debugPrint('body : ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Message : ${data["message"]}");
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint("Forget Error: $e");
      return false;
    }
  }

  Future<bool> verifyOTP() async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "otp": otpController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('data : ${data['message']}');
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint('verify Error : $e');
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/reset-password"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": newPasswordController.text.trim(),
          "confirmPassword": confirmPasswordController.text.trim(),
        }),
      );

      debugPrint("Status Code : ${response.statusCode}");
      debugPrint("Body : ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint(data["message"]);
        return true;
      } else {
        final data = jsonDecode(response.body);
        debugPrint(data["message"]);
        return false;
      }
    } catch (e) {
      debugPrint("Reset Password Error : $e");
      return false;
    }
  }
}
