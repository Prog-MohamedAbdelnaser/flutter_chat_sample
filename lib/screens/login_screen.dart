import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import '../constants.dart';
import '../main.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _credFormKey = GlobalKey<FormState>();
  bool showProgress = false;
  TextEditingController _controller = TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email;
  String password;
  void signIn(String mEmail, String mPassword) async {
    try {
      setState(() {
        showProgress = true;
      });
      var newUser = await _auth.signInWithEmailAndPassword(
          email: mEmail, password: mPassword);
      if (newUser != null) {
        Navigator.pushNamed(context, RoutsKey.CHAT_SCREEN);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      showProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showProgress,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _credFormKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
                SizedBox(
                  height: 48,
                ),
                TextFormField(
                  onChanged: (value) => email = value,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Entry Email'),
                ),
                SizedBox(
                  height: 8,
                ),
                TextFormField(
                  onChanged: (value) => password = value,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Entry Password'),
                ),
                SizedBox(
                  height: 24,
                ),
                AppButton(
                  backgroundColor: Colors.lightBlueAccent,
                  text: 'Log In',
                  onPressed: () {
                    try {
                      if (_credFormKey.currentState.validate()) {
                        signIn(email, password);
                      }
                    } catch (e) {
                      print(e);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
