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
        Uri.parse('https://ecotrack-mobile-backend.onrender.com/signup'),
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

  // Login
  Future<bool> login({required String email, required String password}) async {
    try {
      final response = await http.post(
        Uri.parse('https://ecotrack-mobile-backend.onrender.com/login'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email.trim(), "password": password}),
      );

      debugPrint("Login Status Code: ${response.statusCode}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data["token"];
        final user = data["user"];

        if (token == null || user == null) {
          debugPrint("Login Error: Token or user data missing");
          return false;
        }

        final prefs = await SharedPreferences.getInstance();

        // Save JWT token and user data
        await prefs.setString("jwt_token", token.toString());
        await prefs.setString("logged_in_user", jsonEncode(user));

        // Save profile image URL
        final photoUrl = user["profile_image_url"];

        if (photoUrl != null && photoUrl.toString().trim().isNotEmpty) {
          await prefs.setString("profile_image_url", photoUrl.toString());
        } else {
          await prefs.remove("profile_image_url");
        }

        debugPrint("JWT Token Saved Successfully");
        debugPrint("User Data Saved Successfully");
        debugPrint(
          "SAVED PROFILE IMAGE: ${prefs.getString('profile_image_url')}",
        );

        return true;
      }

      debugPrint("Login Failed: ${response.body}");
      return false;
    } catch (e) {
      debugPrint("Login Error: $e");
      return false;
    }
  }

  //Forget Password
  // Forget Password
  Future<bool> forgetPassword({required String email}) async {
    try {
      final response = await http
          .post(
            Uri.parse(
              'https://ecotrack-mobile-backend.onrender.com/forgot-password',
            ),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"email": email.trim()}),
          )
          .timeout(const Duration(seconds: 30));

      debugPrint("Forgot Password Status: ${response.statusCode}");
      debugPrint("Forgot Password Response: ${response.body}");

      if (response.statusCode == 200) {
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Forgot Password Error: $e");
      return false;
    }
  }

  //Verify OTP
  Future<bool> verifyOTP({required String email, required String otp}) async {
    try {
      final response = await http.post(
        Uri.parse('https://ecotrack-mobile-backend.onrender.com/verify-otp'),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"email": email, "otp": otp}),
      );

      debugPrint("Verify OTP Status Code: ${response.statusCode}");
      debugPrint("Verify OTP Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Message : ${data["message"]}');
        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Verify OTP Error: $e");
      return false;
    }
  }

  //Reset Password
  Future<bool> resetPassword({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://ecotrack-mobile-backend.onrender.com/reset-password',
        ),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": email,
          "password": password,
          "confirmPassword": confirmPassword,
        }),
      );
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        debugPrint('Message : ${data["message"]}');
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  // Google Login
  Future<bool> googleLogin({required String? idToken}) async {
    try {
      if (idToken == null || idToken.isEmpty) {
        debugPrint("Google Login Error: ID Token is empty");
        return false;
      }

      final response = await http.post(
        Uri.parse("https://ecotrack-mobile-backend.onrender.com/google-login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"idToken": idToken}),
      );

      debugPrint("Google Login Status: ${response.statusCode}");
      debugPrint("Google Login Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final token = data["token"];
        final user = data["user"];

        if (token == null || user == null) {
          debugPrint("Google Login Error: Token or user data missing");
          return false;
        }

        final prefs = await SharedPreferences.getInstance();

        await prefs.setString("jwt_token", token);
        await prefs.setString("logged_in_user", jsonEncode(user));

        debugPrint("Google Login Successful");
        debugPrint("User Data Saved Successfully");

        return true;
      }

      return false;
    } catch (e) {
      debugPrint("Google Login Error: $e");
      return false;
    }
  }

  // Update Mobile Number
  Future<Map<String, dynamic>> updateMobile({required String mobile}) async {
    try {
      final cleanMobile = mobile.trim();

      if (!RegExp(r'^[0-9]{10}$').hasMatch(cleanMobile)) {
        return {
          "success": false,
          "message": "Please enter a valid 10-digit mobile number.",
        };
      }

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString("jwt_token");

      if (token == null || token.isEmpty) {
        return {
          "success": false,
          "message": "Session expired. Please login again.",
        };
      }

      final response = await http.patch(
        Uri.parse(
          "https://ecotrack-mobile-backend.onrender.com/profile/mobile",
        ),
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
        },
        body: jsonEncode({"mobile": cleanMobile}),
      );

      dynamic decoded;

      try {
        decoded = jsonDecode(response.body);
      } catch (e) {
        debugPrint('Update Mobile Status: ${response.statusCode}');
        debugPrint('Update Mobile Response: ${response.body}');

        return {
          "success": false,
          "message":
              "Server returned an invalid response. Check backend URL and deployment.",
        };
      }

      if (decoded is! Map<String, dynamic>) {
        return {
          "success": false,
          "message": "Invalid server response. Please try again.",
        };
      }

      if (response.statusCode == 200 && decoded["success"] == true) {
        final dynamic userData = decoded["user"];

        // Update cached user data if present.
        final savedUser = prefs.getString("logged_in_user");

        if (savedUser != null) {
          final dynamic parsedUser = jsonDecode(savedUser);

          if (parsedUser is Map) {
            final user = Map<String, dynamic>.from(parsedUser);
            user["mobile"] = userData is Map ? userData["mobile"] : cleanMobile;

            await prefs.setString("logged_in_user", jsonEncode(user));
          }
        }

        return {
          "success": true,
          "message": decoded["message"] ?? "Mobile number saved successfully.",
          "mobile": userData is Map ? userData["mobile"] : cleanMobile,
        };
      }

      return {
        "success": false,
        "message":
            decoded["message"] ??
            "Failed to save mobile number. Please try again.",
      };
    } catch (e) {
      debugPrint("Update Mobile Error: $e");

      return {
        "success": false,
        "message": "Unable to connect. Please try again.",
      };
    }
  }

  // Logout
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      await prefs.remove("jwt_token");
      await prefs.remove("logged_in_user");
      await prefs.remove("profile_image_url");

      debugPrint("Logout Successful");
      debugPrint("Token and User Data Cleared");
    } catch (e) {
      debugPrint("Logout Error: $e");
      rethrow;
    }
  }
}
