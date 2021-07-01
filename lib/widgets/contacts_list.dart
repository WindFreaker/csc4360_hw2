import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360_hw2/wrappers/database_wrapper.dart';
import 'package:csc4360_hw2/wrappers/page_wrapper.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: contactsListStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return new ListTile(
              title: new Text(data['displayName']),
              onTap: () {
                PageWrapper.addOnTopWithData(context, '/chat', {
                  'type': 0,  // TODO replace type with a enum (if Dart even has those)
                  'directID': document.id,
                  'directName': data['displayName'],
                });
              },
            );
          }).toList(),
        );
      },
    );
  }
}
