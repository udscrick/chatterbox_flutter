import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
 

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  String enteredMsg = '';
  final txtController = new TextEditingController();
  void onMsgSend()async{
            FocusScope.of(context).unfocus();
            final userInfo = await FirebaseAuth.instance.currentUser();
            Firestore.instance.collection('chats').add({
              "text":enteredMsg,
              "createdAt":Timestamp.now(),
              'userId': userInfo.uid
            });
            txtController.clear();
          }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      width: double.infinity,
      height: MediaQuery.of(context).size.height/10,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: txtController,
              decoration: InputDecoration(
                hintText: 'Enter your message...'
              ),
              onChanged: (value){
                setState(() {
                                  
                            enteredMsg = value;
                                });
              },
            ),
          ),
          SizedBox(width: 5,),
          IconButton(icon: Icon(Icons.send), onPressed:enteredMsg.isEmpty?null:onMsgSend)
        ],
      )
    );
  }
}