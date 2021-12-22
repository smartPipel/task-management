import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/login-screen/providers/login_screen_provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginScreenProvider>(context, listen: false);
    return Scaffold(
      body: Center(
          child: Container(
        child: ElevatedButton(
          child: Text(
            'Google SignIn',
            style: defaultFontsStyle(),
          ),
          onPressed: () {
            provider.login();
            Navigator.pushNamedAndRemoveUntil(
                context, Routes.homeRoute, (route) => false);
          },
        ),
      )),
    );
  }
}
