import 'package:flutter/material.dart';
import 'package:schoolsystem/services/addInfo.dart';
import 'package:schoolsystem/services/firebase_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'bg.dart';

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  AddInfo _addInfo = AddInfo();
  Future<void> _alertDialogBuilder(String error) async {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Error'),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  Future<String> _createAccount() async {
    if (_registerPassword != _registerConfirmPassword) {
      return "Please Enter Same Password";
    } else if (_firstname.isEmpty || _lastname.isEmpty) {
      return "Please Enter All Fields Correctly";
    }
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _registerEmail,
        password: _registerPassword,
      );

      _addInfo.addUser(_firstname, _lastname, _registerEmail);
      // _addUser(_firstname, _lastname);
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'Password is too Short.';
      } else if (e.code == 'email-already-in-use') {
        return 'The email is already in use please try a differient one!';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      _alertDialogBuilder(_createAccountFeedback);
    } else {
      Navigator.pop(context);
    }
  }

  String _registerEmail = '';
  String _registerPassword = '';
  String _registerConfirmPassword = '';
  String _firstname = '';
  String _lastname = '';
  // Focus node for input fields
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Shefield School',
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.red,
        ),
        body: Stack(
          fit: StackFit.expand,
          children: [
            BgImage(),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                "Welcome to Student Sign Up",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 60),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(9.0),
                      child: Column(
                        children: [
                          Form(
                            child: Column(
                              children: [
                                TextFormField(
                                  onChanged: (value) {
                                    _registerEmail = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter your username"),
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    _firstname = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter your first name"),
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    _lastname = value;
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Enter your lastname"),
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    _registerPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Enter your Password"),
                                ),
                                TextFormField(
                                  onChanged: (value) {
                                    _registerConfirmPassword = value;
                                  },
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: "Confirm your password"),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RaisedButton(
                              onPressed: () {
                                _submitForm();
                              },
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
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
          ],
        ));
  }
}
