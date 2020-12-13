import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:safeevents/http_requests/http_esdevenimentsrecomanats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PublishEvents.dart';
import 'PublishEvents.dart';
import 'http_models/GeneralEventsModel.dart';
import 'http_models/GeneralEventsModel.dart';
import 'http_models/GeneralEventsModel.dart';

void main() => runApp(MaterialApp(
  title: "EsdevenimentsRecomanats",
  home: EsdevenimentsRecomanats(),
));

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

class EsdevenimentsRecomanats extends StatefulWidget {
  @override
  _EsdevenimentsRecomanatsState createState() => _EsdevenimentsRecomanatsState();
}

class _EsdevenimentsRecomanatsState extends State {
  /*OBTENER LISTA DE EVENTOS*/
  final _debouncer = Debouncer(milliseconds: 500);
  String cookie = "";

  bool registered = false;

  _comprovarSessio() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    cookie = stringValue;
    if (stringValue != null)
      registered = true;
    else
      registered = false;
  }

  List likeds = List.filled(100, false);

  String _defaultValue;

  int counter = 0;

  List categories = [
    ' ',
    'Música',
    'Teatro',
    'Deporte',
    'Arte'
  ]; //nombre de las categorias

  List<ListEsdevenimentsModel> generalEvents = List();

  List<ListEsdevenimentsModel> filteredEvents = List();

  void initState() {
    super.initState();
    _comprovarSessio();
    http_esdevenimentsrecomanats(cookie).then((eventsFromServer) {
      setState(() {
        generalEvents = eventsFromServer;
        filteredEvents = generalEvents;
      });
    });/*
    final list = new List<ListEsdevenimentsModel>();
    Controller c = new Controller();

    c.id = 20;
    c.title = 'Esdeveniment';
    c.description = 'Kiko Rivera on tour';
    c.capacity = 200;
    c.checkInDate = DateTime(20-10-2020);
    c.price = 20;
    c.services = ['Música'];
    c.location = new Location();
    c.location.name = 'Palau Sant Jordi';
    ListEsdevenimentsModel liste = new ListEsdevenimentsModel();
    liste.controller = c;
    List<ListEsdevenimentsModel> lModel = new List<ListEsdevenimentsModel>();
    lModel.add(liste);



    setState(() {
      generalEvents = lModel;
      filteredEvents = generalEvents;
    });*/
    print('LLISTA : '+generalEvents.toString());
  }
/*
  int sumadelpreu(ListEsdevenimentsModel l) {
    int suma = 0;
    for (Service s in l.controller.services) {
      for (Product p in s.products) {
        suma = suma + p.price;
      }
    }
    return suma;
  }*/

  Widget build(BuildContext context) {
    if (registered /*&& filteredEvents.length > 0*/) {
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
                onChanged: (string) {
                  _debouncer.run(() {
                    setState(() {
                      filteredEvents = generalEvents
                          .where(
                              (e) => (e.location.contains(string)))
                          .toList();
                    });
                  });
                },
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
                onChanged: (newValue) {
                  _debouncer.run(() {
                    setState(() {
                      _defaultValue = newValue;
                      /*filteredEvents = generalEvents
                            .where((e) => e.category.contains(newValue))
                            .toList();*/
                    });
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 3, //filteredEvents.length,
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
                                          : Icons.favorite,
                                      color:
                                      likeds[index] ? Colors.red : Colors.white,
                                    ),
                                    onPressed: () => setState(() {
                                      likeds[index] = !likeds[index];
                                    }),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  /*'KIKO RIVERA ON CONCERT',*/
                                  filteredEvents[index].title,
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
                                child: Text('45€',
                                    /*sumadelpreu(filteredEvents[index]).toString(),*/
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white)),
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
                                          /*'Palau Sant Jordi',*/
                                          filteredEvents[index].location
                                              ,
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
                                      /*'25/10/2020, 19:50',*/
                                        filteredEvents[index]

                                            .closureDate
                                            .toString(),
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
    } else if (!registered && ( filteredEvents != null && filteredEvents.length > 0) ) {
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
                onChanged: (string) {
                  _debouncer.run(() {
                    setState(() {
                      filteredEvents = generalEvents
                          .where(
                              (e) => (e.location.contains(string)))
                          .toList();
                    });
                  });
                },
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
                onChanged: (newValue) {
                  _debouncer.run(() {
                    setState(() {
                      _defaultValue = newValue;
                      /*filteredEvents = generalEvents
                          .where((e) => e.category.contains(newValue))
                          .toList();*/
                    });
                  });
                },
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredEvents == null ? 0: filteredEvents.length  ,
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
                              Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  /*'KIKO RIVERA ON CONCERT',*/
                                  filteredEvents[index].title,
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
                                child: Text('45€',
                                    /*sumadelpreu(filteredEvents[index]).toString(),*/
                                    style: TextStyle(
                                        fontSize: 40, color: Colors.white)),
                              ),
                              Expanded(
                                //color: Colors.red,
                                //height: 80,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Center(
                                      child: Container(
                                        child:
                                        Text(
                                          /*'Palau Sant Jordi',*/
                                          filteredEvents[index]
                                                                                            .location
                                              ,
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
                                      /*'25/10/2020, 19:50',*/
                                        filteredEvents[index]

                                            .closureDate
                                            .toString(),
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
          ));
    } else {
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
                  onChanged: (string) {
                    _debouncer.run(() {
                      setState(() {
                        filteredEvents = generalEvents
                            .where((e) => (e.location.contains(string)))
                            .toList();
                      });
                    });
                  },
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
                  onChanged: (newValue) {
                    _debouncer.run(() {
                      setState(() {
                        _defaultValue = newValue;
                      });
                    });
                  },
                ),
                SizedBox(
                  height: 180,
                ),
                Expanded(
                  child: Text(
                    'No event matching with the location or category indicated',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                )
              ])));
    }
  }

  _publishEsdeveniment() {
    runApp(MaterialApp(
      home: Publish(),
    ));
  }

  _esdevenimentEspecific() {
    runApp(MaterialApp(
      home: Mostra(idevent:20),
    ));
  }
}
