import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/google_auth_service.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  TextEditingController mobileController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController forgetPasswordEmailController = TextEditingController();

  final AuthService _authService = AuthService();
  bool isLoading = false;

  // Sign Up
  Future<String?> signUp({required String location}) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.signUp(
        name: nameController.text.trim(),
        email: signupEmailController.text.trim(),
        mobile: mobileController.text.trim(),
        password: signupPasswordController.text.trim(),
        location: location,
      );

      return result;
    } catch (e) {
      return "Something went wrong";
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //Login
  Future<bool> login() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.login(
        email: loginEmailController.text.trim(),
        password: loginPasswordController.text.trim(),
      );

      return result;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //Forgot Password
  Future<bool> forgetPassword() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.forgetPassword(
        email: forgetPasswordEmailController.text.trim(),
      );

      return result;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  //Verify OTP

  Future<bool> verifyOTP() async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.verifyOTP(
        email: forgetPasswordEmailController.text.trim(),
        otp: otpController.text.trim(),
      );

      return result;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
