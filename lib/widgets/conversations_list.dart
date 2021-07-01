import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';
import 'package:csc4360_hw2/wrappers/database_wrapper.dart';
import 'package:csc4360_hw2/wrappers/page_wrapper.dart';
import 'package:flutter/material.dart';

class ConversationsList extends StatefulWidget {
  const ConversationsList({Key? key}) : super(key: key);

  @override
  _ConversationsListState createState() => _ConversationsListState();
}

class _ConversationsListState extends State<ConversationsList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: chatsListStream(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        return new ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            late String recipientID, chatName;

            Map<String, dynamic> data = document.data() as Map<String, dynamic>;

            if (data['members'].length == 2) {
              if (data['members'][0] == AuthWrapper.getUserID()) {
                recipientID = data['members'][1];
              } else {
                recipientID = data['members'][0];
              }
              chatName = recipientID;  // TODO make this show their contact name not their ID
            }

            return new ListTile(
              title: new Text(chatName),
              onTap: () {
                PageWrapper.addOnTopWithData(context, '/chat', {
                  'type': 0,  // TODO replace type with a enum (if Dart even has those)
                  'directID': recipientID,
                  'directName': chatName,
                });
              },
            );
          }).toList(),
        );
      },
    );
  }
}
