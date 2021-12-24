import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/config/routes/routes.dart';

class InitializeScreen extends StatefulWidget {
  const InitializeScreen({Key? key}) : super(key: key);

  @override
  _InitializeScreenState createState() => _InitializeScreenState();
}

class _InitializeScreenState extends State<InitializeScreen> {
  final user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    choseScreen();
    super.initState();
  }

  choseScreen() async {
    if (user != null) {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, Routes.homeRoute);
      });
    } else {
      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushReplacementNamed(context, Routes.loginRoute);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          child: const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
