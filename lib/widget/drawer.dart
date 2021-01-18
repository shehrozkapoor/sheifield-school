import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoolsystem/services/firebase_services.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  FirebaseServices _firebaseServices = FirebaseServices();
  final _auth = FirebaseAuth.instance;
  dynamic user;
  String _email = '';
  String _firstname = '';
  String _lastname = '';
  void getData() {
    CollectionReference userRef = _firebaseServices
        .getUserRef()
        .doc(_firebaseServices.getUserId())
        .collection('userDetails');
    userRef.snapshots().listen((snapshot) {
      setState(() {
        _firstname = snapshot.docs[0].data()['firstname'];
        _lastname = snapshot.docs[0].data()['lastname'];
      });
    });
  }

  void getCurrentUserInfo() {
    user = _auth.currentUser;
    _email = user.email;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserInfo();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.redAccent, Colors.red])),
            accountName: Text('$_firstname $_lastname'),
            accountEmail: Text('$_email'),
          ),
          SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: ListTile(
              leading: Icon(
                Icons.person,
                size: 30,
              ),
              title: Text('Logout'),
              trailing: Icon(
                Icons.logout,
                size: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
