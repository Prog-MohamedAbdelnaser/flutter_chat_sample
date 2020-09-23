import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../main.dart';
import 'app_button.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation animation;
  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    //  animation = CurvedAnimation(parent: animationController, curve: Curves.decelerate);
    animation = ColorTween(begin: Colors.black, end: Colors.white)
        .animate(animationController);
    animationController.forward();
    animationController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/logo.png'),
                    height: 68,
                  ),
                ),
                SizedBox(
                  child: TypewriterAnimatedTextKit(
                    speed: Duration(milliseconds: 250),
                    textStyle: TextStyle(
                      fontSize: 45.0,
                      fontWeight: FontWeight.w900,
                    ),
                    text: ['Flash Chat'],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48,
            ),
            AppButton(
              text: 'Log In',
              backgroundColor: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RoutsKey.LOGIN_SCREEN);
              },
            ),
            AppButton(
              text: 'Register',
              backgroundColor: Colors.blueAccent,
              onPressed: () {
                Navigator.pushNamed(context, RoutsKey.REGISTRATION_SCREEN);
              },
            ),
          ],
        ),
      ),
    );
  }
}
