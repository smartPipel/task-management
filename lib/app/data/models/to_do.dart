import 'package:cloud_firestore/cloud_firestore.dart';

class ToDo {
  String id;
  String title;
  String description;
  bool isDone;
  Timestamp createdAt;
  Timestamp doneEstimate;

  ToDo(
      {required this.id,
      required this.title,
      required this.description,
      required this.isDone,
      required this.createdAt,
      required this.doneEstimate});

  Map<String, dynamic> createMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isDone': isDone,
      'createdAt': createdAt,
      'doneEstimate': doneEstimate,
    };
  }

  ToDo.fromFirestore(DocumentSnapshot snapshot)
      : id = snapshot.id,
        title = snapshot['title'],
        description = snapshot['description'],
        isDone = snapshot['isDone'],
        createdAt = snapshot['createdAt'],
        doneEstimate = snapshot['doneEstimate'];
}
