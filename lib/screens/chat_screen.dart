import 'package:chat_app_flutter/widgets/chats/messages.dart';
import 'package:chat_app_flutter/widgets/chats/new_message.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
        actions: [
           PopupMenuButton( icon: const Icon(Icons.more_vert),
                itemBuilder: (ctx)=>[
              PopupMenuItem(child: Text('Logout'),
               onTap: (){
               
               },
             ),
           ]
           ),
        ],
      ),
      body: Column(
        children: const [
          Expanded(child: Messages()),
          NewMessage()
        ],
      )
    );

  }
}
