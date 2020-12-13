import 'dart:async';
import 'dart:convert';
import 'dart:developer';
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

import 'http_models/EsdevenimentEspecificModel.dart';
import 'http_requests/http_entrades.dart';
import 'http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/reserves.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

//Variables globals
int idfake = 20;
var _colorFav = Colors.white;
//TO DO: quan connectem amb back, aquest valor serà el que ens dona per darrere
var _rate = 0.0;
TextEditingController controllerfeedback = new TextEditingController();
bool _esperaCarrega = true;
MyInfo mi;

void main() => runApp(MaterialApp(
      title: "EsdevenimentEspecific",
      home: Mostra(idevent: 20),
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
  dynamic services;
  int preu;

  MyInfo(int id, String title, String desc, int cap, DateTime date,
      String location, dynamic organizers, dynamic services, int preu) {
    this.id = id;
    this.title = title;
    this.description = desc;
    this.capacity = cap;
    this.checkInDate = date.toString().split('.')[0];
    this.location = location;
    this.address = location;
    this.organizers = organizers;
    this.services = services;
    this.preu = preu;
  }
}

class Mostra extends StatefulWidget {
  var idevent;

  //final String idevent
  Mostra({Key key, @required this.idevent}) : super(key: key);

  @override
  _MostraState createState() => _MostraState();
}

class _MostraState extends State<Mostra> {
  Controller event;
  //PermissionName permissionName = PermissionName.Internet;
  Completer<GoogleMapController> _controller = Completer();
  var cookie = "";

  bool mostrar = false;
  int id = 20;

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
    final Marker marker = Marker(
        markerId: MarkerId('palau'),
        position: LatLng(41.3580319012, 2.1515327272),
        infoWindow: InfoWindow(
            title: 'Palau Sant Jordi', snippet: 'Kiko Rivera on Tour'));
    _markers.add(marker);
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Container(
          child: Scaffold(
            body: _esperaCarrega
                ? Align(
                    alignment: Alignment.center,
                    child: CircularProgressIndicator())
                : Container(
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
                                  Container(
                                    height: 13,
                                    child: IconButton(
                                      icon: Icon(Icons.favorite),
                                      color: _colorFav,
                                      onPressed: () => {_doFav()},
                                    ),
                                    alignment: Alignment(1, 1),
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
                                            'https://s1.eestatic.com/2016/02/29/actualidad/Actualidad_106001799_1813809_1706x1706.jpg',
                                            width: 120,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              return progress == null
                                                  ? child
                                                  : LinearProgressIndicator();
                                            },
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
                                                  mi.location,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 2,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                ),
                                                Text(
                                                  //'11/04/2021 - 20:30\n',
                                                  mi.checkInDate + '\n',
                                                  style: TextStyle(
                                                      fontSize: 12,
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
                                                                                'PUNTUA L\'ESDEVENIMENT',
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
                                                                                    'DONA\'NS FEEDBACK DE L\'ESDEVENIMENT',
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
                                                                                  'Publica',
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
                                                            'CONTACTA',
                                                            style: TextStyle(
                                                              fontSize: 9,
                                                              color:
                                                                  Colors.blue,
                                                            ),
                                                          ),
                                                          onPressed: () =>
                                                              {_contacta()},
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
                                      target: LatLng(41.3580319012,
                                          2.1515327272), //location.coordenates
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
                                      'MESURES\n',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white.withOpacity(1)),
                                    ),
                                    Text(
                                      "-Mascareta obligatòria\n"
                                      "-Dispensador de gel hidroalcohòlic\n"
                                      "-Aforament reduït al 60%\n",
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
                                      'RESERVA / COMPRA',
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
                    home: Modifica(),
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
    );
  }
  /*void setPermissions() async{
    Map<PermissionGroup, PermissionStatus> permissions =
    await PermissionHandler().requestPermissions([PermissionGroup.location]);
  }*/

  _doFav() {
    //do something
    setState(() {
      if (_colorFav == Colors.white)
        _colorFav = Colors.red;
      else if (_colorFav == Colors.red) _colorFav = Colors.white;
    });
  }

  void _initEvent(int id) async {
    final EsdevenimentEspecificModel event =
        await http_esdevenimentespecific(id);
    /*_rate = event.controller.rating;
    print(event.controller.title);
    print(event.controller.description);
    print(event.controller.capacity);
    print(event.controller.checkInDate);
    print(event.controller.location);
    //print(event.controller.organizers);
    //print(event.controller.services);

     */

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    cookie = stringValue;
    setState(() {
      if (stringValue != null)
        mostrar = true;
      else
        mostrar = false;

      //if (event.controller.title != null) _esperaCarrega = false;
      //test

      print(_esperaCarrega);
      /*test */
      mi = MyInfo(
          20,
          'KIKO RIVERA ON TOUR',
          'El Kiko Rivera es una bestia',
          20,
          DateTime(2020 - 12 - 10),
          'Palau Sant Jordi',
          'KIKO&Co',
          'Música',
          25);
      _esperaCarrega = false;
    });

    /*mi = MyInfo(
        event.controller.id,
        event.controller.title,
        event.controller.description,
        event.controller.capacity,
        event.controller.checkInDate,
        event.controller.location,
        event.controller.organizers,
        event.controller.services,
        event.controller.price
    );*/
  }

  bool esDeLaEmpresa() {
    //Si el esdeveniment és de l'empresa es mostra per editar
    return true;
  }

  _doFeedback() {
    //Aqui comunicarem amb el backend per enviar les dades del feedback, estrelles(1-5), missatge, id esdeveniment, usuari
    print(controllerfeedback.text);
    print(_rate);
    http_afegeixfeedback(_rate.toInt(), controllerfeedback.text, cookie, id);
    Navigator.pop(context);
  }

  _contrata() async {
    final int entradas = 20; //await http_entradas(id);

    runApp(MaterialApp(
      home: Reserves(
        entradas: entradas,
        id: id,
      ),
    ));

    //saltar a la pestanya de Comprar / Reservar
  }

  _goBackButt() {
    Navigator.pop(context, false);
    _goBack();
  }

  _goBack() {
    //Depenent de si venim de events generals o de recomanats anar a un o altre
    bool veDeRecomanats = true;
    if (!veDeRecomanats) {
      runApp(MaterialApp(
        home: EventsGeneral(),
      ));
    } else {
      runApp(MaterialApp(
        home: EsdevenimentsRecomanats(),
      ));
    }
  }

  _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  _initialPosition() {}
}

_contacta() {
  //saltar a la pestanya de Xat amb la empresa
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
