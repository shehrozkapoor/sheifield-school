import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:schoolsystem/constant/constant.dart';
import 'package:schoolsystem/screens/studentHomePage.dart';
import 'package:schoolsystem/screens/studentLogin.dart';
import 'package:schoolsystem/screens/teacherHomeScreen.dart';
import 'package:schoolsystem/services/firebase_services.dart';

class MyApplication extends StatefulWidget {
  @override
  _MyApplicationState createState() => _MyApplicationState();
}

class _MyApplicationState extends State<MyApplication> {
  bool _isAdmin;
  FirebaseServices _firebaseServices = FirebaseServices();
  bool onPressed() {
    _firebaseServices
        .getUserRef()
        .doc(_firebaseServices.getUserId())
        .get()
        .then((querySnapshot) {
      _isAdmin = querySnapshot.data()['admin'];
    });
    return false;
  }

  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  void initState() {
    super.initState();
    setState(() {
      onPressed();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
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
        if (snapshot.connectionState == ConnectionState.done) {
          return StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, streamSnapShot) {
              if (streamSnapShot.hasError) {
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
              // connection state is active
              if (streamSnapShot.connectionState == ConnectionState.active) {
                User _user = streamSnapShot.data;
                if (_user == null) {
                  return StudentLogin();
                } else {
                  // return TeacherHomeScreen();
                  return _isAdmin == true
                      ? TeacherHomeScreen()
                      : StudentHomePage();
                }
              }
              // checking the auth state - loading
              return Scaffold(
                body: Container(
                  child: Center(
                    child: Text(
                      'Initializing app',
                      style: Constant.regularHeadings,
                    ),
                  ),
                ),
              );
            },
          );
        }
        return Scaffold(
          body: Container(
            child: Center(
              child: Text(
                'Initializing app',
                style: Constant.regularHeadings,
              ),
            ),
          ),
        );
      },
    );
  }
}
