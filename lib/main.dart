import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:safeevents/SignIn.dart';
import 'package:safeevents/chatgeneral_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: ChatGeneralScreen(),
  ));
}
