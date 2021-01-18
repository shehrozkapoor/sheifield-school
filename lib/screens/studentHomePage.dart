import 'package:flutter/material.dart';
import 'package:schoolsystem/constant/constant.dart';
import 'package:schoolsystem/services/firebase_services.dart';
import 'package:schoolsystem/widget/bg.dart';
import 'package:schoolsystem/widget/drawer.dart';
import 'package:schoolsystem/widget/studnetPaymentForm.dart';

class StudentHomePage extends StatefulWidget {
  @override
  _StudentHomePage createState() => _StudentHomePage();
}

class _StudentHomePage extends State<StudentHomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shefield School'),
          backgroundColor: Colors.red,
        ),
        drawer: CustomDrawer(),
        body: StreamBuilder(
          stream: _firebaseServices
              .getUserRef()
              .doc(_firebaseServices.getUserId())
              .collection('userDetails')
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
              return Stack(fit: StackFit.expand, children: [
                BgImage(),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Payment Status',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              margin: EdgeInsets.only(top: 3, right: 3),
                              alignment: Alignment.center,
                              child: Text(
                                snapshot.data.documents[0]['paymentstatus'],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'Amount Paid',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w800),
                                ),
                              ),
                            ),
                            Container(
                              width: 100,
                              height: 40,
                              margin: EdgeInsets.only(top: 3, right: 3),
                              alignment: Alignment.center,
                              child: Text(
                                "₦ ${snapshot.data.documents[0]['payment']}"
                                    .toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800),
                              ),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.red),
                                  borderRadius: BorderRadius.circular(4),
                                  color: Colors.red),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 120),
                        child: Center(
                          child: StudentPaymentForm(),
                        ),
                      ),
                    ],
                  ),
                ),
              ]);
            }
            return Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          },
        ));
  }
}
