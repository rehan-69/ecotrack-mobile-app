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
  TextEditingController confirmPasswordController = TextEditingController();

  bool checkBox = false;
  int currentIndex = 0;

  @override
  void dispose() {
    pageController.dispose();
    otpController.dispose();
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

  Future<bool> signUp() async {
    try{
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
    }catch(e){
      debugPrint('Signup Error: $e');
      return false;
    }
  }

  Future<bool> login() async {
    try {
      print("Login API Called");

      final response = await http.post(
        Uri.parse("http://127.0.0.1:3000/login"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({
          "email": emailController.text.trim(),
          "password": passwordController.text.trim(),
        }),
      );

      print("Status Code: ${response.statusCode}");
      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(data["token"]);
        return true;
      }

      return false;
    } catch (e) {
      print("Login Error: $e");
      return false;
    }
  }
}
