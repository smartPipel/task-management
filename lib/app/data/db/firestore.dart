import 'package:cloud_firestore/cloud_firestore.dart';

class Firestore {
  static Firestore instance = Firestore._singleton();
  final CollectionReference reference =
      FirebaseFirestore.instance.collection('data_collections');
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Firestore._singleton();

  factory Firestore() {
    return instance;
  }
}
