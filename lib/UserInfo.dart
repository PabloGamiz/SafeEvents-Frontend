//This page shows the information of a selected user

import 'package:flutter/material.dart';
import 'User.dart';

void main() =>
    runApp(UserInfo(User('Paco2', 'paco2@email.com', 'paco2thebest')));

class UserInfo extends StatelessWidget {
  User userToShow;

  UserInfo(this.userToShow);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('User Info'),
          ),
          body: Column(children: [
            Text('Name'),
            Text(userToShow.getUsername()),
            Text('Email'),
            Text(userToShow.email),
            Text('Verified'),
            if (userToShow.getVerified())
              Text('This user is verified')
            else
              Text('This user is not verified'),
            Text('Events'),
            Text('Here a list of events may be showed'),
          ])),
    );
  }
}
