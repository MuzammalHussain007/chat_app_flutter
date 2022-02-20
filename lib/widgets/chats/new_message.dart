import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  var _eneterMessage = '';
  final _controller = TextEditingController();

  void _sendMessage()async{
  //  FocusScope.of(context).unfocus();
     ;
    FirebaseFirestore.instance.collection('chat').add({
      'text':_eneterMessage,
      'createdAt':Timestamp.now(),
      'userid' : FirebaseAuth.instance.currentUser!.uid.toString()
    });
    _controller.clear();

  }
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children:   [
             Expanded(
            child: TextField(
              controller: _controller,
              onChanged: (value){
                setState(() {
                  _eneterMessage = value;

                });
              },
              decoration: const InputDecoration(
                labelText: 'Send Your Message'
              ),

            ),
          ),
          IconButton(
             color: Theme.of(context).primaryColor,
              onPressed:_eneterMessage.trim().isEmpty ? null : ()=>_sendMessage()
              , icon:const Icon(Icons.send))
        ],
      ),
    );
  }
}
