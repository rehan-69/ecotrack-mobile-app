import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/otp_provider.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:project/viewmodel/auth_provider.dart';
import 'package:project/views/screens/splash_screen.dart';
import 'package:project/viewmodel/complaint_provider.dart';
import 'package:project/viewmodel/navigation_provider.dart';
import 'package:project/viewmodel/onboarding_provider.dart';
import 'package:project/viewmodel/google_auth_provider.dart';


class EcoApp extends StatelessWidget {
  const EcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthProvider>(create: (_) => AuthProvider()),

        ChangeNotifierProvider<GoogleAuthProvider>(
          create: (_) => GoogleAuthProvider(),
        ),

        ChangeNotifierProvider<OtpProvider>(create: (_) => OtpProvider()),

        ChangeNotifierProvider<OnboardingProvider>(
          create: (_) => OnboardingProvider(),
        ),

        ChangeNotifierProvider<NavigationProvider>(
          create: (_) => NavigationProvider(),
        ),

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
