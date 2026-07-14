import 'package:flutter/material.dart';

class ProductProvider extends ChangeNotifier {
  final PageController pageController = PageController(initialPage :0);
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  
  bool checkBox = false;

  void checkBoxTap(){
    checkBox = !checkBox;
    notifyListeners();
  }
}
