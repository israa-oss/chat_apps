import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_apps/screens/registration_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat_screen.dart';
import 'login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  static const id = 'WelcomeScreen';

  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    //
    with
        SingleTickerProviderStateMixin {
  late AnimationController controller;
  late AnimatedTextKit textKit;
  Duration duration = const Duration(seconds: 1);
  late Animation animation;
  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: duration);
    controller.forward();
    controller.addListener(() {
      print(controller.value);
      setState(() {});
    });
    animation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);
    // animation =
    //وين في لون يتم استخدامها
    //     ColorTween(begin: Colors.red, end: Colors.blue).animate(controller);
    // animation.addListener(() {
    //   print(animation.status);
    //   setState(() {});f
    // });
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse();
    //   }
    //   if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    // print(controller.status);
    // الحفاظ على الحالة الاخيرة
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        Navigator.pushNamedAndRemoveUntil(
            context, ChatScreen.id, (route) => false);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: SizedBox(
                    height: animation.value * 100,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                AnimatedTextKit(
                  // للاعادة اكثر من مرة
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      'Chat App',
                      speed: const Duration(milliseconds: 200),
                      // '${(animation.value * 100).toInt()}',
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                      ),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30.0),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                    //Go to login screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Log In',
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: Material(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(30.0),
                elevation: 5.0,
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);

                    //Go to registration screen.
                  },
                  minWidth: 200.0,
                  height: 42.0,
                  child: const Text(
                    'Register',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
