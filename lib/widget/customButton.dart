import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final String btnRoute;
  CustomButton({this.btnText, this.btnRoute});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 70,
      child: RaisedButton(
        onPressed: () {
          Navigator.pushNamed(
              context, btnRoute == 'signin' ? '/teacherlogin' : '/sigup');
        },
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18.0),
            side: BorderSide(color: Colors.red)),
        child: Text("$btnText", style: TextStyle(fontSize: 19)),
        color: Colors.red,
        textColor: Colors.white,
        // elevation: 5,
      ),
    );
  }
}
