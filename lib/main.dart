// ignore_for_file: avoid_print
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list/app/data/db/firestore_services.dart';
import 'package:to_do_list/app/data/models/to_do.dart';
import 'package:to_do_list/app/providers/todo/to_do_provider.dart';
import 'package:to_do_list/routes/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // _initializeFirebase().whenComplete(() => print('complete'));
  try {
    await Firebase.initializeApp();
  } catch (e) {
    print(e.toString());
  }

  final _db = FirestoreServices();

  runApp(MultiProvider(
    providers: [
      // ChangeNotifierProvider<ToDoProvider>(create: (_) => ToDoProvider()),
      ChangeNotifierProvider.value(value: ToDoProvider()),
      StreamProvider<List<ToDo>>.value(
        value: _db.getToDoList(),
        initialData: const [],
      )
    ],
    child: const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do',
      initialRoute: Routes.homeRoute,
      onGenerateRoute: RouteGenerate.genrate,
    ),
  ));
}
