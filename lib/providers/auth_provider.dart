import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final _auth = FirebaseAuth.instance;

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(cred);
    } catch (e) {
      print("Login Error: ${e.toString()}");
      return null;
    }
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser; // Returns current signed-in user
}
