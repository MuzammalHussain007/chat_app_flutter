import 'dart:io';

import 'package:chat_app_flutter/picker/user_image_picker.dart';
import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
   final void Function(String email , String password , String username , bool isLogin) submit;
   bool _isLoading;
  AuthScreen(this.submit,this._isLoading);

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final formKey = GlobalKey<FormState>();
  var isLogin = true;
  var _email = '';
  var _password = '';
  var _username = '';

  File _file = File("");

  void _pickedImage(File image)
  {
    _file = image ;
  }

  void _saveForm(){
    if(formKey.currentState!.validate())
      {
        if(_file!=null &&!isLogin)
          {
            formKey.currentState!.save();
            widget.submit(_email , _password , _username ,isLogin );
            print('Data is Saved...');
            FocusScope.of(context).unfocus();
          }
        else
          {
            Scaffold.of(context).showSnackBar(SnackBar(
              backgroundColor: Theme.of(context).errorColor,
                content: Text('Please Pick an Image')));
          }

      }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
            padding: const EdgeInsets.all(18.0),
            child: Form(
              key: formKey,
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if(!isLogin)UserImagePicker(_pickedImage),
                TextFormField(
                  key: ValueKey('email'),
                  validator: (value) {
                    if (validateEmail(value)) {
                      return 'Enter a valid email Address';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (value){
                    _email = value.toString();

                  },
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(label: Text('Email Here ')),
                ),
                if(!isLogin)
                TextFormField(
                  key: ValueKey('Username'),
                  onSaved: (value){
                   _username = value.toString();
                  },
                  validator: (value){
                    if(validateUserName(value)){
                      return 'user Name should be 4 characeter long';
                    }else
                      {
                        return null;
                      }
                  },
                  decoration:
                      const InputDecoration(label: Text('User Name Here')),
                ),
                TextFormField(
                  key: ValueKey('password'),
                  onSaved: (value){
                   _password = value.toString();
                  },
                  validator: (value){
                    if(validatePassword(value)){
                      return 'Password Should be atleast 7';
                    }else
                      {
                        return null;
                      }
                  },
                  decoration: const InputDecoration(
                    label: Text('Password Here '),
                  ),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 14,
                ),
                if(widget._isLoading)
                  CircularProgressIndicator(),
                if(!widget._isLoading)
                RaisedButton(
                  onPressed: ()=>_saveForm(),
                  child:  Text(isLogin ? 'Login Here' : 'SignUp Here'),
                ),
                if(!widget._isLoading)
                FlatButton(
                  onPressed: () {
                    setState(() {
                      isLogin = !isLogin;
                    });
                  },
                  child:  Text(isLogin ? 'Create New Account'  :'Already Have an Account!' ),
                  textColor: Theme.of(context).primaryColor,
                )
              ],
            ))),
      ),
    );
  }
}

bool validateEmail(String? value) {
  if (value.toString().isEmpty && value.toString().contains("@")) {
    return true;
  } else {
    return false;
  }
}

bool validatePassword(var value) {
  if (value
      .toString()
      .isEmpty && value.length < 7) {
    return true;
  } else {
    return false;
  }
}

bool validateUserName(var value) {
  if (value
      .toString()
      .isEmpty && value.length<4) {
    return true;
  } else {
    return false;
  }
}
