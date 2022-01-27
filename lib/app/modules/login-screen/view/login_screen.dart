// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/constants/app_constants.dart';
import 'package:to_do_list/app/modules/login-screen/providers/login_screen_provider.dart';
import 'package:to_do_list/app/utils/utils.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final user = FirebaseAuth.instance;
  bool isSignIn = false;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<LoginScreenProvider>(context, listen: false);
    return Scaffold(
      body: Center(
        child: isSignIn
            ? Container(
                color: Colors.white,
                child: const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.pinkAccent),
                ),
              )
            : SizedBox(
                child: ElevatedButton(
                  child: Text(
                    'Google SignIn',
                    style: defaultFontsStyle(),
                  ),
                  onPressed: () {
                    setState(() {
                      isSignIn = true;
                    });
                    provider.login().whenComplete(
                      () {
                        showSnackBar(context, 'Berhasil login', 'true');
                        print('berhasil');
                        Navigator.pushReplacementNamed(
                            context, Routes.homeRoute);
                      },
                    ).onError(
                      (error, stackTrace) =>
                          showSnackBar(context, 'Error login: $error', 'false'),
                    );
                    setState(() {
                      isSignIn = false;
                    });
                  },
                ),
              ),
      ),
    );
  }
}
