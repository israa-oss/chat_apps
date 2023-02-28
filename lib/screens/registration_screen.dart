import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/main_btn.dart';
import '../constants.dart';
import 'chat_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const id = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String? email;
  String? password;
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
  void initState() {
    getLoginStates();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
              onChanged: (value) {
                email = value;
              },
              decoration: const InputDecoration(
                hintText: 'Enter your email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
                  borderRadius: BorderRadius.all(Radius.circular(32.0)),
                ),
              ),
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              onChanged: (value) {
                password = value;
              },
              decoration: kTextFiledDecoration.copyWith(
                  hintText: 'Enter your password'),
            ),
            SizedBox(
              height: 24.0,
            ),
            MainBtn(
              color: Colors.blueAccent,
              text: 'Register',
              onPressed: () async {
                if (email != null && password != null) {
                  final newUser = await _auth.createUserWithEmailAndPassword(
                      email: email!.trim(), password: password!);

                  try {
                    if (newUser.user != null && mounted) {
                      Navigator.pushNamed(context, ChatScreen.id);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text('You are Logged in ${newUser.user!.email}'),
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
              },
            )
          ],
        ),
      ),
    );
  }
}
