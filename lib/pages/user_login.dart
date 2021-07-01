import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';
import 'package:csc4360_hw2/widgets/custom_forms.dart';
import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuthException;
import 'package:flutter/material.dart';
import 'package:csc4360_hw2/wrappers/page_wrapper.dart';

class UserLogin extends StatefulWidget {
  const UserLogin({Key? key}) : super(key: key);

  @override
  _UserLoginState createState() => _UserLoginState();
}

class _UserLoginState extends State<UserLogin> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _password  = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextFormField(
                  label: 'Email address',
                  icon: Icons.email,
                  onSaved: (String? value) {
                    _email = (value == null) ? '' : value;
                  },
                  validator: CustomValidator.checkFor([
                    CustomValidator.notEmpty,
                    CustomValidator.validEmail,
                  ]),
                ),
                CustomTextFormField(
                  label: 'Password',
                  icon: Icons.password,
                  onSaved: (String? value) {
                    _password = (value == null) ? '' : value;
                  },
                  validator: CustomValidator.checkFor([
                    CustomValidator.notEmpty,
                  ]),
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () async {

                    // updates the values of _email and _password
                    _formKey.currentState!.save();

                    if (_formKey.currentState!.validate()) {
                      print('Form is valid, processing data...');

                      try {

                        await AuthWrapper.signIn(
                          email: _email,
                          password: _password,
                        );

                        PageWrapper.replaceEverything(context, '/home');

                      } on FirebaseAuthException catch(error) {
                        if (error.code == 'wrong-password' || error.code == 'user-not-found') {
                          // TODO don't use a popup to indicate failed login
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('Incorrect email or password'),
                                actions: <Widget>[
                                  TextButton(
                                    child: Text('Okay'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        } else {
                          print(error);
                        }
                      }

                    } else {
                      print('Form is not valid!');
                    }
                  },
                  child: Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}