import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/services/google_auth_service.dart';

class ProductProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage: 0);
  TextEditingController nameController = TextEditingController();
  TextEditingController signupEmailController = TextEditingController();
  TextEditingController forgetPasswordEmailController = TextEditingController();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController signupPasswordController = TextEditingController();
  final TextEditingController otpController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  TextEditingController complaintController = TextEditingController();

  bool newPasswordObscure = true;
  bool confirmPasswordObscure = true;
  bool checkBox = false;
  bool password = true;
  bool isLoading = false;
  int currentIndex = 0;
  Timer? otpTimer;
  int remainingSeconds = 120;

  @override
  void dispose() {
    otpTimer?.cancel();
    pageController.dispose();
    nameController.dispose();
    signupEmailController.dispose();
    loginEmailController.dispose();
    forgetPasswordEmailController.dispose();
    loginPasswordController.dispose();
    signupPasswordController.dispose();
    mobileController.dispose();
    otpController.dispose();
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
    if (currentIndex < 3) {
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

  void togglePassword() {
    password = !password;
    notifyListeners();
  }

  void startOtpTimer() {
    otpTimer?.cancel();

    remainingSeconds = 120;
    notifyListeners();

    otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        notifyListeners();
      } else {
        timer.cancel();
      }
    });
  }

  void clearControllers() {
    // Signup
    nameController.clear();
    signupEmailController.clear();
    mobileController.clear();
    signupPasswordController.clear();
    confirmPasswordController.clear();

    // Login
    loginEmailController.clear();
    loginPasswordController.clear();

    // Forgot Password
    forgetPasswordEmailController.clear();

    // OTP
    otpController.clear();

    // Reset Password
    newPasswordController.clear();

    // Reset UI States
    password = true;
    newPasswordObscure = true;
    confirmPasswordObscure = true;
    checkBox = false;

    // Reset Timer
    otpTimer?.cancel();
    remainingSeconds = 120;

    notifyListeners();
  }

  Future<String?> signUp() async {
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
        debugPrint(data["token"]);
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
        return true;
      }

      return false;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    } 
  }
}
