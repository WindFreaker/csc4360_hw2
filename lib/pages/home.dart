import 'package:csc4360_hw2/wrappers/page_wrapper.dart';
import 'package:csc4360_hw2/widgets/contacts_list.dart';
import 'package:csc4360_hw2/widgets/conversations_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Demo Chat App'),
          centerTitle: true,
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                text: 'Conversations'
              ),
              Tab(
                text: 'Contacts'
              ),
            ],
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.account_circle),
              onPressed: () {
                PageWrapper.addOnTop(context, '/edit_profile');
              },
            ),
          ],
        ),
        body: TabBarView(
          children: <Widget>[
            ConversationsList(),
            ContactsList(),
          ],
        ),
      ),
    );
  }
}
