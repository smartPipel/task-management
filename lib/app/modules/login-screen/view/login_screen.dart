// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/login-screen/providers/login_screen_provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user = FirebaseAuth.instance;

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
            provider.login().whenComplete(() => print('berhasil')).then(
                (value) =>
                    Navigator.pushReplacementNamed(context, Routes.homeRoute));
          },
        ),
      )),
    );
  }
}
