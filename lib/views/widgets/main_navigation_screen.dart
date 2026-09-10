import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:project/constants/app_colors.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:project/views/screens/home_screen.dart';
import 'package:project/views/widgets/bottom_sheet.dart';
import 'package:project/views/screens/profile_screen.dart';
import 'package:project/viewmodel/navigation_provider.dart';
import 'package:project/views/screens/my_complaint_screen.dart';

class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final navigationProvider = Provider.of<NavigationProvider>(context);
    final homeProvider = Provider.of<HomeProvider>(context);

    final screens = [
      const HomeScreen(),
      const MyComplaintScreen(),
      homeProvider.homeData == null
          ? Center(
              child: CircularProgressIndicator(color: AppColors.primaryColor),
            )
          : ProfileScreen(user: homeProvider.homeData!.user),
    ];

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value:
          navigationProvider.selectedIndex == 0 ||
              navigationProvider.selectedIndex == 1 ||
              navigationProvider.selectedIndex == 2
          ? const SystemUiOverlayStyle(
              statusBarColor: Color(0xFFF1F7F1),
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            )
          : const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              statusBarBrightness: Brightness.light,
            ),
      child: Scaffold(
        body: screens[navigationProvider.selectedIndex],

        bottomNavigationBar: CustomBottomNavigationBar(
          selectedIndex: navigationProvider.selectedIndex,
          onItemSelected: (index) {
            navigationProvider.changeIndex(index);
          },
        ),
      ),
    );
  }
}
