import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();

  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();

  final TextEditingController signupEmailController = TextEditingController();

  final TextEditingController signupPasswordController =
      TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  final TextEditingController loginEmailController = TextEditingController();

  final TextEditingController loginPasswordController = TextEditingController();

  final TextEditingController forgetPasswordEmailController =
      TextEditingController();

  final TextEditingController otpController = TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  // UI State
  bool isLoading = false;

  bool password = true;
  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;
  bool checkBox = false;

  // ---------------------------
  // Password / Checkbox
  // ---------------------------

  void togglePassword() {
    password = !password;
    notifyListeners();
  }

  void toggleNewPassword() {
    newPasswordObscure = !newPasswordObscure;
    notifyListeners();
  }

  void toggleConfirmPassword() {
    confirmPasswordObscure = !confirmPasswordObscure;
    notifyListeners();
  }

  void checkBoxTap() {
    checkBox = !checkBox;
    notifyListeners();
  }

  // ---------------------------
  // Sign Up
  // ---------------------------

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

  // ---------------------------
  // Login
  // ---------------------------

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

  // ---------------------------
  // Forgot Password
  // ---------------------------

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

  // ---------------------------
  // Verify OTP
  // ---------------------------

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

  // ---------------------------
  // Reset Password
  // ---------------------------

  Future<bool> resetPassword(String email) async {
    isLoading = true;
    notifyListeners();

    try {
      final result = await _authService.resetPassword(
        email: email,
        password: newPasswordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      return result;
    } catch (e) {
      return false;
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------------------
  // Logout
  // ---------------------------

  Future<void> logout() async {
    isLoading = true;
    notifyListeners();

    try {
      await _authService.logout();

      await Future.delayed(const Duration(milliseconds: 500));

      debugPrint("JWT Token Removed Successfully");
    } catch (e) {
      debugPrint("Logout Error: $e");
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  // ---------------------------
  // Clear Controllers
  // ---------------------------

  void clearControllers() {
    nameController.clear();
    mobileController.clear();

    signupEmailController.clear();
    signupPasswordController.clear();
    confirmPasswordController.clear();

    loginEmailController.clear();
    loginPasswordController.clear();

    forgetPasswordEmailController.clear();
    otpController.clear();

    newPasswordController.clear();

    password = true;
    newPasswordObscure = true;
    confirmPasswordObscure = true;
    checkBox = false;

    notifyListeners();
  }

  // ---------------------------
  // Dispose
  // ---------------------------

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();

    signupEmailController.dispose();
    signupPasswordController.dispose();
    confirmPasswordController.dispose();

    loginEmailController.dispose();
    loginPasswordController.dispose();

    forgetPasswordEmailController.dispose();
    otpController.dispose();

    newPasswordController.dispose();

    super.dispose();
  }
}
