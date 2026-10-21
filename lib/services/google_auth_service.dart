import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart';

class GoogleAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  Future<UserCredential?> signInWithGoogle() async {
    await _googleSignIn.initialize();

    // Clear the previous Google and Firebase sessions.
    await _googleSignIn.signOut();
    await _auth.signOut();

    // Start Google Sign-In.
    final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

    debugPrint('GOOGLE SELECTED EMAIL: ${googleUser.email}');
    debugPrint('GOOGLE PHOTO URL: ${googleUser.photoUrl}');
    
    final GoogleSignInAuthentication googleAuth = googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }
}
