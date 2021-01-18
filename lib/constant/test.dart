import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolsystem/services/firebase_services.dart';

class Test extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  FirebaseFirestore firestoreInstance = FirebaseFirestore.instance;
  void test() {
    firestoreInstance.collection("users").get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        print(result.data());
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: RaisedButton(
      onPressed: test,
      child: Text('press'),
    )));
  }
}
