import 'package:csc4360_hw2/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';
import 'package:csc4360_hw2/wrappers/page_wrapper.dart';

class NewUser extends StatelessWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Austin Farmer\'s\nDemo Chat App',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              ButtonRow(
                buttons: <ButtonStyleButton>[
                  ElevatedButton(
                    onPressed: () {
                      PageWrapper.addOnTop(context, '/user_signup');
                    },
                    child: Text('Sign up'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      PageWrapper.addOnTop(context, '/user_login');
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}