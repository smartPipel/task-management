// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_list/app/utils/helpers/date_time_helper.dart';
import 'package:to_do_list/app/utils/services/firestore/firestore_services.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

class HomeScreenProvider with ChangeNotifier {
  final _db = FirestoreServices();

  String? _id;
  String? _title;
  String? _description;
  String? _color;
  bool? _isDone;
  Timestamp _createdAt = Timestamp.now();
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

  void loadToDo(ToDo toDo) {
    _id = toDo.id;
    _title = toDo.title;
    _description = toDo.description;
    _isDone = toDo.isDone;
    _createdAt = toDo.createdAt;
    _doneEstimate = toDo.doneEstimate;
  }

  void saveToDo() {
    var _toDo = ToDo(
      color: _color!,
      id: FirebaseFirestore.instance
          .collection('data_collections')
          .doc()
          .collection('ObNh7bwCs8r43qJK2jci')
          .doc()
          .id,
      title: getTitle,
      description: getDescription,
      isDone: getIsDone,
      createdAt: getCreatedAt,
      doneEstimate: getDoneEstimate,
    );

    _db.createToDo(_toDo);
    print(_toDo.createdAt.toString());
  }

  void deleteToDo(String id) {
    _db.removeToDo(id);
  }

  getData() {
    var todo = _db.getToDoList();
    return todo;
  }

  void isDoneSet(String id, bool done) {
    _db.setDone(id, done);
  }
}
