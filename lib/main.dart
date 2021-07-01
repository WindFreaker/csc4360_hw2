import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:csc4360_hw2/pages/new_user.dart';
import 'package:csc4360_hw2/pages/user_signup.dart';
import 'package:csc4360_hw2/pages/user_login.dart';
import 'package:csc4360_hw2/pages/home.dart';
import 'package:csc4360_hw2/pages/edit_profile.dart';
import 'package:csc4360_hw2/pages/chat.dart';

Map<String, Widget Function(BuildContext)> routesList = {
  '/new_user': (context) => NewUser(),
  '/user_signup': (context) => UserSignUp(),
  '/user_login': (context) => UserLogin(),
  '/home': (context) => Home(),
  '/edit_profile': (context) => EditProfile(),
  '/chat': (context) => Chat(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChatApp());
}

class ChatApp extends StatelessWidget {
  const ChatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    if (AuthWrapper.checkIfSignedIn()) {

      // TODO figure out why this prints twice
      print('No user already signed in, going to /new_user');

      return MaterialApp(
        routes: routesList,
        initialRoute: '/new_user',
      );

    } else {

      // TODO figure out why this prints twice
      print('User already signed, redirecting to /home');

      return MaterialApp(
        routes: routesList,
        initialRoute: '/home',
      );

    }

  }
}
