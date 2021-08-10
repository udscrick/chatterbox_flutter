
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/zNa8YPyHfhoTky6r1R6B/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if(streamSnapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(),);
          }
          final docs = streamSnapshot.data.documents;
          return ListView.builder(
             itemCount: streamSnapshot.data.documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8),
              child: Text(docs[index]['text']),
            ),
           
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance.collection('chats/zNa8YPyHfhoTky6r1R6B/messages')
          .add({'text':'Text Added From App'});
        },
      ),
    );
  }
}
