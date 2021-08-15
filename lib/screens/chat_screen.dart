import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_complete_guide/widgets/chat/messages.dart';
import 'package:flutter_complete_guide/widgets/chat/new_message.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(Icons.more_vert,
                  color: Theme.of(context).primaryIconTheme.color),
              items: [
                DropdownMenuItem(
                  child: Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.exit_to_app,
                          color: Colors.black,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('Logout')
                      ],
                    ),
                  ),
                  value: 'logout',
                )
              ],
              onChanged: (itemIdentifier) {
                if (itemIdentifier == 'logout') {
                  FirebaseAuth.instance.signOut();
                }
              },
            ),
          )
        ],
      ),
      body: Container(
        child: Column(children: [
          Expanded(
            child: Messages(),
          ),
          Align(
              alignment: FractionalOffset.bottomCenter,
              child: NewMessage())
        ]),
      ),
     
    );
  }
}
