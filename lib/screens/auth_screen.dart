 
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:chat_app_flutter/widgets/auth/auth_screen.dart' as auth_wigit;
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthandForm(String email , String password , String username , bool isLogin)
  async
  {
    try
    {
      setState(() {
        _isLoading = true;
      });
      if(isLogin)
      {
        UserCredential userCredential  =  await _auth.signInWithEmailAndPassword(email: email, password: password) ;
      }
      else
      {
        UserCredential userCredential  =  await _auth.createUserWithEmailAndPassword(email: email, password: password) ;
        CollectionReference collectionReference = FirebaseFirestore.instance.collection('users').
        doc(userCredential.credential?.providerId).set({
          'username' : username ,
          'password' : password  ,
          'email' :  email
        }) as CollectionReference<Object?>;


      }
    } on PlatformException catch(err)
    {
      setState(() {
        _isLoading = false;
      });
      var message  = 'Check your Credentials ';
      if(err.message!=null)
        {
          message = err.message.toString();
        }
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message),
      backgroundColor: Theme.of(context).errorColor,)
      );
    } catch(error)
    {
      setState(() {
        _isLoading = false;
      });
      print(error.toString());
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body:  auth_wigit.AuthScreen(_submitAuthandForm,_isLoading)
      );
  }
}
