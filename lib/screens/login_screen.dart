import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/main_btn.dart';
import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const id = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? email;
  String? password;
  bool showSpinner = false;
  FirebaseAuth _auth = FirebaseAuth.instance;
  void getLoginStates() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: showSpinner
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Flexible(
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                  SizedBox(
                    height: 48.0,
                  ),
                  TextField(
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kTextFiledDecoration.copyWith(
                        hintText: 'Enter your email'),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kTextFiledDecoration.copyWith(
                        hintText: 'Enter your password.'),
                  ),
                  SizedBox(
                    height: 24.0,
                  ),
                  MainBtn(
                    color: Colors.blueAccent,
                    text: 'Login',
                    onPressed: () async {
                      if (email != null && password != null) {
                        setState(() {
                          showSpinner = true;
                        });
                        final newUser = await _auth.signInWithEmailAndPassword(
                            email: email!, password: password!);

                        try {
                          if (newUser.user != null && mounted) {
                            Navigator.pushNamedAndRemoveUntil(
                                context, ChatScreen.id, (r) => false);
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(
                                  'You are Logged in ${newUser.user!.email}'),
                              duration: const Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'ACTION',
                                onPressed: () {},
                              ),
                            ));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text('error you are not Logged in '),
                              duration: const Duration(seconds: 1),
                              action: SnackBarAction(
                                label: 'ACTION',
                                onPressed: () {},
                              ),
                            ));
                          }
                        } catch (e) {
                          print(e);
                        }
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  )
                ],
              ),
            ),
    );
  }
}
