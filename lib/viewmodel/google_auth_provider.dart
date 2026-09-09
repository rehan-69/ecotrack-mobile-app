import 'package:flutter/material.dart';
import 'package:project/services/auth_service.dart';
import 'package:project/services/google_auth_service.dart';

final GoogleAuthService _googleAuthService = GoogleAuthService();
final AuthService _authService = AuthService();

Future<bool> googleLogin() async {
  try {
    final credential = await _googleAuthService.signInWithGoogle();

    if (credential == null) {
      return false;
    }

    final idToken = await credential.user?.getIdToken();

    final result = await _authService.googleLogin(
      idToken: idToken,
    );

    return result;
  } catch (e) {
    debugPrint(e.toString());
    return false;
  }
}