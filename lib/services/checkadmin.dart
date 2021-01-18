import 'package:schoolsystem/services/firebase_services.dart';

class UserChecks {
  FirebaseServices _firebaseServices = FirebaseServices();
  bool checkAdmin() {
    _firebaseServices
        .getUserRef()
        .doc(_firebaseServices.getUserId())
        .collection('userDetails')
        .get()
        .then((querySnapshot) {
      print(querySnapshot.docs[0]['admin']);
      return querySnapshot.docs[0]['admin'];
    });
    return false;
  }
}
