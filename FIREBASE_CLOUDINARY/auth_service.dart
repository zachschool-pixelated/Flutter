
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/foundation.dart' show debugPrint, kIsWeb;

class AuthService {
  FirebaseAuth get _auth => FirebaseAuth.instance;
  bool _googleSignInInitialized = false;

  Future<void> _initializeGoogleSignIn() async {
    if (_googleSignInInitialized) return;
    await GoogleSignIn.instance.initialize();
    _googleSignInInitialized = true;
  }

  // GOOGLE SIGN-IN
  Future<User?> signInWithGoogle() async {
    if (kIsWeb) {
      GoogleAuthProvider googleProvider =
          GoogleAuthProvider();

      UserCredential userCredential =
          await _auth.signInWithPopup(googleProvider);

      return userCredential.user;
    } else {
      await _initializeGoogleSignIn();
      final googleUser = await GoogleSignIn.instance.authenticate();
      final googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      return (await _auth.signInWithCredential(credential)).user;
    }
  }

  // EMAIL/PASSWORD REGISTER
  Future<User?> registerWithEmail(
      String email, String password) async {
    try {
      final userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      debugPrint("Registration error: $e");
      return null;
    }
  }

  // EMAIL/PASSWORD LOGIN
  Future<User?> signInWithEmail(
      String email, String password) async {
    try {
      final userCredential =
          await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      debugPrint("Login error: $e");
      return null;
    }
  }

  Future<void> sendPasswordResetEmail(String email) {
    return _auth.sendPasswordResetEmail(email: email.trim());
  }

  // SIGN OUT
  Future<void> signOut() async {
    if (!kIsWeb) {
      await GoogleSignIn.instance.signOut();
    }

    await _auth.signOut();
  }

  // AUTHENTICATION STATE
  Stream<User?> get userStream => _auth.authStateChanges();
}
