import 'package:flutter/material.dart';
import 'package:schoolsystem/constant/constant.dart';
import 'package:schoolsystem/widget/bg.dart';
import 'package:schoolsystem/widget/drawer.dart';

class TeacherHomeScreen extends StatelessWidget {
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
            padding: const EdgeInsets.all(3.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                        border: Border.all(color: Colors.red),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text('APPROVED PAYMENTS',
                        style: Constant.regularHeadings),
                  ),
                  Container(
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
                      'PENDING PAYMENTS',
                      style: Constant.regularHeadings,
                    ),
                  ),
                  Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 10,
                          ),
                        ],
                        border: Border.all(color: Colors.red),
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(8.0)),
                    child: Text(
                      'REJECTED PAYMENTS',
                      style: Constant.regularHeadings,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
