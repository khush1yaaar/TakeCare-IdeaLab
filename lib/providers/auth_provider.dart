import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthProvider {
  final _auth = FirebaseAuth.instance;
  final _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> loginWithGoogle() async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final cred = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(cred);
      await storeUserDataIfNew(userCredential.user);
      return userCredential;
    } catch (e) {
      print("Login Error: ${e.toString()}");
      return null;
    }
  }

  Future<void> storeUserDataIfNew(User? user) async {
  if (user == null) return;
  final userDoc = _firestore.collection('users').doc(user.uid);

  try {
    final docSnapshot = await userDoc.get();

    if (!docSnapshot.exists) {
      await userDoc.set({
        'name': user.displayName ?? '',
        'email': user.email ?? '',
        'journal': {}, // Empty map for journal entries
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("✅ New user data stored in Firestore!");
    } else {
      print("🔹 User already exists, skipping Firestore write.");
    }
  } catch (e) {
    print("❌ Firestore Write Error: ${e.toString()}");
  }
}


  Future<void> addJournalEntry(String date, String entry) async {
    final user = _auth.currentUser;
    if (user == null) return; // Ensure user is logged in

    final userDoc = _firestore.collection('users').doc(user.uid);
    
    await userDoc.update({
      'journal.$date': entry, // Adds or updates the journal entry for the given date
    });
  }

  Future<void> logout() async {
    await GoogleSignIn().signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}
