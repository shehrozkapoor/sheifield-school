import 'firebase_services.dart';

class AddInfo {
  FirebaseServices _firebaseServices = FirebaseServices();

  addUser(String firstname, String lastname, String email) {
    return _firebaseServices
        .getUserRef()
        .doc(_firebaseServices.getUserId())
        .collection('userDetails')
        .doc(_firebaseServices.getUserId())
        .set({
      "firstname": firstname,
      'lastname': lastname,
      'email': email,
      'admin': false,
      'payment': 0,
      'paymentstatus': 'none',
    });
  }
}
