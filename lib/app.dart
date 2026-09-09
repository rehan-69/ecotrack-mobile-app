import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/viewmodel/otp_provider.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:project/viewmodel/auth_provider.dart';
import 'package:project/views/screens/splash_screen.dart';
import 'package:project/viewmodel/complaint_provider.dart';

class EcoApp extends StatelessWidget {
  const EcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
        ),

        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),

        ChangeNotifierProvider<OtpProvider>(create: (_) => OtpProvider()),

        ChangeNotifierProvider<HomeProvider>(
          create: (context) => HomeProvider()..getHomeDatas(),
        ),

        ChangeNotifierProvider<ComplaintProvider>(
          create: (_) => ComplaintProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
