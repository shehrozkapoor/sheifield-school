import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:schoolsystem/widget/customButton.dart';
import 'package:schoolsystem/widget/loginForm.dart';

class StudentLogin extends StatefulWidget {
  @override
  _StudentLoginState createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LoginForm(
          welcomeString: "Welcome to Login",
          signInAS: 'student',
        ),
        Container(
          padding: EdgeInsets.all(8),
          alignment: AlignmentDirectional.bottomCenter,
          child: CustomButton(
            btnText: "Student Sign UP!",
            btnRoute: 'signup',
          ),
        ),
      ],
    );
  }
}
