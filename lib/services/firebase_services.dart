import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseServices {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final CollectionReference _userRef =
      FirebaseFirestore.instance.collection('Users');
  String getUserId() {
    return _firebaseAuth.currentUser.uid;
  }

  CollectionReference getUserRef() {
    return _userRef;
  }
}
