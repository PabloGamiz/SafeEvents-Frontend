import 'package:flutter/material.dart';

class EventsGeneral extends StatelessWidget {
  var _categories = [
    'Música',
    'Teatro',
    'Deporte',
    'Arte'
  ]; //nombre de las categorias

  void ImprimirTexto() {
    print('texto');
  }
  /* @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  void getEventsFiltrats() {
    //Pedir la lista de eventos que tienen que salir para el filtro que se pasa
  }

  void getEvents() {
    //Pedir la lista de todos los eventos que se tienen que mostrar
  }

  EventsGeneral()*/

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
            ImprimirTexto();
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
                itemCount: /*tamaño array de items*/,
                itemBuilder: (context, position) {
                  return RaisedButton(
                    onPressed: /*hacer que habra la consulta especifica del evento*/,
                    )
                })*/
    ])));
  }
}
