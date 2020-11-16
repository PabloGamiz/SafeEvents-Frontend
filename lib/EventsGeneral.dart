import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:safeevents/http_requests/http_generalevents.dart';
import 'PublishEvents.dart';
import 'PublishEvents.dart';
import 'http_models/GeneralEventsModel.dart';
import 'http_requests/http_generalevents.dart';

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
  final _debouncer = Debouncer(milliseconds: 500);

  List likeds = List.filled(100, false);

  String _defaultValue;

  int counter = 0;

  List categories = [
    'Música',
    'Teatro',
    'Deporte',
    'Arte'
  ]; //nombre de las categorias

  /*List<Event> generalEvents = List();

  List<Event> filteredEvents = List();

  void initState() {
    super.initState();
    http_GeneralEvents().then((eventsFromServer) {
      setState(() {
        generalEvents = eventsFromServer;
        filteredEvents = generalEvents;
      });
    });
  }

  int sumadelpreu(Event e) {
    int suma = 0;
    for (Service s in e.services) {
      for (Product p in s.products) {
        suma = suma + p.price;
      }
    }
    return suma;
  }*/

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
          ),
          /*onChanged: (string) {
            _debouncer.run(() {
              setState(() {
                filteredEvents = generalEvents
                    .where((e) =>
                        (e.location.contains(string)))
                    .toList();
              });
            });
          },*/
        ),
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
         /* onChanged: (newValue) {
            _debouncer.run(() {
              setState(() {
                _defaultValue = newValue;
                filteredEvents = generalEvents
                          .where((e) => e.category.contains(newValue))
                          .toList();
              });
            });
          },*/
        ),
        SizedBox(
          height: 5,
        ),
        Expanded(
          child: ListView.builder(
            itemCount: 15, /*filteredEvents.length,*/
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 1.0,
                  horizontal: 4.0,
                ),
                child: Card(
                  color: Colors.lightBlue,
                  child: ListTile(
                    onTap: () {
                      _esdevenimentEspecific();
                    },
                    title: Column(
                      children: [
                        Container(
                          height: 30,
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: IconButton(
                              icon: Icon(
                                likeds[index]
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: likeds[index] ? Colors.red : Colors.grey,
                              ),
                              onPressed: () => setState(() {
                                likeds[index] = !likeds[index];
                              }),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child:  Text(
                              'KIKO RIVERA ON CONCERT', /*filteredEvents[index].title,*/
                              style:
                                  TextStyle(fontSize: 24, color: Colors.white),
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
                          child: Text(
                            '45€', /*sumadelpreu(filteredEvents[index]).toString(),*/
                            style: TextStyle(fontSize: 40, color: Colors.white)
                          ),
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
                                    'Palau Sant Jordi', /*filteredEvents[index].location.name,*/
                                    style: TextStyle(color: Colors.white),
                                    maxLines: 2,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                              ),
                              Container(
                                height: 5,
                              ),
                              Text(
                                  '25/10/2020, 19:50', /*filteredEvents[index].date.toString(),*/
                                  style: TextStyle(color: Colors.white)),
                              Container(
                                height: 5,
                              ),
                              Text('Música', //filteredEvents[index].category,
                                  style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            shrinkWrap: true,
          ),
        ),
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _publishEsdeveniment();
        },
        tooltip: 'Publish event',
        child: Icon(
          Icons.add,
        ),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
    ));
  }

  _publishEsdeveniment() {
    runApp(MaterialApp(
      home: Publish(),
    ));
  }

  _esdevenimentEspecific() {
    runApp(MaterialApp(
      home: Mostra(),
    ));
  }
}
