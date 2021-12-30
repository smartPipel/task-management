// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';
import 'package:to_do_list/app/modules/initialize-screen/providers/check_connection_provider.dart';
import 'package:to_do_list/app/modules/initialize-screen/view/initial.dart';
import 'package:to_do_list/app/modules/login-screen/providers/login_screen_provider.dart';
import 'package:to_do_list/app/modules/login-screen/view/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _initializeFirebase().whenComplete(() => print('complete'));
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e.toString());
  }

  // final _user = FirebaseAuth.instance;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginScreenProvider>(
            create: (_) => LoginScreenProvider()),
        ChangeNotifierProvider<HomeScreenProvider>(
            create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider<CreateTaskScreenProvider>(
            create: (_) => CreateTaskScreenProvider()),
        ChangeNotifierProvider<CheckConnectionProvider>(
          create: (_) {
            CheckConnectionProvider _check = CheckConnectionProvider();
            _check.initialLoad();
            return _check;
          },
        )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        home: InitializeScreen(),
        onGenerateRoute: RoutesGenerate.genrate,
      ),
    ),
  );
}
