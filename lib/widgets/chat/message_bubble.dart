import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Key messageKey;
  final String username;
  final String userId;
 String imgurl;
  NetworkImage img;
  MessageBubble(this.message, this.username,this.userId, this.isCurrentUser,
      {this.messageKey});
 getUserImage()async {
   print("User Id: ${userId}");
final usr = await Firestore.instance.collection('users').where('userId',isEqualTo: userId).getDocuments();
List<Map<String, dynamic>> list = 
  usr.documents.map((DocumentSnapshot doc){
  return doc.data;
}).toList();

imgurl = list[0]['img_url'];
print(list);
// print("Usr info: ${list[0]}");
// print("Image Url: ${imgurl}");
// img =  NetworkImage(imgurl);
}
  @override
  Widget build(BuildContext context) {
    // print('Img Url: ${img_url}');
    getUserImage();
    return Row(
      mainAxisAlignment:
          isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.all(5),
          width: 140,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
                bottomLeft:
                    isCurrentUser ? Radius.circular(10) : Radius.circular(0),
                bottomRight:
                    isCurrentUser ? Radius.circular(0) : Radius.circular(10)),
            color: isCurrentUser ? Theme.of(context).accentColor : Colors.green,
          ),
          child: Row(
            children: [
             
              FutureBuilder
              ( 
                future: Firestore.instance.collection('users').where('userId',isEqualTo: userId).getDocuments(),
                builder: (ctx,usersInfoSnapshot){
                  if(usersInfoSnapshot.connectionState==ConnectionState.waiting){
                    return CircleAvatar(backgroundColor: Colors.grey,);
                  }
                  List list = 
                  usersInfoSnapshot.data.documents.map((DocumentSnapshot doc){
                            return doc.data;
                    }).toList();

                    imgurl = list[0]['img_url'];
                    return  CircleAvatar(backgroundImage: NetworkImage(imgurl));
                }),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                ),
                Text(
                  message,
                  style: TextStyle(color: Colors.white),
                )
              ])
            ],
          ),
        ),
      ],
    );
  }
}
