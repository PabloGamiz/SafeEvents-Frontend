/*//This page shows the information of a selected user

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ClientInfo extends StatefulWidget {
  final String email;

  ClientInfo(this.email);

  _ClientInfoState createState() => _ClientInfoState(email);
}

class _ClientInfoState extends State<ClientInfo> {
  String email;

  _ClientInfoState(this.email);

  Future<Client> futureClient;

  @override
  void initState() {
    super.initState();
    futureClient = fetchClient(email);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Client>(
      future: futureClient,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return createClientWidget(snapshot);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

Future<Client> fetchClient(String email) async {
  var queryParameters = {'email': email};
  var uri = Uri.http('10.4.41.148:9090', '/clientInfo/', queryParameters);
  final response = await http.get(uri);
  if (response.statusCode == 200) {
    return Client.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}

class Client {
  final String clientname;
  final String email;
  final bool verified;
  final events;

  Client({this.clientname, this.email, this.verified, this.events});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      clientname: json['username'],
      email: json['email'],
      verified: json['verified'] == 'true',
      events: json['events'],
    );
  }
}

Widget createClientWidget(AsyncSnapshot<Client> snapshot) {
  return Scaffold(
    body: Column(children: [
      Text(
        'Username',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
      Text(snapshot.data.clientname),
      Text(
        'Email',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
      Text(snapshot.data.email),
      Text(
        'Verified',
        style: TextStyle(fontSize: 30),
        textAlign: TextAlign.center,
      ),
      if (snapshot.data.verified)
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
              title: Text(snapshot.data.events[index]['eventName']),
              subtitle: Text(snapshot.data.events[index]['Date']),
            );
          },
          itemCount: snapshot.data.events.length,
          shrinkWrap: true,
        ),
      ),
    ]),
  );
}

/*
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
  */
/*setUserInfo();
    if (!parsed)
      return Scaffold(
        body: Center(
          child: (Text('Parsing...')),
        ),
      );
    else
      return createWidget();*/

/*
_tancarSessio() async {
  print('5');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  print(stringValue);
  SignInModel session = await http_SignOut(stringValue);
  /*var now;
    do {
      session = await http_SignOut(stringValue);
      now = new DateTime.now();
    } while (!(session.cookie == stringValue) && (session.deadline < now));*/

  runApp(MaterialApp(
    home: SignIn(),
  ));
}

*/
*/

//This page shows the information of a selected user

import 'dart:io';

import 'package:flutter/material.dart';
import 'http_requests/http_clientInfo.dart';
import 'http_models/ClientInfoModel.dart';

/*
void main() => runApp(UserInfo('Paco', 'paco@gmail.com', false,
    ['kiko rivera concert', 'Getafe - Osasuna']));
*/

class ClientInfo extends StatefulWidget {
  final int id;

  ClientInfo(this.id);

  _ClientInfoState createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  Future<ClientInfoMod> futureClient;

  @override
  void initState() {
    super.initState();
    futureClient = fetchClient(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClientInfoMod>(
      future: futureClient,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //return createClientWidget(snapshot);
          return Text("ola k ase");
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

/*
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
  */
/*setUserInfo();
    if (!parsed)
      return Scaffold(
        body: Center(
          child: (Text('Parsing...')),
        ),
      );
    else
      return createWidget();*/
