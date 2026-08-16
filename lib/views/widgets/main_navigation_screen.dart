import 'package:flutter/material.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/views/screens/home_screen.dart';
import 'package:project/views/screens/my_complaint_screen.dart';
import 'package:project/views/screens/profile_screen.dart';
import 'package:project/views/widgets/bottom_sheet.dart';
import 'package:provider/provider.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<ProductProvider>(context);

    final screens = [
      HomeScreen(),
      MyComplaintScreen(),
      ProfileScreen(),
    ];
    return Scaffold(
      body: screens[navigationProvider.selectedIndex],
      bottomNavigationBar: CustomBottomNavigationBar(
        selectedIndex: navigationProvider.selectedIndex,
        onItemSelected: (index){
          navigationProvider.changeIndex(index);
        },
      ),
    );
  }
}
