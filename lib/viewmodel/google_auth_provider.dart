
import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/google_auth_service.dart';

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

  Future<Map<String, dynamic>?> googleLogin() async {
    try {
      final credential = await _googleAuthService.signInWithGoogle();

      if (credential == null) return null;

      final googleUser = credential.user;
      if (googleUser == null) return null;

      debugPrint('GOOGLE EMAIL: ${googleUser.email}');
      debugPrint('GOOGLE NAME: ${googleUser.displayName}');

      final idToken = await googleUser.getIdToken();

      final result = await _authService.googleLogin(idToken: idToken);

      if (result == null) return null;

      // Pass Google details to the profile completion screen.
      result['googleName'] = googleUser.displayName ?? '';
      result['googleEmail'] = googleUser.email ?? '';
      result['googlePhotoUrl'] = googleUser.photoURL ?? '';

      return result;
    } catch (e) {
      debugPrint('Google Login Error: $e');
      return null;
    }
  }

  Future<void> signOutGoogle() async {
    await _googleAuthService.signOut();
  }
}
