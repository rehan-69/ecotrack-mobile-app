import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:project/constants/mediaquery.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Color(0xFFF1F8F1),
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            height: context.height * 0.22,
            width: double.infinity,
            color: const Color(0xFFF1F8F1),
            child: Padding(
              padding: EdgeInsets.only(
                left: context.width * 0.080,
                top: context.height * 0.010,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: context.width * 0.087,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: context.width * 0.077,
                          backgroundImage: const AssetImage(
                            'assets/avatar.png',
                          ),
                        ),
                      ),
                      SizedBox(width: context.width * 0.030),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Good morning,',
                            style: TextStyle(
                              fontSize: context.width * 0.036,
                              color: const Color(0xFF6B7280),
                            ),
                          ),
                          Text(
                            'Rahul Sharma',
                            style: TextStyle(
                              fontSize: context.width * 0.046,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xFF1F2937),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: context.width * 0.2),
                        child: Container(
                          height: context.width * 0.115,
                          width: context.width * 0.115,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Color(0x1A000000),
                                blurRadius: 8,
                                spreadRadius: 1,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.notifications_none_outlined,
                            size: context.width * 0.055,
                            color: const Color(0xFF1F2937),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: context.height * 0.020),

                  Text(
                    'Keep Your City',
                    style: TextStyle(
                      fontSize: context.width * 0.065,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),

                  Row(
                    children: [
                      Text(
                        'Clean',
                        style: TextStyle(
                          fontSize: context.width * 0.065,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF1B5E20),
                        ),
                      ),
                      Icon(
                        Icons.eco,
                        size: context.width * 0.065,
                        color: const Color(0xFF2E7D32),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
