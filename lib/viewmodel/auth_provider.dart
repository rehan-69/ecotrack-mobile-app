import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/services/google_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final TextEditingController otpController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController forgetPasswordEmailController = TextEditingController();

  bool isLoading = false;
  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;

  // Sign Up
  Future<String?> signUp({required String location}) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/signup"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": nameController.text.trim(),
          "email": signupEmailController.text.trim(),
          "mobile": mobileController.text.trim(),
          "password": signupPasswordController.text.trim(),
          "location": location,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return null; // Success
      }

      return data["message"];
    } catch (e) {
      debugPrint("Signup Error : $e");
      return "Something went wrong";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Login
  Future<bool> login() async {
    isLoading = true;
    notifyListeners();

    try {
      debugPrint("Login API Called");

      final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": loginEmailController.text.trim(),
          "password": loginPasswordController.text.trim(),
        }),
      );

      debugPrint("Status Code: ${response.statusCode}");
      debugPrint("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data["token"];

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("jwt_token", token);

        debugPrint("JWT Token Saved Successfully");

        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Login Error: $e");
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Logout
  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('jwt_token');
      await Future.delayed(const Duration(milliseconds: 500));
      debugPrint("JWT Token Removed Successfully");
    } catch (e) {
      debugPrint("Logout Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Google Login
  Future<bool> googleLogin() async {
    try {
      final credential = await _googleAuthService.signInWithGoogle();

      if (credential == null) {
        return false;
      }

      final idToken = await credential.user?.getIdToken();

      final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/google-login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"idToken": idToken}),
      );

      debugPrint(response.body);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final token = data['token'];
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('jwt_token', token);
        debugPrint("Google JWT Token Saved Successfully");
        return true;
      }

      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  //Forget Password
  Future<bool> forgetPassword() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/forgot-password'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": forgetPasswordEmailController.text.trim()}),
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
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // Verify OTP
  Future<bool> verifyOTP() async {
    isLoading = true;
    notifyListeners();
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": forgetPasswordEmailController.text.trim(),
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
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //Reset Password
  Future<bool> resetPassword(String email) async {
    isLoading = true;
    notifyListeners();
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
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
