
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/google_auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GoogleAuthProvider extends ChangeNotifier {
  final GoogleAuthService _googleAuthService = GoogleAuthService();
  final AuthService _authService = AuthService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    if (_isLoading == value) return;

    _isLoading = value;
    notifyListeners();
  }

  Future<bool> googleLogin() async {
    try {
      final credential = await _googleAuthService.signInWithGoogle();

      if (credential == null) {
        return false;
      }

      debugPrint('FIREBASE SELECTED EMAIL: ${credential.user?.email}');

      final prefs = await SharedPreferences.getInstance();
      final photoUrl = credential.user?.photoURL;

      if (photoUrl != null && photoUrl.isNotEmpty) {
        await prefs.setString('profile_image_url', photoUrl);
      } else {
        await prefs.remove('profile_image_url');
      }

      final idToken = await credential.user?.getIdToken();

      if (idToken == null || idToken.isEmpty) {
        debugPrint('Google login failed: Firebase ID token is missing');
        return false;
      }

      return await _authService.googleLogin(idToken: idToken);
    } catch (e, stackTrace) {
      debugPrint('Google login error: $e');
      debugPrintStack(stackTrace: stackTrace);
      return false;
    }
  }

  Future<void> signOutGoogle() async {
    await _googleAuthService.signOut();
  }
}
