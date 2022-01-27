// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';
import 'package:to_do_list/app/modules/initialize-screen/providers/connectivity_provider.dart';
import 'package:to_do_list/app/modules/initialize-screen/view/initial.dart';
import 'package:to_do_list/app/modules/login-screen/providers/login_screen_provider.dart';

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
        ChangeNotifierProvider<ConnectivityProvider>(
          create: (_) {
            ConnectivityProvider _check = ConnectivityProvider();
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
