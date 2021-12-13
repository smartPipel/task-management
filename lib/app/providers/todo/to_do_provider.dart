import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_list/app/data/db/firestore_services.dart';
import 'package:to_do_list/app/data/models/to_do.dart';

class ToDoProvider with ChangeNotifier {
  final _db = FirestoreServices();

  String? _id;
  String? _title;
  String? _description;
  bool? _isDone;
  Timestamp _createdAt = Timestamp.now();
  Timestamp? _doneEstimate;

  String get getId => _id!;
  String get getTitle => _title!;
  String get getDescription => _description!;
  bool get getIsDone => _isDone!;
  Timestamp get getCreatedAt => _createdAt;
  Timestamp get getDoneEstimate => _doneEstimate!;

  void setTitle(String title) {
    _title = title;
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
    _doneEstimate = Timestamp.fromDate(doneEstimate);
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
        doneEstimate: getDoneEstimate);

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

  void isDoneSet(String id, String dismissDirection) {
    _db.setDone(id, dismissDirection);
  }
}
