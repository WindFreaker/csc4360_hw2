import 'package:csc4360_hw2/widgets/chat_widgets.dart';
import 'package:csc4360_hw2/wrappers/auth_wrapper.dart';
import 'package:csc4360_hw2/wrappers/database_wrapper.dart';
import 'package:csc4360_hw2/wrappers/page_wrapper.dart';
import 'package:flutter/material.dart';

class Chat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // variables required for a proper chat page
    late String barTitle, conversationID;

    var data = PageWrapper.getDataFromPrevious(context);

    if (data['type'] == 0) {  // type 0 is direct messages
      barTitle = data['directName'];
      conversationID = combineTwoIDs(AuthWrapper.getUserID(), data['directID']);
    } else {
      throw Error();  // Unknown chat type!
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(barTitle),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ChatMessages(
                  conversationID: conversationID,
                ),
                ChatInput(
                  conversationID: conversationID,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
