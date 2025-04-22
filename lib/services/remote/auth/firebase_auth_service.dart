import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../model/user.dart' as user;

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<user.User?> signInWithGoogle() async {
    print('object');
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _firebaseAuth.signInWithCredential(credential);
      return _mapFirebaseUserToUser(userCredential.user!);
    } catch (e) {
      throw Exception("Failed to sign in with Google: ${e.toString()}");
    }
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await _googleSignIn.signOut();
  }

  user.User _mapFirebaseUserToUser(User firebaseUser) {
    return user.User(
      id: firebaseUser.uid,
      name: firebaseUser.displayName ?? "Unknown",
      email: firebaseUser.email ?? "No email",
    );
  }
}
