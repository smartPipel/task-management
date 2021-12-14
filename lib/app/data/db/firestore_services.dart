// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/app/data/models/to_do.dart';

class FirestoreServices {
  static FirestoreServices instance = FirestoreServices._singleton();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  FirestoreServices._singleton();

  factory FirestoreServices() {
    return instance;
  }

  Stream<List<ToDo>> getToDoList() {
    final stream = firestore
        .collection('data_collections')
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        // .where('isDone', isEqualTo: false)
        .snapshots();

    return stream
        .map((list) => list.docs.map((e) => ToDo.fromFirestore(e)).toList());
  }

  Future<void> createToDo(ToDo todo) async {
    return await firestore
        .collection('data_collections')
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        .doc()
        .set(todo.createMap())
        .whenComplete(() => print('berhasil menambah data!'))
        .catchError((e) => print(e.toString()))
        .timeout(
          const Duration(milliseconds: 1000),
          onTimeout: () => {
            print('Timeout: gagal karena timeout!'),
          },
        );
  }

  Future<void> removeToDo(String id) async {
    await firestore
        .collection('data_collections')
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        .doc(id)
        .delete();
  }

  Future<void> setDone(String id, String direction) async {
    if (direction == 'startToEnd') {
      await firestore
          .collection('data_collections')
          .doc('ObNh7bwCs8r43qJK2jci')
          .collection('to-do')
          .doc(id)
          .update({'isDone': true});
    } else if (direction == 'endToStart') {
      await firestore
          .collection('data_collections')
          .doc('ObNh7bwCs8r43qJK2jci')
          .collection('to-do')
          .doc(id)
          .update({'isDone': false});
    }
  }

  Future getId() async {
    return firestore
        .collection('data_collections')
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        .doc()
        .snapshots()
        .map((event) => event.id);
  }
}
