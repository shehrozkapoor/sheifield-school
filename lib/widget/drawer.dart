import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoolsystem/constant/constant.dart';
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

  void getCurrentUserInfo() {
    user = _auth.currentUser;
    _email = user.email;
  }

  @override
  void initState() {
    super.initState();
    getCurrentUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseServices
          .getUserRef()
          .doc(_firebaseServices.getUserId())
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Container(
              child: Center(
                child: Text(
                  'Error: ${snapshot.error}',
                  style: Constant.regularHeadings,
                ),
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          return Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          colors: [Colors.redAccent, Colors.red])),
                  accountName: Text(
                      '${snapshot.data['firstname']} ${snapshot.data['lastname']}'),
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
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
