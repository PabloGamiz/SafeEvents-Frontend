/*import 'package:flutter/material.dart';
import 'package:safeevents/reserves.dart';
import 'package:safeevents/venda.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_models/SignIn_model.dart';
import 'http_requests/http_signout.dart';

class PantallaPrincipal extends StatefulWidget {
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign-In Demo'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Boton que no hace nada',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            onPressed: () => print('boton presinado'),
            color: Colors.lightBlue,
          ),
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () =>
                    _tancarSessio() /*llama a estructura, para que depues esta muestre eventos general*/,
                child: Text(
                  'Tancar sessió',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () =>
                    _vendaEntrades() /*llama a estructura, para que depues esta muestre eventos general*/,
                child: Text(
                  'Venda entrades',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () =>
                    _reserva() /*llama a estructura, para que depues esta muestre eventos general*/,
                child: Text(
                  'Reserva',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  _tancarSessio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    print(stringValue);
    SignInModel session = await http_SignOut(stringValue);
    /*var now;
    do {
      session = await http_SignOut(stringValue);
      now = new DateTime.now();
    } while (!(session.cookie == stringValue) && (session.deadline < now));*/
  }

  _vendaEntrades() {
    runApp(MaterialApp(
      home: Venda(),
    ));
  }

  _reserva() {
    runApp(MaterialApp(
      home: Reserves(),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:safeevents/ClientInfo.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EventsGeneral.dart';
import 'no_login.dart';

class Structure extends StatefulWidget {
  @override
  _StructureState createState() => _StructureState();
}

class _StructureState extends State<Structure> {
  bool registered = true;

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  static List<Widget> _widgetOptionsIfRegistered = <Widget>[
    EventsGeneral(),
    Text(
      'Index 1: Map',
      style: optionStyle,
    ),
    Text(
      'Index 1: Map',
      style: optionStyle,
    ),
    ClientInfo('paco@gmail.com')
  ];

  static List<Widget> _widgetOptionsIfNotRegistered = <Widget>[
    EventsGeneral(),
    Text(
      'Index 1: Map',
      style: optionStyle,
    ),
    Nologin(),
    Nologin(),
  ];

  bool register = false;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  comprovarSessio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    if (stringValue != null)
      register = true;
    else
      register = false;
  }

  @override
  Widget build(BuildContext context) {
    comprovarSessio();
    if (register) {
      return Scaffold(
        appBar: AppBar(
          title: Text("SafEƎventS"),
        ),
        body: Center(
          child: _widgetOptionsIfRegistered.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Events',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.maps_ugc),
              label: 'Map',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.blueGrey,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("SafEƎventS"),
        ),
        body: Center(
          child: _widgetOptionsIfNotRegistered.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.emoji_events),
              label: 'Events',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.maps_ugc),
              label: 'Map',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              label: 'Chats',
              backgroundColor: Colors.blueGrey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.blueGrey,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blueAccent,
          onTap: _onItemTapped,
        ),
      );
    }
  }
}

*/
