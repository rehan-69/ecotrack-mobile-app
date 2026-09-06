import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/viewmodel/provider.dart';
import 'package:project/models/home_models.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:project/views/widgets/custom_profile_option.dart';
import 'package:project/views/widgets/custom_contact_info_card.dart';

class ProfileScreen extends StatelessWidget {
  final UserData user;
  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: context.height * 0.010),
              color: const Color(0xFFF1F7F1),
              child: Column(
                children: [
                  Text(
                    'Profile',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.055,
                      fontWeight: FontWeight.w700,
                      color: const Color(0xFF1F2937),
                    ),
                  ),

                  SizedBox(height: context.height * 0.015),

                  CircleAvatar(
                    radius: context.width * 0.110,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: context.width * 0.100,
                      backgroundImage: const AssetImage('assets/avatar.png'),
                    ),
                  ),

                  SizedBox(height: context.height * 0.015),

                  Text(
                    user.name,
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.045,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1F2937),
                    ),
                  ),

                  SizedBox(height: context.height * 0.004),

                  Text(
                    'Citizen Ward 07 Nashik',
                    style: GoogleFonts.inter(
                      fontSize: context.width * 0.032,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF79808C),
                    ),
                  ),
                ],
              ),
            ),

            CustomContactInfoCard(
              email: user.email,
              phone: user.mobile,
            ),

            Padding(
              padding: EdgeInsets.only(right: context.width * 0.70),
              child: Text(
                'Account',
                style: GoogleFonts.inter(
                  fontSize: context.width * 0.040,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF79808C),
                ),
              ),
            ),

            CustomProfileOption(
              onEditProfile: () {
                // Edit Profile
              },
              onHelpSupport: () {
                // Help & Support
              },
              onAboutEcoTrack: () {
                // About EcoTrack
              },
            ),
            Consumer<ProductProvider>(
              builder: (context, value, child) {
                return CustomButton(
                  color: Color(0xFFFEF2F2),
                  text: "Logout",
                  isLoading: value.isLoading,
                  onPressed: () {},
                  width: context.width * 0.92,
                  height: context.height * 0.065,
                  borderRadius: context.width * 0.040,
                  fontSize: context.width * 0.043,
                  fontWeight: FontWeight.w700,
                  textColor: Color(0xFFF58585),
                  icon: Icons.logout_outlined,
                  border: Border.all(color: Color(0xFFFBD8D8)),
                );
              },
            ),
            SizedBox(height: context.height * 0.020),
            Text(
              'EcoTrack v1.0.4 Municipal Corporation',
              style: GoogleFonts.inter(
                fontSize: context.width * 0.030,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF79808C),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
