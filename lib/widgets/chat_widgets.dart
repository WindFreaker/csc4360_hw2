import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';
import 'package:csc4360_hw2/wrappers/database_wrapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatMessages extends StatefulWidget {
  final String conversationID;

  ChatMessages({required this.conversationID});

  @override
  _ChatMessagesState createState() => _ChatMessagesState();
}

class _ChatMessagesState extends State<ChatMessages> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: StreamBuilder(
        stream: conversationStream(widget.conversationID),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return ListView.builder(
              padding: const EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return messageWidget(snapshot.data!.docs[index]);
              },
              itemCount: snapshot.data!.docs.length,
              reverse: true,
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

Widget messageWidget(QueryDocumentSnapshot document) {

  if (document['fromID'] == AuthWrapper.getUserID()) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        SizedBox(
          width: 20,
        ),
        Text(
          document['message'],
          style: TextStyle(
            backgroundColor: Colors.blue,
          ),
        ),
      ],
    );
  } else {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          document['message'],
          style: TextStyle(
            backgroundColor: Colors.red,
          ),
        ),
      ],
    );
  }

}

class ChatInput extends StatefulWidget {
  final String conversationID;

  ChatInput({required this.conversationID});

  @override
  _ChatInputState createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  var _ctrlInput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
          child: Container(
            child: TextField(
              autofocus: true,
              maxLines: 3,
              decoration: const InputDecoration.collapsed(
                hintText: 'Type your message here...',
              ),
              controller: _ctrlInput,
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.send),
          onPressed: () async {
            if (_ctrlInput.text != '') {
              await addMessageToConversation(widget.conversationID, _ctrlInput.text);
              _ctrlInput.text = '';
            }
          },
        ),
      ],
    );
  }
}

