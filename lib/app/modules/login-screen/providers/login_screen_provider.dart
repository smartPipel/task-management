import 'package:flutter/foundation.dart';
import 'package:to_do_list/app/utils/services/auth/google_auth.dart';

class LoginScreenProvider with ChangeNotifier {
  final _auth = GoogleAuth();
  bool isSignIn = false;

  void setIsSignIn(bool value) {
    isSignIn = value;
    notifyListeners();
  }

  void login() => _auth.googleSignIn;

  void logout() => _auth.logOut();
}
