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
  bool registered = false;

  int _selectedIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black);

  comprovarSessio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    if (stringValue != null)
      registered = true;
    else
      registered = false;
  }

  static List<Widget> _widgetOptionsIfRegistered = <Widget>[
    EventsGeneral(),
    Text(
      'Index 1: Favourites',
      style: optionStyle,
    ),
    Text(
      'Index 1: Map',
      style: optionStyle,
    ),
    Text(
      'Xat 1: Map',
      style: optionStyle,
    ),
    ClientInfo('paco@gmail.com')
  ];

  static List<Widget> _widgetOptionsIfNotRegistered = <Widget>[
    EventsGeneral(),
    Text(
      'Index 1: Favourites',
      style: optionStyle,
    ),
    Text(
      'Index 1: Map',
      style: optionStyle,
    ),
    Nologin(),
    Nologin(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    comprovarSessio();
    if (registered) {
      return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 55,
            child: Center(
              child: Image(
                image: AssetImage('assets/SafeEventsBlack.png'),
              ),
            ),
          ),
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
              icon: Icon(Icons.star),
              label: 'Favourites',
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
          title: Container(
            height: 40,
            child: Center(
              child: Image(
                image: AssetImage('assets/SafeEventsBlack.png'),
              ),
            ),
          ),
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
              icon: Icon(Icons.star),
              label: 'Favourites',
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
