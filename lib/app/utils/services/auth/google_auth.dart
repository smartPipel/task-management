// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuth {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  static final instance = GoogleAuth._singleton();

  GoogleAuth._singleton();

  factory GoogleAuth() {
    return instance;
  }

  void signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleSignInAccount =
          await googleSignIn.signIn();
      final GoogleSignInAuthentication authentication =
          await googleSignInAccount!.authentication;

      final AuthCredential authCredential = GoogleAuthProvider.credential(
        accessToken: authentication.accessToken,
        idToken: authentication.idToken,
      );

      await auth.signInWithCredential(authCredential);
    } on FirebaseAuthException catch (e) {
      print(e.message);
      rethrow;
    }
  }

  void logOut() async {
    await googleSignIn.signOut();
    await auth.signOut();
  }
}
