import 'package:chat_app_flutter/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
    Firebase.initializeApp( );
  runApp(const HomeScreen());
}

