import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart';
import 'package:permission/permission.dart';
//import 'package:permission_handler/permission_handler.dart';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:safeevents/EsdevenimentsRecomanats.dart';
import 'package:safeevents/EventsGeneral.dart';
import 'package:safeevents/http_models/Reserva_model.dart';
import 'package:safeevents/http_requests/http_afegeixfeedback.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:safeevents/ModificaEsdeveniment.dart';

import 'MesuresCovidTemplate.dart';
import 'Structure.dart';
import 'chat_screen.dart';
import 'http_models/EsdevenimentEspecificModel.dart';
import 'http_models/FeedbackEsdeveniments.dart';
import 'http_requests/http_editafeedback.dart';
import 'http_requests/http_entrades.dart';
import 'http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/reserves.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'http_requests/http_addfavourite.dart';
import 'http_requests/http_delfavourite.dart';

import 'http_requests/http_getfeedback.dart';
import 'services/database.dart';

import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

//Variables globals
int idfake = 20;
var _colorFav = Colors.white;
//TO DO: quan connectem amb back, aquest valor serà el que ens dona per darrere


int ide;
bool liked;
final DatabaseMethods database = DatabaseMethods();

void main() => runApp(MaterialApp(
      title: "EsdevenimentEspecific",
      home: Mostra(idevent: 2),
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

class MyInfo {
  int id;
  String title;
  String description;
  int capacity;
  String checkInDate;
  String location;
  String address;
  dynamic organizers;
  dynamic service;
  String services;
  int preu;
  String image;
  String tipus;
  bool faved;
  int taken;
  bool esorg;

  MyInfo(
      int id,
      String title,
      String desc,
      int cap,
      DateTime date,
      String location,
      dynamic organizers,
      String services,
      int preu,
      String image,
      String tipus,
      bool faved,
      int taken,
      bool esorg) {
    this.id = id;
    this.title = title;
    this.description = desc;
    this.capacity = cap;
    this.checkInDate = date.toString().split('.')[0];
    //format String location esdeveniment=> nom localitzacio + '--' + lat + ';' + long
    if (location != null) {
      var loc2;
      var loc1;
      if (location.contains('--')) {
        var loc = location.split('--');
        loc2 = loc[1];
        loc1 = loc[0];
      } else {
        loc1 = location;
        loc2 = '0;0';
      }
      this.location = loc2;
      this.address = loc1;
    } else {
      this.location = '0;0';
      this.address = location;
    }
    this.organizers = organizers;
    String serv = '';
    if (services != null) {
      var servi = services.split('\n');
      for (String s in servi) {
        if (s != null) {
          serv = serv + '-' + s + '\n';
        }
      }
    }

    this.services = serv;
    this.preu = preu;
    this.image = image != ''
        ? image
        : 'https://media.istockphoto.com/vectors/internet-error-page-not-found-in-vertical-orientation-for-mobile-a-vector-id1252582565?k=6&m=1252582565&s=170667a&w=0&h=bfQo5S20wuI5QCXoCMEe5Xc0OAVvQ7MKgQKy1EG1qU0=';
    this.tipus = tipus;
    this.faved = faved;
    this.taken = taken;
    this.esorg = esorg;
  }
}

class Mostra extends StatefulWidget {
  var idevent;
  bool liked;

  //final String idevent
  Mostra({Key key, @required this.idevent}) : super(key: key);
  @override
  _MostraState createState() => _MostraState(idevent);
}

class _MostraState extends State<Mostra> {
  TextEditingController controllerfeedback = new TextEditingController();

  var feedbackid;
  var _rate = 0.0;
  bool _esperaCarrega = true;
  MyInfo mi;
  bool liked;
  bool _hafetFeedback = false;
  String textButtonFeedback = 'Publica';
  EsdevenimentEspecificModel event;
  //PermissionName permissionName = PermissionName.Internet;
  Completer<GoogleMapController> _controller = Completer();
  var cookie = "";

  bool mostrar = false;
  int id;

  _MostraState(idevent) {
    id = idevent;
    ide = id;
  }

  //int id = id que pasan desde general Events;
  Future<void> initState() {
    //TO DO: Passar l'event que em ve desde el general
    _initEvent(id);
    super.initState();
  }

  Future<bool> _onBackPressed() async {
    return showDialog(context: context, builder: (context) => _goBackButt());
  }

  final Set<Marker> _markers = Set();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
          child: _esperaCarrega
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Scaffold(
                  body: Container(
                    margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            Container(
                              alignment: Alignment.centerLeft,
                              child: Positioned(
                                left: 8.0,
                                top: 70.0,
                                child: InkWell(
                                  onTap: () {
                                    _goBack();
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.blue),
                                ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
                                  color: Colors.blue),
                              child: Column(
                                children: [
                                  Visibility(
                                    visible: mostrar,
                                    child: Container(
                                      height: 23,
                                      child: IconButton(
                                        icon: Icon(Icons.favorite),
                                        color: !mi.faved
                                            ? Colors.white
                                            : Colors.red,
                                        onPressed: () => {
                                          setState(() {
                                            if (mi.faved) {
                                              http_delfavourite(cookie,
                                                  id); //ID SE PASA POR PARAMETRO AL WIDGET ESDEVENIMENTESPECIFIC
                                              mi.faved = false;
                                            } else {
                                              http_addfavourite(cookie, id);
                                              mi.faved = true;
                                            }
                                          }),
                                        },
                                      ),
                                      alignment: Alignment(1, 1),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 10.0,
                                        right: 10.0,
                                        bottom: 10.0,
                                        top: 20),
                                    child: Row(
                                      children: <Widget>[
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          child: Image.network(
                                            //'https://static2.elcomercio.es/www/pre2017/multimedia/noticias/201702/02/media/cortadas/kiko%20Rivera%2002-kHLI-U211857221190OJH-575x323@El%20Comercio.jpg',
                                            //'https://s1.eestatic.com/2016/02/29/actualidad/Actualidad_106001799_1813809_1706x1706.jpg',
                                            mi.image,
                                            width: 120,
                                            /*loadingBuilder:
                                                (context, child, progress) {
                                              return progress == null
                                                  ? child
                                                  : LinearProgressIndicator();
                                            },*/
                                          ),
                                        ),
                                        Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Container(
                                              width: 150,
                                              child: Column(children: <Widget>[
                                                Text(
                                                  mi.title,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  style: TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                ),
                                                Text(
                                                  mi.description,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 13,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                ),
                                                Text(
                                                  mi.address + '\n',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                ),
                                                Text(
                                                  //'11/04/2021 - 20:30\n',
                                                  mi.checkInDate + '\n',
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      fontStyle:
                                                          FontStyle.italic,
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                ),
                                                Text(
                                                  mi.preu.toString() == 'null'
                                                      ? '0€'
                                                      : mi.preu.toString() +
                                                          '€',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                      fontSize: 25,
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                ),
                                                Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        Container(
                                                          width: 70,
                                                          child: Text(
                                                            mi.organizers
                                                                        .toString() ==
                                                                    '[]'
                                                                ? 'No hi ha organitzador'
                                                                : mi.organizers
                                                                    .toString(),
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            maxLines: 20,
                                                            style: TextStyle(
                                                                fontSize: 11,
                                                                color: Colors
                                                                    .white
                                                                    .withOpacity(
                                                                        1)),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8,
                                                                  top: 10),
                                                          child:
                                                              SmoothStarRating(
                                                                  allowHalfRating:
                                                                      false,
                                                                  onRated: (v) {
                                                                    _rate = v;
                                                                    showDialog(
                                                                      context:
                                                                          context,
                                                                      builder:
                                                                          (_) =>
                                                                              new Container(
                                                                        margin: EdgeInsets.only(
                                                                            top:
                                                                                100,
                                                                            left:
                                                                                50,
                                                                            right:
                                                                                50,
                                                                            bottom:
                                                                                100),
                                                                        decoration: BoxDecoration(
                                                                            border:
                                                                                Border.all(color: Colors.blue),
                                                                            borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                            color: Colors.blue),
                                                                        child:
                                                                            Padding(
                                                                          padding:
                                                                              EdgeInsets.only(top: 45),
                                                                          child:
                                                                              Column(
                                                                            children: <Widget>[
                                                                              Text(
                                                                                AppLocalizations.of(context).puntua,
                                                                                style: TextStyle(
                                                                                  decoration: TextDecoration.none,
                                                                                  color: Colors.white,
                                                                                  fontSize: 13,
                                                                                ),
                                                                                maxLines: 1,
                                                                              ),
                                                                              SmoothStarRating(
                                                                                  allowHalfRating: false,
                                                                                  starCount: 5,
                                                                                  rating: v,
                                                                                  onRated: (r) {
                                                                                    _rate = r;
                                                                                  },
                                                                                  isReadOnly: false,
                                                                                  color: Colors.white,
                                                                                  borderColor: Colors.white,
                                                                                  spacing: 1.0),
                                                                              Align(
                                                                                alignment: Alignment.center,
                                                                                child: Container(
                                                                                  margin: EdgeInsets.only(top: 30),
                                                                                  child: Text(
                                                                                    AppLocalizations.of(context).feedback,
                                                                                    style: TextStyle(
                                                                                      decoration: TextDecoration.none,
                                                                                      color: Colors.white,
                                                                                      fontSize: 13,
                                                                                    ),
                                                                                    maxLines: 1,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              Card(
                                                                                margin: EdgeInsets.only(top: 18, right: 20, left: 20, bottom: 20),
                                                                                child: Container(
                                                                                  color: Colors.blue,
                                                                                  child: Container(
                                                                                    decoration: BoxDecoration(
                                                                                      color: Colors.white,
                                                                                      borderRadius: new BorderRadius.only(
                                                                                        topLeft: const Radius.circular(25.0),
                                                                                        topRight: const Radius.circular(25.0),
                                                                                        bottomLeft: const Radius.circular(25.0),
                                                                                        bottomRight: const Radius.circular(25.0),
                                                                                      ),
                                                                                    ),
                                                                                    child: Column(
                                                                                      children: <Widget>[
                                                                                        TextField(
                                                                                            controller: controllerfeedback,
                                                                                            decoration: InputDecoration(
                                                                                                border: OutlineInputBorder(
                                                                                              borderRadius: BorderRadius.circular(25.0),
                                                                                              borderSide: BorderSide(),
                                                                                            )),
                                                                                            maxLines: 12),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              RaisedButton(
                                                                                color: Colors.white,
                                                                                shape: RoundedRectangleBorder(
                                                                                  borderRadius: new BorderRadius.circular(18.0),
                                                                                ),
                                                                                child: Text(
                                                                                  textButtonFeedback,
                                                                                  style: TextStyle(
                                                                                    fontSize: 13,
                                                                                    color: Colors.blue,
                                                                                  ),
                                                                                ),
                                                                                onPressed: () => {
                                                                                  _doFeedback()
                                                                                },
                                                                              )
                                                                            ],
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  starCount: 5,
                                                                  size: 13.0,
                                                                  rating: _rate,
                                                                  isReadOnly:
                                                                      false,
                                                                  color: Colors
                                                                      .white,
                                                                  borderColor:
                                                                      Colors
                                                                          .white,
                                                                  spacing: 0.0),
                                                        ),
                                                      ],
                                                    ),
                                                    Align(
                                                      alignment:
                                                          Alignment.centerLeft,
                                                      child: ButtonTheme(
                                                        minWidth: 1,
                                                        height: 20,
                                                        child: RaisedButton(
                                                          color: Colors.white,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                new BorderRadius
                                                                        .circular(
                                                                    18.0),
                                                          ),
                                                          child: Text(
                                                            AppLocalizations.of(context).contact,
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          onPressed: () => {
                                                            _contacta(
                                                                mi.organizers
                                                                    .toString(),
                                                                context)
                                                          },
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ]),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 20.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child:
                                    /*Image.network(
                                  'https://www.adslzone.net/app/uploads-adslzone.net/2017/06/google-maps.jpg',
                                  loadingBuilder: (context, child, progress) {
                                    return progress == null
                                        ? child
                                        : LinearProgressIndicator();
                                  },
                                ),*/
                                    SizedBox(
                                  width: 320,
                                  height: 220,
                                  child: GoogleMap(
                                    onMapCreated: _onMapCreated,
                                    initialCameraPosition: CameraPosition(
                                      target: LatLng(
                                          double.parse(mi.location
                                              .toString()
                                              .split(';')[0]),
                                          double.parse(
                                              mi.location.toString().split(';')[
                                                  1])), //location.coordenates
                                      zoom: 15.4746,
                                    ),
                                    markers: _markers,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 500,
                              margin: EdgeInsets.only(top: 20.0),
                              child: RaisedButton(
                                color: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(20.0),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Image(
                                      image: NetworkImage(
                                          'https://github.com/noobcoder17/covid-19/blob/master/assets/corona_virus.png?raw=true'),
                                      height: 30,
                                    ),
                                    Text(
                                      AppLocalizations.of(context).covid,
                                      maxLines: 3,
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12),
                                    ),
                                  ],
                                ),
                                onPressed: () => {_mesures()},
                              ),
                            ),
                            Container(
                              width: 500,
                              margin: EdgeInsets.only(top: 20.0),
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          20.0) //         <--- border radius here
                                      ),
                                  color: Colors.blue),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context).serveis +'\n',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(1)),
                                    ),
                                    Text(
                                      /*"-Mascareta obligatòria\n"
                                      "-Dispensador de gel hidroalcohòlic\n"
                                      "-Aforament reduït al 60%\n",*/
                                      mi.services,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 20,
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(1),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Visibility(
                                visible: mostrar,
                                child: Container(
                                  width: 500,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.blue),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(
                                            20.0) //         <--- border radius here
                                        ),
                                  ),
                                  margin: EdgeInsets.only(top: 20.0),
                                  child: RaisedButton(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(20.0),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context).reservacompra,
                                      style: TextStyle(
                                          color: Colors.blue, fontSize: 20),
                                    ),
                                    onPressed: () => {_contrata()},
                                  ),
                                ))
                          ],
                        ),
                      ),
                    ),
                  ),
                  floatingActionButton: Visibility(
                    visible: esDeLaEmpresa(),
                    child: FloatingActionButton(
                      onPressed: () {
                        runApp(MaterialApp(
                          home: Modifica(idevent: id),
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
                              if (supportedLocale.languageCode ==
                                  locale.languageCode) return supportedLocale;
                            }
                            return supportedLocales.first;
                          },
                        ));
                      },
                      tooltip: 'Publish event',
                      child: Icon(
                        Icons.edit,
                      ),
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
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
  }
  /*void setPermissions() async{
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }*/

  /*_doFav() {
    //do something
    
  }*/

  void _initEvent(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    cookie = stringValue;
    final EsdevenimentEspecificModel event =
        await http_esdevenimentespecific(id, cookie);
    await getFeedbacks(id);
    setState(() {
      if (stringValue != null)
        mostrar = true;
      else
        mostrar = false;

      if (event.title != null) _esperaCarrega = false;
      /*test */
      /*mi = MyInfo(
          id,
          'KIKO RIVERA ON TOUR',
          'El Kiko Rivera es una bestia',
          20,
          DateTime(2020 - 12 - 10),
          'Passeig Olímpic, 5-7, 08038 Barcelona, Spain--41.363371699999995;2.152593',
          'KIKO&Co',
          'Música',
          25,
          'https://s1.eestatic.com/2016/02/29/actualidad/Actualidad_106001799_1813809_1706x1706.jpg',
          'Música',
         true,
         20

       );

       String a = "Passeig Olímpic, 5-7, 08038 Barcelona, Spain--41.363371699999995;2.152593";
       print(a);
        var loc = a.split('--');
        var loc2 = loc[1];
        var loc1 = loc[0];
        print(loc2);
        print(loc1);

      _esperaCarrega = false;*/
//    });
      bool eso = false;
      if (event.esorg != null) eso = event.esorg;

      mi = MyInfo(
          null,
          event.title,
          event.description,
          event.capacity,
          event.checkInDate,
          event.location,
          event.organizers,
          event.mesures,
          /*["Servei de Begudes",
          "Dispensador de gel hidroalcohòlic",
          "Aforament reduït al 60%"],*/
          event.price,
          event.image,
          event.tipus,
          event.faved,
          event.taken,
          eso);
      //_rate = fee.feedbackEsdeven.rating
      //print ('services '+event.services);
      final Marker marker = Marker(
          markerId: MarkerId('palau'),
          position: LatLng(double.parse(mi.location.toString().split(';')[0]),
              double.parse(mi.location.toString().split(';')[1])),
          infoWindow: InfoWindow(title: mi.address, snippet: mi.title));
      _markers.add(marker);
    });
  }

  Future getFeedbacks(int id) async {
    final List<FeedbackEsdeveniments> feedbackEsdeven =
        await http_getfeedback(cookie, id);
    FeedbackEsdeveniments feedb = new FeedbackEsdeveniments();
    int rating = 0;
    for (var i in feedbackEsdeven) {
      rating += i.rating;
      if (i.isOwner) {
        feedb = i;
      }
    }
    setState(() {
      if (feedbackEsdeven.length != 0) {
        _rate = rating / feedbackEsdeven.length;
        if (feedb != null) {
          controllerfeedback.text = feedb.message;
          _hafetFeedback = true;
          textButtonFeedback = 'Edita';
          feedbackid = feedb.id;
        }
      }
    });
  }

  bool esDeLaEmpresa() {
    //Si el esdeveniment és de l'empresa es mostra per editar
    if (mi.esorg) return true;
    return false;
  }

  _doFeedback() async {
    //Aqui comunicarem amb el backend per enviar les dades del feedback, estrelles(1-5), missatge, id esdeveniment, usuari
    if (!_hafetFeedback) {
      Response fe = await http_afegeixfeedback(
          _rate.toInt(), controllerfeedback.text, cookie, id);
      Navigator.pop(context);
      if (fe.statusCode == 200) {
        _hafetFeedback = true;
        setState(() {
          textButtonFeedback = 'Edita';
        });
      }
    } else {
      http_editafeedback(
          feedbackid, _rate.toInt(), controllerfeedback.text, cookie, id);
      Navigator.pop(context);
    }
  }

  _contrata() async {
    runApp(MaterialApp(
      home: Reserves(
          entradas: (mi.capacity - mi.taken), id: id, eventName: mi.title),
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

    //saltar a la pestanya de Comprar / Reservar
  }

  _goBackButt() {
    Navigator.pop(context, false);
    _goBack();
  }

  _goBack() {
    //Depenent de si venim de events generals o de recomanats anar a un o altre
    bool veDeRecomanats = false;
    if (!veDeRecomanats) {
      runApp(MaterialApp(
        home: Structure(),
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
    } else {
      runApp(MaterialApp(
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
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }
}

_mesures() {
  runApp(MaterialApp(
    home: Template(id: ide),
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

_contacta(String userName, BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String myName = prefs.getString('email');
  String chatRoomId = database.getChatRoomId(userName, myName);
  List<String> users = [userName, myName];
  Map<String, dynamic> chatRoomMap = {"users": users, "chatroomid": chatRoomId};
  database.createChatRoom(chatRoomId, chatRoomMap);
  Navigator.push(
      context,
      new MaterialPageRoute(
          builder: (context) => ChatScreen(chatRoomId: chatRoomId)));
}

class ReservaModel {
  String clientId;
  String eventId;
  int option;
  int howMany;
  String desciption;

  // constructor
  Creadora(String clientId, String eventId, int option, int howMany,
      String description) {
    this.clientId = clientId;
    this.eventId = eventId;
    this.option = option;
    this.howMany = howMany;
    this.desciption = description;
  }
}
