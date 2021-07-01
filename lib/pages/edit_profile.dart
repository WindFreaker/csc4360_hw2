import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';
import 'package:csc4360_hw2/wrappers/database_wrapper.dart';
import 'package:csc4360_hw2/wrappers/page_wrapper.dart';
import 'package:csc4360_hw2/widgets/custom_forms.dart';
import 'package:csc4360_hw2/widgets/custom_buttons.dart';
import 'package:flutter/material.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  final _ctrlName = TextEditingController();

  Future<void> resetForm() async {
    var data = await getUserData(AuthWrapper.getUserID());
    if (data != null) {
      _ctrlName.text = data['displayName'];
    }
  }

  Future<void> saveForm() async {
    await modifyUserData(AuthWrapper.getUserID(), {'displayName': _ctrlName.value.text});
  }

  @override
  void initState() {
    resetForm();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              AuthWrapper.signOut();
              PageWrapper.replaceEverything(context, '/new_user');
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CustomTextFormField(
                  label: 'Display name',
                  icon: Icons.assignment_ind,
                  controller: _ctrlName,
                ),
                SizedBox(
                  height: 30,
                ),
                ButtonRow(
                  buttons: <ButtonStyleButton>[
                    ElevatedButton(
                      child: Text('Cancel'),
                      onPressed: resetForm,
                    ),
                    ElevatedButton(
                      child: Text('Save'),
                      onPressed: saveForm,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
