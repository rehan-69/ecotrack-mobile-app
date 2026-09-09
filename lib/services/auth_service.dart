import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  //Sign Up
  Future<String?> signUp({
    required String name,
    required String email,
    required String mobile,
    required String password,
    required String location,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/signup'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "name": name,
          "email": email,
          "mobile": mobile,
          "password": password,
          "location": location,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return null;
      }

      return data["message"];
    } catch (e) {
      return 'Something went wrong';
    }
  }

  //Login
  Future<bool> login({required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "password": password}),
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
      return false;
    }
  }

  //Forget Password
  Future<bool> forgetPassword({required String email}) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/forgot-password'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Message : ${data["message"]}");
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  //Verify OTP
  Future<bool> verifyOTP({required String email, required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse('http://127.0.0.1:3000/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint("Message : ${data["message"]}");
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  

}
