// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/utils/services/firestore/firestore_services.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

class CreateTaskScreenProvider with ChangeNotifier {
  final _db = FirestoreServices();
  bool isLoading = true;
  final _user = FirebaseAuth.instance.currentUser;
  final now = DateTime.now();
  int _colorIndex = 0;
  int? _year;
  int? _month;
  int? _day;
  String? _hour;

  int get getColorIndex => _colorIndex;

  setColorIndex(int colorIndex) {
    _colorIndex = colorIndex;
    notifyListeners();
  }

  String get getHour => _hour ?? now.hour.toString();

  setHour(String hour) {
    _hour = hour;
    notifyListeners();
  }

  int get getYear => _year ?? now.year;

  setYear(int year) {
    _year = year;
    notifyListeners();
  }

  int get getMonth => _month ?? now.month;

  setMonth(int month) {
    _month = month;
    notifyListeners();
  }

  int get getDay => _day ?? now.day;

  setDay(int day) {
    _day = day;
    notifyListeners();
  }

  void createTask(BuildContext context, String color, String title,
      String description, Timestamp createdAt, Timestamp doneEstimate) {
    var _toDo = ToDo(
      color: color,
      id: FirebaseFirestore.instance
          .collection('data_collections')
          .doc()
          .collection('ObNh7bwCs8r43qJK2jci')
          .doc()
          .id,
      title: title,
      description: description,
      isDone: false,
      createdAt: createdAt,
      doneEstimate: doneEstimate,
    );

    _db.createToDo(_user!.uid, _toDo).whenComplete(() {
      Navigator.pop(context);
      isLoading = false;
      notifyListeners();
    }).onError((error, stackTrace) {
      isLoading = true;
      notifyListeners();
      print('Error: $error' '\n' 'StackTrace: $stackTrace');
    }).timeout(
      const Duration(seconds: 5),
      onTimeout: () {
        print('timeout');
      },
    );
  }
}
