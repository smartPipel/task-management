// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:to_do_list/app/utils/services/firestore/firestore_services.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

class TaskCreateScreenProvider with ChangeNotifier {
  final _db = FirestoreServices();
  bool isLoading = true;

  void createTask(String color, String title, String description,
      Timestamp createdAt, Timestamp doneEstimate) {
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

    _db.createToDo(_toDo).whenComplete(() {
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
