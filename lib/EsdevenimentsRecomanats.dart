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

List<ListEsdevenimentsModel> filtrarEsdeveniments(
    List<ListEsdevenimentsModel> esdev, String paraula, int tipus) {
  List<ListEsdevenimentsModel> filtered = List();
  if (tipus == 0) {
    //filtrar per ciutat
    filtered = esdev
        .where((e) => (e.location.contains(paraula))) //MIRAR SI ESTO ESTA BIEN
        .toList();
  } else {
    //filtrar per categoria
    filtered = esdev.where((e) => (e.tipus.contains(paraula))).toList();
  }
  return filtered;
}

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
  bool filteredcity = false;
  bool filteredcategory = false;
  String ciutatCercada;
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
    if (registered && filteredEvents.length > 0) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).cercarciutat,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  ciutatCercada = string;
                  if (string == "") {
                    filteredcity = false;
                    if (filteredcategory)
                      filteredEvents =
                          filtrarEsdeveniments(generalEvents, tipus, 1);
                  } else {
                    filteredcity = true;
                  }
                  if (filteredcategory) {
                    filteredEvents =
                        filtrarEsdeveniments(filteredEvents, string, 0);
                  } else {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, string, 0);
                  }
                });
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
            hint: Text(AppLocalizations.of(context).scategory),
            value: _defaultValue,
            items: [
              AppLocalizations.of(context).tots,
              AppLocalizations.of(context).musica,
              AppLocalizations.of(context).teatre,
              AppLocalizations.of(context).esport,
              AppLocalizations.of(context).art,
              AppLocalizations.of(context).altres
            ].map((newValue) {
              return DropdownMenuItem<String>(
                value: newValue,
                child: Text(newValue),
              );
            }).toList(),
            onChanged: (newValue) {
              _debouncer.run(() {
                setState(() {
                  _defaultValue = newValue;
                  if (newValue == "")
                    tipus = "";
                  else if (newValue == "Música" || newValue == "Music")
                    tipus = "Musica";
                  else if (newValue == "Teatre" ||
                      newValue == "Theatre" ||
                      newValue == "Teatro")
                    tipus = "Teatre";
                  else if (newValue == "Esport" ||
                      newValue == "Sport" ||
                      newValue == "Deporte")
                    tipus = "Esport";
                  else if (newValue == "Art" ||
                      newValue == "Art" ||
                      newValue == "Arte")
                    tipus = "Art";
                  else if (newValue == "Altres" ||
                      newValue == "Others" ||
                      newValue == "Otros") tipus = "Altres";
                  if (tipus == "") {
                    filteredcategory = false;
                  } else {
                    filteredcategory = true;
                  }
                  if (filteredcity) {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, ciutatCercada, 0);
                    filteredEvents =
                        filtrarEsdeveniments(filteredEvents, tipus, 1);
                  } else {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, tipus, 1);
                  }
                  /*filteredEvents = filtrarEsdeveniments(generalEvents, newValue, 1); generalEvents
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
              itemCount: filteredEvents.length,
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
                                    http_delfavourite(
                                        cookie, filteredEvents[index].id);
                                  } else {
                                    http_addfavourite(
                                        cookie, filteredEvents[index].id);
                                  }
                                }),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
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
                            child: Text(
                                filteredEvents[index].price.toString() + "€",
                                style: TextStyle(
                                    fontSize: 40, color: Colors.white)),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Center(
                                  child: Container(
                                    child: Text(
                                      filteredEvents[index]
                                          .location
                                          .split('--')[0],
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
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
                                        .toString()
                                        .substring(0, 16),
                                    style: TextStyle(color: Colors.white)),
                                Container(
                                  height: 5,
                                ),
                                Text(filteredEvents[index].tipus,
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
      );
      /*localizationsDelegates: [
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
      );*/
    } else if (!registered && filteredEvents.length > 0) {
      return /*MaterialApp(
        home: */
          Scaffold(
        body: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).cercarciutat,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  ciutatCercada = string;
                  if (string == "") {
                    filteredcity = false;
                    if (filteredcategory)
                      filteredEvents =
                          filtrarEsdeveniments(generalEvents, tipus, 1);
                  } else {
                    filteredcity = true;
                  }
                  if (filteredcategory) {
                    filteredEvents =
                        filtrarEsdeveniments(filteredEvents, string, 0);
                  } else {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, string, 0);
                  }
                });
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
            hint: Text(AppLocalizations.of(context).scategory),
            value: _defaultValue,
            items: [
              AppLocalizations.of(context).tots,
              AppLocalizations.of(context).musica,
              AppLocalizations.of(context).teatre,
              AppLocalizations.of(context).esport,
              AppLocalizations.of(context).art,
              AppLocalizations.of(context).altres
            ].map((newValue) {
              return DropdownMenuItem<String>(
                value: newValue,
                child: Text(newValue),
              );
            }).toList(),
            onChanged: (newValue) {
              _debouncer.run(() {
                setState(() {
                  _defaultValue = newValue;
                  if (newValue == "")
                    tipus = "";
                  else if (newValue == "Música" || newValue == "Music")
                    tipus = "Musica";
                  else if (newValue == "Teatre" ||
                      newValue == "Theatre" ||
                      newValue == "Teatro")
                    tipus = "Teatre";
                  else if (newValue == "Esport" ||
                      newValue == "Sport" ||
                      newValue == "Deporte")
                    tipus = "Esport";
                  else if (newValue == "Art" ||
                      newValue == "Art" ||
                      newValue == "Arte")
                    tipus = "Art";
                  else if (newValue == "Altres" ||
                      newValue == "Others" ||
                      newValue == "Otros") tipus = "Altres";
                  if (tipus == "") {
                    filteredcategory = false;
                  } else {
                    filteredcategory = true;
                  }
                  if (filteredcity) {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, ciutatCercada, 0);
                    filteredEvents =
                        filtrarEsdeveniments(filteredEvents, tipus, 1);
                  } else {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, tipus, 1);
                  }
                  /*filteredEvents = filtrarEsdeveniments(generalEvents, newValue, 1); generalEvents
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
              itemCount: filteredEvents.length,
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
                          Container(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                  filteredEvents[index].price.toString() + "€",
                                  /*sumadelpreu(filteredEvents[index]).toString(),*/
                                  style: TextStyle(
                                      fontSize: 40, color: Colors.white)),
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
                                      /*'Palau Sant Jordi',*/
                                      filteredEvents[index]
                                          .location
                                          .split('--')[0],
                                      style: TextStyle(color: Colors.white),
                                      textAlign: TextAlign.center,
                                      // maxLines: 2,
                                      // overflow: TextOverflow.fade,
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
                                        .toString()
                                        .substring(0, 16),
                                    style: TextStyle(color: Colors.white)),
                                Container(
                                  height: 5,
                                ),
                                Text(filteredEvents[index].tipus,
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
      );
      /*localizationsDelegates: [
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
      );*/
    } else {
      return /*MaterialApp(
        home: */
          Scaffold(
        body: Column(children: <Widget>[
          SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
              labelText: AppLocalizations.of(context).cercarciutat,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide(),
              ),
            ),
            onChanged: (string) {
              _debouncer.run(() {
                setState(() {
                  ciutatCercada = string;
                  if (string == "") {
                    filteredcity = false;
                    if (filteredcategory)
                      filteredEvents =
                          filtrarEsdeveniments(generalEvents, tipus, 1);
                  } else {
                    filteredcity = true;
                  }
                  if (filteredcategory) {
                    filteredEvents =
                        filtrarEsdeveniments(filteredEvents, string, 0);
                  } else {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, string, 0);
                  }
                });
              });
            },
          ),
          SizedBox(
            height: 10,
          ),
          DropdownButton<String>(
            hint: Text(AppLocalizations.of(context).scategory),
            value: _defaultValue,
            items: [
              AppLocalizations.of(context).tots,
              AppLocalizations.of(context).musica,
              AppLocalizations.of(context).teatre,
              AppLocalizations.of(context).esport,
              AppLocalizations.of(context).art,
              AppLocalizations.of(context).altres
            ].map((newValue) {
              return DropdownMenuItem<String>(
                value: newValue,
                child: Text(newValue),
              );
            }).toList(),
            onChanged: (newValue) {
              _debouncer.run(() {
                setState(() {
                  _defaultValue = newValue;
                  if (newValue == "")
                    tipus = "";
                  else if (newValue == "Música" || newValue == "Music")
                    tipus = "Musica";
                  else if (newValue == "Teatre" ||
                      newValue == "Theatre" ||
                      newValue == "Teatro")
                    tipus = "Teatre";
                  else if (newValue == "Esport" ||
                      newValue == "Sport" ||
                      newValue == "Deporte")
                    tipus = "Esport";
                  else if (newValue == "Art" ||
                      newValue == "Art" ||
                      newValue == "Arte")
                    tipus = "Art";
                  else if (newValue == "Altres" ||
                      newValue == "Others" ||
                      newValue == "Otros") tipus = "Altres";
                  if (tipus == "") {
                    filteredcategory = false;
                  } else {
                    filteredcategory = true;
                  }
                  if (filteredcity) {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, ciutatCercada, 0);
                    filteredEvents =
                        filtrarEsdeveniments(filteredEvents, tipus, 1);
                  } else {
                    filteredEvents =
                        filtrarEsdeveniments(generalEvents, tipus, 1);
                  }
                  /*filteredEvents = filtrarEsdeveniments(generalEvents, newValue, 1); generalEvents
                            .where((e) => e.category.contains(newValue))
                            .toList();*/
                });
              });
            },
          ),
          SizedBox(
            height: 180,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.topCenter,
              child: Text(
                AppLocalizations.of(context).noesdeveniments,
                style: TextStyle(
                  color: Colors.grey,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          )
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
      );
      /*localizationsDelegates: [
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
      );*/
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
