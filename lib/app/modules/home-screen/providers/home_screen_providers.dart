// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/utils/helpers/date_time_helper.dart';
import 'package:to_do_list/app/utils/services/auth/google_auth.dart';
import 'package:to_do_list/app/utils/services/firestore/firestore_services.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

class HomeScreenProvider with ChangeNotifier {
  final _db = FirestoreServices();
  final _user = FirebaseAuth.instance.currentUser;
  final _auth = GoogleAuth();

  String? _id;
  String? _title;
  String? _description;
  String? _color;
  bool? _isDone;
  final Timestamp _createdAt = Timestamp.now();
  Timestamp? _doneEstimate;
  String? _length = '0';

  String get getId => _id!;
  String get getTitle => _title!;
  String get getDescription => _description!;
  bool get getIsDone => _isDone!;
  Timestamp get getCreatedAt => _createdAt;
  Timestamp get getDoneEstimate => _doneEstimate!;
  String get getColor => _color!;
  String get getToDoLength => _length!.isEmpty ? '0' : _length!;

  void setToDoLength(String length) {
    _length = length;
    notifyListeners();
  }

  void setTitle(String title) {
    _title = title;
    notifyListeners();
  }

  void setColor(String color) {
    _color = color;
    notifyListeners();
  }

  void setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  void setIsDone(bool isDone) {
    _isDone = isDone;
    notifyListeners();
  }

  void setDoneEstimate(DateTime doneEstimate) {
    _doneEstimate = toTimestamp(doneEstimate);
    notifyListeners();
  }

  void deleteToDo(String id) {
    assert(_user != null);
    _db.removeToDo(_user!.uid, id);
  }

  getData() {
    assert(_user != null);
    var todo = _db.getToDoList(_user!.uid);
    if (todo.length == null) {
      return;
    } else {
      return todo;
    }
  }

  void isDoneSet(String id, bool done) {
    _db.setDone(_user!.uid, id, done);
  }

  void removeYesterdayTask() {
    _db.removeYesterdayTask(_user!.uid);
  }

  void logout() {
    _auth.logOut();
  }
}
