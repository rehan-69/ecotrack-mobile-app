import 'package:flutter/material.dart';
import 'package:project/views/screens/otp_screen.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';

class EcoApp extends StatelessWidget {
  const EcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ProductProvider>(
      create: (context) => ProductProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: OtpVerificationScreen(),
      ),
    );
  }
}
