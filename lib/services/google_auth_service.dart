
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class GoogleAuthService {
  final firebase_auth.FirebaseAuth _auth =
      firebase_auth.FirebaseAuth.instance;

  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<firebase_auth.UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.initialize();

      // Clear the previous Google Sign-In session.
      await _googleSignIn.signOut();

      // Start Google Sign-In.
      final GoogleSignInAccount googleUser =
          await _googleSignIn.authenticate();

      debugPrint('GOOGLE SELECTED EMAIL: ${googleUser.email}');
      debugPrint('GOOGLE PHOTO URL: ${googleUser.photoUrl}');

      // Get Google authentication token.
      final GoogleSignInAuthentication googleAuth =
          googleUser.authentication;

      final String? idToken = googleAuth.idToken;

      if (idToken == null || idToken.isEmpty) {
        throw Exception('Google ID token is missing');
      }

      // Create Firebase credential.
      final firebase_auth.AuthCredential credential =
          firebase_auth.GoogleAuthProvider.credential(
        idToken: idToken,
      );

      // Sign in to Firebase.
      final firebase_auth.UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      debugPrint(
        'Firebase Sign-In Successful: '
        '${userCredential.user?.email}',
      );

      return userCredential;
    } catch (e, stackTrace) {
      debugPrint('Google Sign-In Error: $e');
      debugPrintStack(stackTrace: stackTrace);
      rethrow;
    }
  }

  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
    } catch (e) {
      debugPrint('Google Sign-Out Error: $e');
    }

    await _auth.signOut();
    debugPrint('Firebase Sign-Out Successful');
  }
}
