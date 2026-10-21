import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/google_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthProvider extends ChangeNotifier {
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final AuthService _authService = AuthService();

  Future<bool> googleLogin() async {
    try {
      final credential = await _googleAuthService.signInWithGoogle();

      if (credential == null) {
        return false;
      }

      // Temporary debugging logs
      debugPrint("FIREBASE SELECTED EMAIL: ${credential.user?.email}");
      debugPrint("FIREBASE PHOTO URL: ${credential.user?.photoURL}");

      final prefs = await SharedPreferences.getInstance();
      final photoUrl = credential.user?.photoURL;

      if (photoUrl != null && photoUrl.isNotEmpty) {
        await prefs.setString('profile_image_url', photoUrl);
      } else {
        await prefs.remove('profile_image_url');
      }

      final idToken = await credential.user?.getIdToken();

      final result = await _authService.googleLogin(idToken: idToken);

      return result;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<void> signOutGoogle() async {
    await _googleAuthService.signOut();
  }
}
