import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (ctx,index)=>Container(
        padding: EdgeInsets.all(8),
        child: Text('test'),
      
      ),
      itemCount: 10,
      ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.add),
      onPressed: (){
        Firestore.instance.collection('chats/zNa8YPyHfhoTky6r1R6B/messages')
        .snapshots().listen((data) { 
          print("Data recvd: ${data.documents[0]['text']}");
        });
      },
      ),
    );
  }
}