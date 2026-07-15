import 'package:flutter/material.dart';

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
}
