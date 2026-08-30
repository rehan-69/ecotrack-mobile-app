import 'package:flutter/material.dart';
import 'package:project/viewmodel/complaint_provider.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/views/screens/splash_screen.dart';

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
          create: (context) => HomeProvider()..getHomeData(),
        ),

        ChangeNotifierProvider<ComplaintProvider>(
          create: (context) {
            // final provider = ComplaintProvider();
            // provider.retrieveLostImage();
            // return provider;
            return ComplaintProvider();
          },
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
