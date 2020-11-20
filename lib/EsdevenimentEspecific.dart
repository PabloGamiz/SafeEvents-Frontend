import 'dart:convert';
import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:safeevents/http_models/Reserva_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'http_models/EsdevenimentEspecificModel.dart';
import 'http_requests/http_entrades.dart';
import 'http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/reserves.dart';

var _colorFav = Colors.white;

void main() => runApp(MaterialApp(
      title: "EsdevenimentEspecific",
      home: Mostra(),
    ));

class Mostra extends StatefulWidget {
  Mostra({Key key}) : super(key: key);
  @override
  _MostraState createState() => _MostraState();
}

class _MostraState extends State<Mostra> {
  Controller event;
  @override
  int id = 20;
  //int id = id que pasan desde general Events;
  void initState() {
    super.initState();

    _initEvent(id);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(20.0)),
                        color: Colors.blue),
                    child: Column(
                      children: [
                        Container(
                          height: 20,
                          child: IconButton(
                            icon: Icon(Icons.favorite),
                            color: _colorFav,
                            onPressed: () => {_doFav()},
                          ),
                          alignment: Alignment(1, 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 10.0, right: 10.0, bottom: 10.0, top: 20),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  //'https://static2.elcomercio.es/www/pre2017/multimedia/noticias/201702/02/media/cortadas/kiko%20Rivera%2002-kHLI-U211857221190OJH-575x323@El%20Comercio.jpg',
                                  'https://s1.eestatic.com/2016/02/29/actualidad/Actualidad_106001799_1813809_1706x1706.jpg',
                                  width: 120,
                                  loadingBuilder: (context, child, progress) {
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
                                        'KIKO RIVERA ON TOUR',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white.withOpacity(1)),
                                      ),
                                      Text(
                                        'Palau Sant Jordi, Barcelona',
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 2,
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: Colors.white.withOpacity(1)),
                                      ),
                                      Text(
                                        '11/04/2021 - 20:30\n',
                                        style: TextStyle(
                                            fontSize: 12,
                                            color: Colors.white.withOpacity(1)),
                                      ),
                                      Text(
                                        '25 €',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontSize: 25,
                                            color: Colors.white.withOpacity(1)),
                                      ),
                                      Column(
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                width: 70,
                                                child: Text(
                                                  '\nEmpresa org',
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 20,
                                                  style: TextStyle(
                                                      fontSize: 11,
                                                      color: Colors.white
                                                          .withOpacity(1)),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 8, top: 10),
                                                child: Image.network(
                                                  //Que es mostrin depenent del numero d'estrelles de la empresa una imatge o una altre
                                                  "http://assets.stickpng.com/images/5873869ef3a71010b5e8ef41.png",
                                                  width: 60,
                                                  loadingBuilder: (context,
                                                      child, progress) {
                                                    return progress == null
                                                        ? child
                                                        : LinearProgressIndicator();
                                                  },
                                                ),
                                              ),
                                            ],
                                          ),
                                          Align(
                                            alignment: Alignment.centerLeft,
                                            child: ButtonTheme(
                                              minWidth: 1,
                                              height: 20,
                                              child: RaisedButton(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      new BorderRadius.circular(
                                                          18.0),
                                                ),
                                                child: Text(
                                                  'CONTACTA',
                                                  style: TextStyle(
                                                    fontSize: 9,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                                onPressed: () => {_contacta()},
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
                      child: Image.network(
                        'https://www.adslzone.net/app/uploads-adslzone.net/2017/06/google-maps.jpg',
                        loadingBuilder: (context, child, progress) {
                          return progress == null
                              ? child
                              : LinearProgressIndicator();
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: 500,
                    margin: EdgeInsets.only(top: 20.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blue),
                        borderRadius: BorderRadius.all(Radius.circular(
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
                  Container(
                    width: 500,
                    height: 50,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue),
                      borderRadius: BorderRadius.all(Radius.circular(
                              20.0) //         <--- border radius here
                          ),
                    ),
                    margin: EdgeInsets.only(top: 20.0),
                    child: RaisedButton(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0),
                      ),
                      child: Text(
                        'RESERVA / COMPRA',
                        style: TextStyle(color: Colors.blue, fontSize: 20),
                      ),
                      onPressed: () => {_contrata()},
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  _doFav() {
    //do something
    setState(() {
      if (_colorFav == Colors.white)
        _colorFav = Colors.red;
      else if (_colorFav == Colors.red) _colorFav = Colors.white;
    });
  }

  void _initEvent(int id) async {
    /*final EsdevenimentEspecificModel event =
        await http_esdevenimentespecific(id);
    print('EVENT ' + event.controller.title);*/
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
