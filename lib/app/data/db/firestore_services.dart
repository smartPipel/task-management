// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/app/data/models/to_do.dart';

class FirestoreServices {
  static FirestoreServices instance = FirestoreServices._singleton();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('data_collections');

  FirestoreServices._singleton();

  factory FirestoreServices() {
    return instance;
  }

  Stream<List<ToDo>> getToDoList() {
    final stream = _collectionReference
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        .snapshots();

    return stream
        .map((list) => list.docs.map((e) => ToDo.fromFirestore(e)).toList());
  }

  Future<void> createToDo(ToDo todo) async {
    return await _collectionReference
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

  Future removeToDo(String id) async {
    await _collectionReference
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        .doc(id)
        .delete();
  }

  Future<void> setDone(String id, bool done) async {
    DocumentReference documentReference = _collectionReference
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        .doc(id);
    return await firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception('Data tidak ada');
      }

      bool isDone = done;

      transaction.update(documentReference, {'isDone': isDone});
    });
  }

  Stream getIsDoneLength(bool done) {
    return _collectionReference
        .doc('ObNh7bwCs8r43qJK2jci')
        .collection('to-do')
        .where('isDone', isEqualTo: done == true ? true : false)
        .snapshots();
  }
}
