// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:to_do_list/app/utils/services/models/to_do.dart';

class FirestoreServices {
  static FirestoreServices instance = FirestoreServices._singleton();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection('data_collections');

  FirestoreServices._singleton();

  factory FirestoreServices() {
    return instance;
  }

  Stream<List<ToDo>> getToDoList(String uid) {
    final stream = _collectionReference
        .doc(uid)
        .collection("to-do")
        .orderBy("createdAt", descending: false)
        // .orderBy('isDone', descending: true)
        .snapshots();

    return stream
        .map((list) => list.docs.map((e) => ToDo.fromFirestore(e)).toList());
  }

  Future<void> createToDo(String uid, ToDo todo) async {
    return await _collectionReference
        .doc(uid)
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

  void removeYesterdayTask(String uid) {
    _collectionReference
        .doc(uid)
        .collection('to-do')
        .where('doneEstimate', isLessThan: Timestamp.fromDate(DateTime.now()));
  }

  Future removeToDo(String uid, String id) async {
    await _collectionReference.doc(uid).collection('to-do').doc(id).delete();
  }

  Future<void> setDone(String uid, String id, bool done) async {
    DocumentReference documentReference =
        _collectionReference.doc(uid).collection('to-do').doc(id);
    return await firestore.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentReference);

      if (!snapshot.exists) {
        throw Exception('Data tidak ada');
      }

      bool isDone = done;

      transaction.update(documentReference, {'isDone': isDone});
    });
  }

  Stream getIsDoneLength(String uid, bool done) {
    return _collectionReference
        .doc(uid)
        .collection('to-do')
        .where('isDone', isEqualTo: done == true ? true : false)
        .snapshots();
  }
}
