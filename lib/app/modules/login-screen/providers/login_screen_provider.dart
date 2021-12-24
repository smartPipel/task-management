import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/utils/services/auth/google_auth.dart';

class LoginScreenProvider with ChangeNotifier {
  final GoogleAuth _auth = GoogleAuth();
  bool isSignIn = false;

  void setIsSignIn(bool value) {
    isSignIn = value;
    notifyListeners();
  }

  Future<UserCredential> login() {
    return _auth.signInWithGoogle();
  }

  void logout() => _auth.logOut();
}
