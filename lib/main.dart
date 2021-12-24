// ignore_for_file: avoid_print
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/config/routes/routes.dart';
import 'package:to_do_list/app/modules/create-task/providers/create_task_screen_provider.dart';
import 'package:to_do_list/app/modules/home-screen/providers/home_screen_providers.dart';
import 'package:to_do_list/app/modules/login-screen/providers/login_screen_provider.dart';
import 'package:to_do_list/app/modules/login-screen/view/login_screen.dart';
import 'package:to_do_list/app/utils/services/firestore/firestore_services.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _initializeFirebase().whenComplete(() => print('complete'));
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e.toString());
  }

  final _user = FirebaseAuth.instance.currentUser;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginScreenProvider>(
            create: (_) => LoginScreenProvider()),
        ChangeNotifierProvider<HomeScreenProvider>(
            create: (_) => HomeScreenProvider()),
        ChangeNotifierProvider<CreateTaskScreenProvider>(
            create: (_) => CreateTaskScreenProvider()),
        // StreamProvider<List<ToDo>>.value(
        //   value: _user != null ? _db.getToDoList(_user.uid) : list,
        //   initialData: const [],
        // )
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Task Manager',
        initialRoute: Routes.initialRoute,
        onGenerateRoute: RoutesGenerate.genrate,
      ),
    ),
  );
}
