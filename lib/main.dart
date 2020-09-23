import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'screens/chat_screen.dart';
import 'screens/login_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Firebase.initializeApp();
    return MaterialApp(
      routes: {
        RoutsKey.SPLASH_SCREEN: (context) => WelcomeScreen(),
        RoutsKey.LOGIN_SCREEN: (context) => LoginScreen(),
        RoutsKey.REGISTRATION_SCREEN: (context) => RegistrationScreen(),
        RoutsKey.CHAT_SCREEN: (context) => ChatScreen()
      },
      initialRoute: RoutsKey.SPLASH_SCREEN,
    );
  }
}

class RoutsKey {
  static const SPLASH_SCREEN = '/';
  static const LOGIN_SCREEN = '/login';
  static const REGISTRATION_SCREEN = '/registration';
  static const CHAT_SCREEN = '/chat';
}
