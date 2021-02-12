import 'package:flutter/material.dart';

import 'constant.dart';

class PaymentBtn extends StatelessWidget {
  String btntext;
  PaymentBtn({this.btntext});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          border: Border.all(color: Colors.red),
          color: Colors.red,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
          borderRadius: BorderRadius.circular(8.0)),
      child: Text(
        btntext,
        style: Constant.regularHeadings,
      ),
    );
  }
}
