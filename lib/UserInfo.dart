//This page shows the information of a selected user

import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:flutter/services.dart';

/*
void main() => runApp(UserInfo('Paco', 'paco@gmail.com', false,
    ['kiko rivera concert', 'Getafe - Osasuna']));
*/

class UserInfo extends StatefulWidget {
  String email;

  UserInfo(this.email);

  _UserInfoState createState() => _UserInfoState(email);
}

class _UserInfoState extends State<UserInfo> {
  String username;
  String email;
  bool verified = false;
  var events;

  _UserInfoState(this.email);

  bool parsed = false;

  void setUserInfo() async {
    //var user = Request.Get(URI).addheader("email", email).execute().returnContent());
    String user = await rootBundle.loadString("assets/userTest.json");
    var showData = json.decode(user.toString());
    this.username = showData['username'];
    this.verified = showData['verified'] == 'true';
    this.events = showData['events'];
    setState(() {
      parsed = true;
    });
  }

  Widget createWidget() {
    return Scaffold(
      body: Column(children: [
        Text(
          'Username',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        Text(username),
        Text(
          'Email',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        Text(email),
        Text(
          'Verified',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        if (verified)
          Text('This user is verified')
        else
          Text('This user is not verified'),
        Text(
          'Events',
          style: TextStyle(fontSize: 30),
          textAlign: TextAlign.center,
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(events[index]['eventName']),
                subtitle: Text(events[index]['Date']),
              );
            },
            itemCount: events.length,
            shrinkWrap: true,
          ),
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    setUserInfo();

    if (!parsed)
      return Scaffold(
        body: Center(
          child: (Text('Parsing...')),
        ),
      );
    else
      return createWidget();
  }
}
