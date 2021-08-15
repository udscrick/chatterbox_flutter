import 'dart:html';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_complete_guide/widgets/chat/message_bubble.dart';
import 'package:flutter_complete_guide/widgets/chat/new_message.dart';

class Messages extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
          future: FirebaseAuth.instance.currentUser(),
          builder:(ctx,futureSnapshot){ 
            if(futureSnapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            return 
    StreamBuilder(
      stream: Firestore.instance.collection('chats').orderBy("createdAt",descending: true).snapshots(),
      builder: (ctx, chatInfo) {
        if (chatInfo.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        final chatDocs = chatInfo.data.documents;
        
            return ListView.builder(
            reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (ctx, index) => MessageBubble(
                chatDocs[index]['text'],
                futureSnapshot.data.uid==chatDocs[index]['userId']?true:false,
                messageKey:ValueKey(chatDocs[index].documentId)
                )
                );
          },
        );
      },
    );
  }
}
