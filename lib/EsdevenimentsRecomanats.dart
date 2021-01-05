import 'dart:async';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:safeevents/http_requests/http_esdevenimentsrecomanats.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PublishEvents.dart';
import 'PublishEvents.dart';
import 'http_models/FavsModel.dart';
import 'http_models/GeneralEventsModel.dart';
import 'http_models/GeneralEventsModel.dart';
import 'http_models/GeneralEventsModel.dart';
import 'http_requests/http_addfavourite.dart';
import 'http_requests/http_delfavourite.dart';
import 'http_requests/http_favs.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() => runApp(MaterialApp(
      title: "EsdevenimentsRecomanats",
      home: EsdevenimentsRecomanats(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
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
  final _debouncer = Debouncer(milliseconds: 500);
  @override
  _EsdevenimentsRecomanatsState createState() =>
      _EsdevenimentsRecomanatsState();
}

class _EsdevenimentsRecomanatsState extends State {
  bool _esperaCarrega = true;
  /*OBTENER LISTA DE EVENTOS*/
  final _debouncer = Debouncer(milliseconds: 500);
  String cookie = "";

  bool registered = false;

  List likeds = List.filled(100, false);

  String _defaultValue;

  int counter = 0;

  List categories = [
    ' ',
    'Música',
    'Teatre',
    'Esport',
    'Art',
    'Altres'
  ]; //nombre de las categorias
  bool liked(int id) {
    if (favs != null) {
      for (int i = 0; i < favs.length; ++i) {
        if (favs[i].id == id) return true;
      }
    }
    return false;
  }

  List<ListEsdevenimentsModel> generalEvents = List();
  List<FavsModel> favs;
  List<ListEsdevenimentsModel> filteredEvents = List();
  _comprovarSessio() async {
    await SharedPreferences.getInstance().then((value) {
      cookie = value.getString('cookie');
    });
    print('COOKIE11111: ' + cookie);

    if (cookie != null)
      registered = true;
    else
      registered = false;

    http_esdevenimentsrecomanats(cookie).then((eventsFromServer) {
      setState(() {
        if (eventsFromServer.isNotEmpty) _esperaCarrega = false;
        generalEvents = eventsFromServer;
        filteredEvents = generalEvents;

        print('Llista desd_: ' + filteredEvents.toString());
      });
    });
  }

  void initState() {
    _comprovarSessio();
    super.initState();
    /*
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
    print('LLISTA : ' + generalEvents.toString());
  }

  Widget build(BuildContext context) {
    http_Favs().then((favourites) {
      setState(() {
        if (favourites == null)
          favs = List();
        else
          favs = favourites;
      });
    });
    if (registered /*&& filteredEvents.length > 0*/) {
      return MaterialApp(
        home: Scaffold(
          body: _esperaCarrega
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Column(children: <Widget>[
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
                      itemCount: filteredEvents == null
                          ? 0
                          : filteredEvents.length, //filteredEvents.length,
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
                                _esdevenimentEspecific(index);
                              },
                              title: Column(
                                children: [
                                  Container(
                                    height: 30,
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.favorite,
                                          color: liked(filteredEvents[index].id)
                                              ? Colors.red
                                              : Colors.white,
                                        ),
                                        onPressed: () => setState(() {
                                          if (liked(filteredEvents[index].id)) {
                                            http_delfavourite(cookie,
                                                filteredEvents[index].id);
                                          } else {
                                            http_addfavourite(cookie,
                                                filteredEvents[index].id);
                                          }
                                        }),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      /*'KIKO RIVERA ON CONCERT',*/
                                      filteredEvents[index].title,
                                      style: TextStyle(
                                          fontSize: 24, color: Colors.white),
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
                                        filteredEvents[index].price.toString(),
                                        style: TextStyle(
                                            fontSize: 40, color: Colors.white)),
                                  ),
                                  Expanded(
                                    //color: Colors.red,
                                    //height: 80,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Center(
                                          child: Container(
                                            child: Text(
                                              /*'Palau Sant Jordi',*/
                                              filteredEvents[index].location,
                                              style: TextStyle(
                                                  color: Colors.white),
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
                                            style:
                                                TextStyle(color: Colors.white)),
                                        Container(
                                          height: 5,
                                        ),
                                        Text(
                                            'Música', //filteredEvents[index].category,
                                            style:
                                                TextStyle(color: Colors.white)),
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
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
          const Locale('ca', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode)
              return supportedLocale;
          }
          return supportedLocales.first;
        },
      );
    } else if (!registered &&
        (filteredEvents != null && filteredEvents.length > 0)) {
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
                itemCount: filteredEvents == null ? 0 : filteredEvents.length,
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
                          _esdevenimentEspecific(index);
                        },
                        title: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                /*'KIKO RIVERA ON CONCERT',*/
                                filteredEvents[index].title,
                                style: TextStyle(
                                    fontSize: 24, color: Colors.white),
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
                                  filteredEvents[index].price.toString(),
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
                                        filteredEvents[index].location,
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
                                  Text(
                                      'Música', //filteredEvents[index].category,
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
        ),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
          const Locale('ca', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode)
              return supportedLocale;
          }
          return supportedLocales.first;
        },
      );
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
        ])),
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('en', ''),
          const Locale('es', ''),
          const Locale('ca', ''),
        ],
        localeResolutionCallback: (locale, supportedLocales) {
          for (var supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale.languageCode)
              return supportedLocale;
          }
          return supportedLocales.first;
        },
      );
    }
  }

  _publishEsdeveniment() {
    runApp(MaterialApp(
      home: Publish(),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
    ));
  }

  _esdevenimentEspecific(int index) {
    runApp(MaterialApp(
      home: Mostra(idevent: filteredEvents[index].id),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
    ));
  }
}
