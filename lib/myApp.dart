import 'package:flutter/material.dart';
import 'package:schoolsystem/screens/studentHomePage.dart';
import 'package:schoolsystem/screens/studentLogin.dart';
import 'package:schoolsystem/widget/signUpForm.dart';
import 'package:schoolsystem/screens/landingPage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "shefield school",
      home: MyApplication(),
      theme: ThemeData(primarySwatch: Colors.red),
      routes: {
        '/stuentlogin': (context) => StudentLogin(),
        '/stuenthomepage': (context) => StudentHomePage(),
        '/sigup': (context) => SignUpForm(),
      },
    );
  }
}
