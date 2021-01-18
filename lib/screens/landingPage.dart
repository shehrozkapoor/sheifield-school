import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:schoolsystem/constant/constant.dart';
import 'package:schoolsystem/constant/test.dart';
import 'package:schoolsystem/screens/studentHomePage.dart';
import 'package:schoolsystem/screens/studentLogin.dart';
import 'package:schoolsystem/screens/teacherHomeScreen.dart';
import 'package:schoolsystem/services/checkadmin.dart';

class MyApplication extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

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
                UserChecks _userChecks = UserChecks();
                if (_user == null) {
                  return StudentLogin();
                } else {
                  
                  return StudentHomePage();
                  // return _userChecks.checkAdmin() == true
                  //     ? TeacherHomeScreen()
                  //     : StudentHomePage();
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
