import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat Screen'),
      ),
      body:StreamBuilder(builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting)
          {
           return const Center(
             child: CircularProgressIndicator(
             ),
           );
          }
        final data = snapshot.requireData;
        return ListView.builder(
            itemCount: data.size,
            itemBuilder: (ctx,i)=>const Text('This is chat'));
      },
        stream:FirebaseFirestore.instance.collection(  'chats/U61L3MlX0YGoGj90uUDo/messages')
          .snapshots(),),
    );

  }
}
