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

*/

//This page shows the information of a selected user

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safeevents/SignIn.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_models/SignIn_model.dart';
import 'http_requests/http_clientInfo.dart';
import 'http_models/ClientInfoModel.dart';
import 'http_requests/http_signout.dart';

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
  var dropdownValue = "Reservas";
  List<Purchased> selected = new List();

  @override
  void initState() {
    super.initState();
    futureClient = fetchLocalClient(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClientInfoMod>(
      future: futureClient,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (widget.id == 0)
            return buildProfileWidget(snapshot);
          else
            return buildClientInfoWidget(snapshot);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildProfileWidget(AsyncSnapshot<ClientInfoMod> snapshot) {
    var client = snapshot.data;
    var assistant = client.assists;
    var organizer = client.organize;
    selected = _selectTicket(dropdownValue, assistant);
    return Column(
      children: [
        generalInfo(client),
        DropdownButton(
          value: dropdownValue,
          elevation: 16,
          items: ["Reservas", "Entradas", "Eventos organizados"]
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          style: TextStyle(color: Colors.lightBlue),
          underline: Container(
            height: 2,
            color: Colors.lightBlue,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              if (dropdownValue != "Eventos organizados")
                selected = _selectTicket(dropdownValue, assistant);
            });
          },
        ),
        if (dropdownValue != "Eventos organizados")
          _ticketsList()
        else
          _eventsList(organizer)
      ],
    );
  }

  Widget _ticketsList() {
    if (selected.length != 0)
      return Expanded(
        child: ListView(
          children: selected.map(_buildTicketWidget).toList(),
          shrinkWrap: true,
        ),
      );
    else
      return Text("No tienes " + dropdownValue);
  }

  Widget _eventsList(Organize organizer) {
    if (organizer.organizes.length != 0)
      return Expanded(
        child: ListView(
          children: organizer.organizes.map(_buildEventWidget).toList(),
          shrinkWrap: true,
        ),
      );
    else
      return Expanded(
        child: Text("No organiza ningun evento"),
      );
  }

  Widget buildClientInfoWidget(AsyncSnapshot<ClientInfoMod> snapshot) {
    var client = snapshot.data;
    var organizer = client.organize;
    return Column(
      children: [
        generalInfo(client),
        Text("Eventos organizados"),
        if (organizer.organizes.length != 0)
          Expanded(
            child: ListView(
              children: organizer.organizes.map(_buildEventWidget).toList(),
              shrinkWrap: true,
            ),
          )
        else
          Expanded(
            child: Text("No organiza ningun evento"),
          ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget generalInfo(client) {
    return Card(
      color: Colors.lightBlue,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                'Email:',
              ),
              Text(
                client.email,
              ),
              if (widget.id == 0)
                FlatButton(
                  onPressed: null,
                  child: Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                ),
              if (widget.id == 0)
                FlatButton(
                  onPressed: () => _tancarSessio(),
                  child: Icon(
                    Icons.logout,
                    color: Colors.white,
                  ),
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          )
        ],
      ),
    );
  }

  Widget _buildEventWidget(Fav event) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 4.0,
      ),
      child: Card(
        color: Colors.lightBlue,
        child: ListTile(
          onTap: () {
            //_esdevenimentEspecific();
          },
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  event.title,
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          subtitle: Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: Text(event.price.toString() + '€',
                    style: TextStyle(fontSize: 40, color: Colors.white)),
              ),
              Expanded(
                //color: Colors.red,
                //height: 80,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                      child: Container(
                        child: Text(
                          event.location,
                          /*filteredEvents[index].location.name,*/
                          style: TextStyle(color: Colors.white),
                          maxLines: 2,
                          overflow: TextOverflow.fade,
                        ),
                      ),
                    ),
                    Container(
                      height: 5,
                    ),
                    Text(event.closureDate.toString(),
                        style: TextStyle(color: Colors.white)),
                    Container(
                      height: 5,
                    ),
                    Text(event.tipus, //filteredEvents[index].category,
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketWidget(Purchased purchase) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 4.0,
      ),
      child: Card(
        color: Colors.lightBlue,
        child: ListTile(
          onTap: () {
            //_esdevenimentEspecific();
          },
          title: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  purchase.id.toString(),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                  maxLines: 2,
                  overflow: TextOverflow.fade,
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
          subtitle: Row(
            children: [
              SizedBox(
                width: 25,
              ),
              Expanded(
                child: Text(purchase.description.toString(),
                    style: TextStyle(fontSize: 40, color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Purchased> _selectTicket(String type, Assists assistant) {
    selected.clear();
    if (type == "Reservas") {
      if (assistant.purchased.length != 0) {
        for (int i = 0; i < assistant.purchased.length; ++i) {
          if (assistant.purchased[i].option == 0) {
            selected.add(assistant.purchased[i]);
          }
        }
      }
    } else if (type == "Entradas") {
      if (assistant.purchased.length != 0) {
        for (int i = 0; i < assistant.purchased.length; ++i) {
          if (assistant.purchased[i].option == 1) {
            selected.add(assistant.purchased[i]);
          }
        }
      }
    }
    return selected;
  }

  _tancarSessio() async {
    print('cerrar session');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    print(stringValue);
    SignInModel session = await http_SignOut(stringValue);
    /*var now;
    do {
      session = await http_SignOut(stringValue);
      now = new DateTime.now();
    } while (!(session.cookie == stringValue) && (session.deadline < now));*/
    prefs.setString('cookie', null);
    runApp(MaterialApp(
      home: SignIn(),
    ));
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
