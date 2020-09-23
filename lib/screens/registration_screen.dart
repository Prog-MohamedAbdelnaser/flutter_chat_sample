import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/screens/app_button.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import '../constants.dart';
import '../main.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _credFormKey = GlobalKey<FormState>();
  bool isShowProgress = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  String email;
  String password;

  void register(String mEmail, String mPassword) async {
    setState(() {
      isShowProgress = true;
    });
    try {
      var newUser = await _auth.createUserWithEmailAndPassword(
          email: mEmail, password: mPassword);
      if (newUser != null) {
        Navigator.pushNamed(context, RoutsKey.CHAT_SCREEN);
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      isShowProgress = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: isShowProgress,
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
                  height: 48.0,
                ),
                TextFormField(
                  onChanged: (value) => email = value,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      return null;
                    } else
                      return 'Invalid Email';
                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Entry Email'),
                ),
                SizedBox(
                  height: 8.0,
                ),
                TextFormField(
                  onChanged: (value) => password = value,
                  validator: (value) {
                    if (value.isNotEmpty) {
                      return null;
                    } else
                      return 'Invalid Password';
                  },
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  decoration:
                      kTextFieldDecoration.copyWith(hintText: 'Entry Password'),
                ),
                SizedBox(
                  height: 24.0,
                ),
                AppButton(
                  onPressed: () {
                    if (_credFormKey.currentState.validate()) {
                      register(email, password);
                    }
                  },
                  backgroundColor: Colors.blueAccent,
                  text: 'Register',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
