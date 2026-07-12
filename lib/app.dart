import 'package:flutter/material.dart';
import 'package:project/views/screens/splash_screen.dart';

class EcoApp extends StatelessWidget {
  const EcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:false,
      home: SplashScreen(),
    );
  }
}