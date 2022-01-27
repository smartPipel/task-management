import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/modules/home-screen/view/home_screen.dart';
import 'package:to_do_list/app/modules/initialize-screen/providers/connectivity_provider.dart';
import 'package:to_do_list/app/modules/login-screen/view/login_screen.dart';
import 'package:to_do_list/app/utils/utils.dart';

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
  Widget build(BuildContext context) {
    return Consumer<ConnectivityProvider>(builder: (context, __, _) {
      WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
        final provider =
            Provider.of<ConnectivityProvider>(context, listen: false);

        showSnackBar(context, provider.message, provider.isConnect);
      });
      return user.currentUser != null
          ? const HomeScreen()
          : const LoginScreen();
    });
  }
}
