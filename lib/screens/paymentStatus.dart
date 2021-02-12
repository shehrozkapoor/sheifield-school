import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:schoolsystem/services/firebase_services.dart';


class PaymentStatus extends StatelessWidget {
  FirebaseServices _firebaseServices = FirebaseServices();
  String paymentStatus = 'pending';
  PaymentStatus({this.paymentStatus});

  Future statusUpdate(String id, String status) {
    print(id);
    return _firebaseServices.getUserRef().doc(id).update({
      "paymentstatus": status,
    });
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _firebaseServices.getUserRef().snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final List<DocumentSnapshot> documents = snapshot.data.docs;
          return ListView(
              children: documents
                  .map((doc) => doc['paymentstatus'] == paymentStatus
                      ? Card(
                          child: paymentStatus == 'accepted' ||
                                  paymentStatus == 'rejected'
                              ? Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          "${doc['firstname']} ${doc['lastname']}"),
                                      subtitle: Text(
                                        doc['email'],
                                      ),
                                    ),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "₦ ${doc['payment'].toString()}",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topRight,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(10.0),
                                              child: Text(
                                                "${doc['paymentstatus']}",
                                                style: TextStyle(
                                                    color:
                                                        doc['paymentstatus'] ==
                                                                'accepted'
                                                            ? Colors.green
                                                            : Colors.red,
                                                    fontSize: 22,
                                                    fontWeight:
                                                        FontWeight.w800),
                                              ),
                                            ),
                                          ),
                                        ])
                                  ],
                                )
                              : Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          "${doc['firstname']} ${doc['lastname']}"),
                                      subtitle: Text(
                                        doc['email'],
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          "₦ ${doc['payment'].toString()}",
                                          style: TextStyle(
                                              fontSize: 22,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            onPressed: () async {
                                              await statusUpdate(
                                                  doc['id'], 'accepted');
                                            },
                                            child: Text('Accept'),
                                            color: Colors.green,
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: RaisedButton(
                                            onPressed: () async {
                                              await statusUpdate(
                                                  doc['id'], 'rejected');
                                            },
                                            child: Text('Reject'),
                                            color: Colors.red,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                        )
                      : SizedBox(
                          height: 0.0,
                        ))
                  .toList());
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
