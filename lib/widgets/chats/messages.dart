import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(
                child: CircularProgressIndicator(
                  color:Colors.pink ,
                ),
              );
        }

         return FutureBuilder(
           future: FirebaseAuth.instance.currentUser.uid,
             builder:(ctx,futureSnapeShot){
           if(futureSnapeShot.connectionState==ConnectionState.waiting)
             {
              return const Center(
                child: CircularProgressIndicator(),
              );
             }
           return  ListView.builder(itemBuilder: (ctx, i){
             DocumentSnapshot course = snapshot.data.docs[i];
             return MessageBubble(course['text']);
           },
             reverse: true,
             itemCount: snapshot.requireData.size,
           );
         } );

      },
      stream: FirebaseFirestore.instance.collection('chat').orderBy('createdAt',descending: true).snapshots(),
    );
  }
}
