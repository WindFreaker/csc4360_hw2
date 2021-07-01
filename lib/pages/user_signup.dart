import 'package:cloud_firestore/cloud_firestore.dart' show Timestamp;
import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';
import 'package:csc4360_hw2/wrappers/database_wrapper.dart';
import 'package:csc4360_hw2/wrappers/page_wrapper.dart';
import 'package:csc4360_hw2/widgets/custom_forms.dart';
import 'package:flutter/material.dart';

class UserSignUp extends StatefulWidget {
  const UserSignUp({Key? key}) : super(key: key);

  @override
  _UserSignUpState createState() => _UserSignUpState();
}

class _UserSignUpState extends State<UserSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email = '', _password  = '', _displayName = '';

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
                  label: 'Create your password',
                  icon: Icons.password,
                  onSaved: (String? value) {
                    _password = (value == null) ? '' : value;
                  },
                  validator: CustomValidator.checkFor([
                    CustomValidator.notEmpty,
                  ]),
                  obscureText: true,
                ),
                CustomTextFormField(
                  label: 'Verify your new password',
                  icon: Icons.check_circle_outline,
                  validator: (String? value) {
                    if (value == null || value != _password) {
                      return 'Both password fields don\'t match.';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                SizedBox(
                  height: 30,
                ),
                CustomTextFormField(
                  label: 'Create a display name',
                  icon: Icons.assignment_ind,
                  onSaved: (String? value) {
                    _displayName = (value == null) ? '' : value;
                  },
                  validator: CustomValidator.checkFor([
                    CustomValidator.notEmpty,
                  ]),
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

                        AuthWrapper.signUp(
                          email: _email,
                          password: _password,
                        );

                        await modifyUserData(AuthWrapper.getUserID(), {
                          'displayName': _displayName,
                          'registeredAt': Timestamp.now(),
                        });

                        PageWrapper.replaceEverything(context, '/home');

                      } catch (error) {
                        // TODO: display error when emails that already have accounts
                        // DON'T USE A POPUP
                        print(error);
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