import 'package:flutter/material.dart';
import 'package:schoolsystem/constant/paymentStatusBtn.dart';
import 'package:schoolsystem/screens/paymentStatus.dart';
import 'package:schoolsystem/widget/bg.dart';
import 'package:schoolsystem/widget/drawer.dart';

class TeacherHomeScreen extends StatefulWidget {
  @override
  _TeacherHomeScreenState createState() => _TeacherHomeScreenState();
}

class _TeacherHomeScreenState extends State<TeacherHomeScreen> {
  String _paymentStatus = 'pending';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shefield School'),
      ),
      drawer: CustomDrawer(),
      body: Stack(
        fit: StackFit.expand,
        children: [
          BgImage(),
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _paymentStatus = 'accepted';
                      });
                    },
                    child: PaymentBtn(
                      btntext: "ACCEPTED PAYMENTS",
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _paymentStatus = 'pending';
                      });
                    },
                    child: PaymentBtn(
                      btntext: "PENDING PAYMENTS",
                    ),
                  ),
                  GestureDetector(
                      onTap: () {
                        setState(() {
                          _paymentStatus = 'rejected';
                        });
                      },
                      child: PaymentBtn(btntext: "Rejected PAYMENTS")),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50),
            padding: EdgeInsets.all(10),
            child: PaymentStatus(
              paymentStatus: _paymentStatus,
            ),
          ),
        ],
      ),
    );
  }
}
