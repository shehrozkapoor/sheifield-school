import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:schoolsystem/widget/bg.dart';

class LoginForm extends StatefulWidget {
  final String welcomeString;
  final String signInAS;
  final Function onSubmit;
  LoginForm({this.welcomeString, this.signInAS, this.onSubmit});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
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

  Future<String> _loginAccount() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _loginEmail,
        password: _loginPassword,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No Account with that Email Please SignUp First!';
      } else if (e.code == 'wrong-password') {
        return 'Incorrect Password';
      }
      return e.message;
    } catch (e) {
      return e.toString();
    }
  }

  void _submitForm() async {
    String _loginAccountFeedback = await _loginAccount();
    if (_loginAccountFeedback != null) {
      _alertDialogBuilder(_loginAccountFeedback);
    } else
      Navigator.pushNamed(context, "/landingPage");
  }

  String _loginEmail = '';
  String _loginPassword = '';
  // Focus node for input fields
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
              margin: EdgeInsets.only(top: 100),
              child: Text(
                widget.welcomeString != null
                    ? widget.welcomeString
                    : "Login Page",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 23,
                    fontWeight: FontWeight.w900),
              ),
            ),
            Center(
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
                                        _loginEmail = value.trim();
                                      });
                                    },
                                    decoration: InputDecoration(
                                        hintText: "Enter your username"),
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  TextFormField(
                                    onChanged: (value) {
                                      _loginPassword = value;
                                    },
                                    obscureText: true,
                                    decoration: InputDecoration(
                                        hintText: "Enter your password"),
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
                                onPressed: () {
                                  _submitForm();
                                },
                                child: Text(
                                  'Sign In',
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
            ),
          ],
        ));
  }
}
