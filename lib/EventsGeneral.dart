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
  State<StatefulWidget> createState() {
    // TODO: implement createState
    _StateEvents();
  }
}

class _StateEvents extends State {
  /*OBTENER LISTA DE EVENTOS*/
  final debouncer = Debouncer(milliseconds: 500);
  var _categories = [
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
      TextFormField(
          decoration: InputDecoration(
        labelText: "Cercar ciutat",
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25.0),
          borderSide: BorderSide(),
        ),
      )),
      Row(children: <Widget>[
        DropdownButton<String>(
          items: _categories.map((String dropDownStringItem) {
            return DropdownMenuItem<String>(
              value: dropDownStringItem,
              child: Text(dropDownStringItem),
            );
          }).toList(),
          onChanged: () {
            debouncer.run() {
              setState() { /*mostrar los eventos filtrados por el tipo de evento escogido*/}
            }
          },
        ),
        IconButton(
          onPressed: /*Funcion que muestra la lista de eventos filtrados*/ ImprimirTexto(),
          icon: Image.asset(
            'assets/Filtrar.png',
            height: 30,
            alignment: Alignment.center,
          ),
          color: Colors.black,
          splashColor: Colors.grey,
          focusColor: Colors.grey,
          highlightColor: Colors.grey,
        )
      ]),
      /*ListView.builder(
          itemCount: GeneralEvents.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const  EndeInsets.symmetric(
                vertical: 1.0, horizontal: 4.0,
              ),
              child: Card(
                child: ListTile(
                  onTap: () {
                    /*mostrar la ventana de info de evento especifico*/
                  },
                  title: /*primera linea*/,
                  subtitle: /*segunda linea*/,
                  isThreeLine: /*tercera linea*/,
                )
              ),
            );
          }
        )*/
    ])));
  }
}
