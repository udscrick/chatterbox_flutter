import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  final Key messageKey;
  MessageBubble(this.message,this.isCurrentUser,{this.messageKey});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:isCurrentUser?MainAxisAlignment.end: MainAxisAlignment.start,
      children: [Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: isCurrentUser?Radius.circular(10):Radius.circular(0),
            bottomRight: isCurrentUser?Radius.circular(0):Radius.circular(10)

          ),
          color: isCurrentUser? Theme.of(context).accentColor:Colors.green,
          
        ),
        child: Text(message,style: TextStyle(color: Colors.white),),
      )],
    );
  }
}
