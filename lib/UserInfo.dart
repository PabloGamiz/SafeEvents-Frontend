//This page shows the information of a selected user

import 'package:flutter/material.dart';

void main() => runApp(UserInfo());

class UserInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('User Info'),
          ),
          body: Column(children: [
            Text('Name'),
            Text('Here goes the user\'s name'),
            Text('Email'),
            Text('Here goes the user\'s email'),
            Text('Verified'),
            Text('Here goes a mask whether if the user is verified or not'),
            Text('Events'),
            Text('Here a list of events may be showed'),
          ])),
    );
  }
}
