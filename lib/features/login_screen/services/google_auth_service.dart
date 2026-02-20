import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  static Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Save user to Firestore
      final user = userCredential.user;
      if (user != null) {
        final userRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

        final userDoc = await userRef.get();
        if (!userDoc.exists) {
          await userRef.set({
            'uid': user.uid,
            'name': user.displayName,
            'email': user.email,
            'photoURL': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
            'authProvider': 'google',
          });
        }
      }

      return userCredential;
    } catch (e) {
      print('Google Sign-In failed: $e');
      return null;
    }
  }
}
