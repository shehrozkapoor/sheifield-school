import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:schoolsystem/services/firebase_services.dart';

class StudentPaymentForm extends StatefulWidget {
  @override
  _StudentPaymentFormState createState() => _StudentPaymentFormState();
}

class _StudentPaymentFormState extends State<StudentPaymentForm> {
  int _paymentAmount = 0;
  updateData() async {
    FirebaseServices _firebaseService = FirebaseServices();
    CollectionReference collectionReference = _firebaseService
        .getUserRef()
        .doc(_firebaseService.getUserId())
        .collection('userDetails');
    await collectionReference
        .doc(_firebaseService.getUserId())
        .update({'payment': _paymentAmount, 'paymentStatus': "pending"});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Form(
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (value) {
                              setState(() {
                                _paymentAmount = int.parse(value);
                              });
                            },
                            decoration: InputDecoration(
                                hintText: "Enter your Payment Amount"),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: RaisedButton(
                        onPressed: updateData,
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Colors.red,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
