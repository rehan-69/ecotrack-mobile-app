import 'package:flutter/material.dart';
import 'package:project/viewmodel/complaint_provider.dart';
import 'package:project/viewmodel/home_provider.dart';
import 'package:project/views/widgets/custom_contact_info_card.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/models/home_models.dart';
import 'package:project/constants/mediaquery.dart';
import 'package:project/viewmodel/otp_provider.dart';
import 'package:project/viewmodel/auth_provider.dart';
import 'package:project/views/screens/login_screen.dart';
import 'package:project/views/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:project/viewmodel/google_auth_provider.dart';
import 'package:project/views/screens/help_support_screen.dart';
import 'package:project/views/widgets/custom_profile_option.dart';
import 'package:project/views/screens/about_ecotrack_screen.dart';

class ProfileScreen extends StatelessWidget {
  final UserData user;

  const ProfileScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final otpProvider = Provider.of<OtpProvider>(context);
    final googleAuthProvider = context.read<GoogleAuthProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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

                    FutureBuilder<SharedPreferences>(
                      future: SharedPreferences.getInstance(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircleAvatar(
                            radius: context.width * 0.110,
                            backgroundImage: const AssetImage(
                              'assets/avatar.png',
                            ),
                          );
                        }

                        final prefs = snapshot.data!;
                        final photoUrl = prefs.getString('profile_image_url');

                        debugPrint('SAVED PHOTO: $photoUrl');

                        return CircleAvatar(
                          radius: context.width * 0.110,
                          backgroundColor: Colors.white,
                          backgroundImage:
                              photoUrl != null && photoUrl.trim().isNotEmpty
                              ? NetworkImage(photoUrl)
                              : const AssetImage('assets/avatar.png')
                                    as ImageProvider,
                        );
                      },
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
                      user.location ?? '',
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
                phone: user.mobile ?? '',
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
                onHelpSupport: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const HelpSupportScreen(),
                    ),
                  );
                },
                onAboutEcoTrack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const AboutEcoTrackScreen(),
                    ),
                  );
                },
              ),

              CustomButton(
                color: const Color(0xFF33A444),
                text: "Logout",
                isLoading: authProvider.isLoading,

                onPressed: () async {
                  final shouldLogout = await showDialog<bool>(
                    context: context,
                    barrierDismissible: false,
                    builder: (dialogContext) {
                      return Dialog(
                        backgroundColor: Colors.white,
                        elevation: 12,
                        insetPadding: const EdgeInsets.symmetric(
                          horizontal: 32,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(18, 24, 18, 20),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.logout_rounded,
                                color: Color(0xFF34A853),
                                size: 28,
                              ),

                              const SizedBox(height: 20),

                              const Text(
                                'Log out?',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xFF202124),
                                ),
                              ),

                              const SizedBox(height: 6),

                              const Text(
                                "You'll need to log in again to access\n"
                                'your account.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13,
                                  height: 1.5,
                                  color: Color(0xFF888888),
                                ),
                              ),

                              const SizedBox(height: 22),

                              Row(
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 45,
                                      child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.of(
                                            dialogContext,
                                          ).pop(false);
                                        },
                                        style: OutlinedButton.styleFrom(
                                          foregroundColor: const Color(
                                            0xFF333333,
                                          ),
                                          side: const BorderSide(
                                            color: Color(0xFFDADCE0),
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),

                                  const SizedBox(width: 18),

                                  Expanded(
                                    child: SizedBox(
                                      height: 45,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(dialogContext).pop(true);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: const Color(
                                            0xFF34A853,
                                          ),
                                          foregroundColor: Colors.white,
                                          elevation: 0,
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              10,
                                            ),
                                          ),
                                        ),
                                        child: const Text(
                                          'CONFIRM',
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );

                  if (shouldLogout != true) return;

                  authProvider.clearControllers();
                  otpProvider.resetTimer();

                  try {
                    await googleAuthProvider.signOutGoogle();
                  } catch (e) {
                    debugPrint('Google Sign Out Error: $e');
                  }

                  await authProvider.logout();

                  if (!context.mounted) return;

                  context.read<HomeProvider>().clearHomeData();
                  context.read<ComplaintProvider>().resetMyComplaints();

                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (route) => false,
                  );
                },

                width: context.width * 0.92,
                height: context.height * 0.065,
                borderRadius: context.width * 0.040,
                fontSize: context.width * 0.043,
                fontWeight: FontWeight.w700,
                textColor: Colors.white,
                icon: Icons.logout_outlined,
                border: Border.all(color: Color(0xFF33A444)),
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
      ),
    );
  }
}
