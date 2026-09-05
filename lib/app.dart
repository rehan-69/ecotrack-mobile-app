import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:project/views/screens/splash_screen.dart';
import 'package:project/viewmodel/complaint_provider.dart';
import 'package:project/views/screens/my_complaint_screen.dart';


class EcoApp extends StatelessWidget {
  const EcoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProductProvider>(
          create: (context) => ProductProvider(),
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
