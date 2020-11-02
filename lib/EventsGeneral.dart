import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class EventsGeneral extends StatefulWidget {
  @override
  _GeneralEventsState createState() => _GeneralEventsState();
}

class _GeneralEventsState extends State {
  /*OBTENER LISTA DE EVENTOS*/
  final debouncer = Debouncer(milliseconds: 500);
  String _defaultValue;
  List categories = [
    'Música',
    'Teatro',
    'Deporte',
    'Arte'
  ]; //nombre de las categorias

  void getEventsFiltrats() {
    //Pedir la lista de eventos que tienen que salir para el filtro que se pasa
  }

  void getEvents() {
    //Pedir la lista de todos los eventos que se tienen que mostrar
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: Column(children: <Widget>[
      SizedBox(
        height: 10,
      ),
      TextFormField(
          decoration: InputDecoration(
        labelText: "Cercar ciutat",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
      )),
      SizedBox(
        height: 10,
      ),
      DropdownButton<String>(
        hint: Text('Select category'),
        value: _defaultValue,
        items: categories.map((newValue) {
          return DropdownMenuItem<String>(
            value: newValue,
            child: Text(newValue),
          );
        }).toList(),
        onChanged: (newValue) {
          setState(() {
            _defaultValue = newValue;
          });
        },
      ),
      SizedBox(
        height: 10,
      ),
      Expanded(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 1.0,
                horizontal: 4.0,
              ),
              child: Card(
                color: Colors.lightBlue,
                child: ListTile(
                  title: Row(
                    children: [
                      Text('Kiko rivera',
                          style: TextStyle(fontSize: 24, color: Colors.white)),
                      SizedBox(
                        width: 40,
                      ),
                      Text('Palau Sant Jordi, Barcelona',
                          style: TextStyle(fontSize: 15, color: Colors.white)),
                    ],
                  ),
                  subtitle: Row(
                    children: [
                      SizedBox(
                        width: 20,
                      ),
                      Text('45 €',
                          style: TextStyle(fontSize: 40, color: Colors.white)),
                      SizedBox(
                        width: 130,
                      ),
                      Column(
                        children: [
                          Text('Fecha', style: TextStyle(color: Colors.white)),
                          Text(categories[1],
                              style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
          itemCount: 10,
          shrinkWrap: true,
        ),
      ),
    ])));
  }
}
