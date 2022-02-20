import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
    String message;
   MessageBubble(this.message);
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
    Container(
    decoration: BoxDecoration(
    color: Theme.of(context).accentColor,
    borderRadius: BorderRadius.circular(12.0),
    ),
    width: 150,
    padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 14),
    margin: const EdgeInsets.symmetric(vertical: 4.0,horizontal: 8.0),
    child: Text(message,style: TextStyle(color: Theme.of(context).textTheme.labelLarge?.color),),
    )
      ],
    );
  }
}
