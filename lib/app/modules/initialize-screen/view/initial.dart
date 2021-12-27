import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/modules/home-screen/view/home_screen.dart';
import 'package:to_do_list/app/modules/initialize-screen/providers/check_connection_provider.dart';
import 'package:to_do_list/app/modules/login-screen/view/login_screen.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({
    Key? key,
  }) : super(key: key);

  @override
  _InitializeScreenState createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  final user = FirebaseAuth.instance;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<CheckConnectionProvider>(context, listen: false)
          .initialLoad();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _checkConnectionProvider =
        Provider.of<CheckConnectionProvider>(context, listen: false);
    return user.currentUser != null
        ? HomeScreen(
            connectionProvider: _checkConnectionProvider,
          )
        : const LoginScreen();
  }
}
