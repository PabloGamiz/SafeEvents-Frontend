import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:safeevents/SignIn.dart';
import 'package:safeevents/chatgeneral_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Structure.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  if (stringValue == null) {
    runApp(MaterialApp(
      home: SignIn(),
    ));
  } else {
    runApp(MaterialApp(
      home: Structure(),
    ));
  }
}
