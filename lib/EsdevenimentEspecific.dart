import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:safeevents/ModificaEsdeveniment.dart';

import 'http_models/EsdevenimentEspecificModel.dart';
import 'http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/http_requests/http_esdevenimentespecific.dart';
import 'package:safeevents/reserves.dart';

import 'package:smooth_star_rating/smooth_star_rating.dart';

var _colorFav = Colors.white;
//TO DO: quan connectem amb back, aquest valor serà el que ens dona per darrere
var _rate = 0.0;
TextEditingController controllerfeedback = new TextEditingController();


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
  void initState() {
    super.initState();
    int id = 20;
    //int id = id que pasan desde general Events;
    _initEvent(id);

  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Container(
        child: Scaffold(
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
                            height:13,
                            child: IconButton(
                              icon: Icon(
                                Icons.favorite),
                                color: _colorFav,
                              onPressed: () => {_doFav()},
                            ),
                            alignment: Alignment(1, 1),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0, top: 20),
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
                                                    overflow: TextOverflow.ellipsis,
                                                    maxLines: 20,
                                                    style: TextStyle(
                                                        fontSize: 11,
                                                        color: Colors.white
                                                            .withOpacity(1)),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.only(left: 8, top: 10),
                                                  child: SmoothStarRating(
                                                      allowHalfRating: false,
                                                      onRated: (v) {
                                                        showDialog(
                                                          context: context,
                                                          builder: (_) =>
                                                          new Container(
                                                            margin: EdgeInsets.only(top:150, left: 50, right:50, bottom: 150),
                                                            decoration: BoxDecoration(
                                                                border: Border.all(color: Colors.blue),
                                                                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                                                                color: Colors.blue),
                                                            child:Padding(
                                                              padding: EdgeInsets.only(top:45),
                                                              child:Column(
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
                                                                    onRated: (r){
                                                                      _rate = r;
                                                                    },
                                                                    isReadOnly:false,
                                                                    color: Colors.white,
                                                                    borderColor: Colors.white,
                                                                    spacing:1.0
                                                                  ),
                                                                Align(
                                                                  alignment: Alignment.center,
                                                                  child:Container(
                                                                    margin: EdgeInsets.only(top:30),
                                                                      child:Text(
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
                                                                    margin: EdgeInsets.only(top:18,right:20, left:20, bottom: 20),
                                                                    child:Container(
                                                                      color: Colors.blue,
                                                                      child: Container(
                                                                        decoration:BoxDecoration(
                                                                          color: Colors.white,
                                                                          borderRadius: new BorderRadius.only(
                                                                            topLeft: const Radius.circular(25.0),
                                                                            topRight: const Radius.circular(25.0),
                                                                            bottomLeft: const Radius.circular(25.0),
                                                                            bottomRight: const Radius.circular(25.0),
                                                                          ),
                                                                        ),
                                                                        child:Column(
                                                                          children: <Widget>[

                                                                            TextField(
                                                                              controller: controllerfeedback,
                                                                              decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(25.0),
                                                                                    borderSide: BorderSide(),
                                                                                  )
                                                                              ),
                                                                              maxLines: 12
                                                                            ),

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

                                                                    child: Text('Publica',
                                                                      style: TextStyle(
                                                                        fontSize: 13,
                                                                        color: Colors.blue,

                                                                      ),),
                                                                    onPressed: () =>{
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
                                                      isReadOnly:false,
                                                      color: Colors.white,
                                                      borderColor: Colors.white,
                                                      spacing:0.0
                                                  ),

                                                ),
                                              ],
                                            ),
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: ButtonTheme(
                                                minWidth:1,
                                                height: 20,
                                                child: RaisedButton(

                                                  color: Colors.white,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: new BorderRadius.circular(18.0),
                                                  ),

                                                  child: Text('CONTACTA',
                                                    style: TextStyle(
                                                      fontSize: 9,
                                                      color: Colors.blue,

                                                    ),),
                                                  onPressed: () =>{
                                                    _contacta()
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
    );
  }

  _doFav() {
    //do something
    setState(() {

      if(_colorFav == Colors.white)_colorFav = Colors.red;
      else if(_colorFav == Colors.red) _colorFav = Colors.white;
    });
  }

  void _initEvent(int id) async {
    final EsdevenimentEspecificModel event = await http_esdevenimentespecific(id);
    //_rate = event.controller.rating;
    print('EVENT '+event.controller.title);
  }

  bool esDeLaEmpresa() {
    //Si el esdeveniment és de l'empresa es mostra per editar
    return true;
  }

  _doFeedback() {
    //Aqui comunicarem amb el backend per enviar les dades del feedback, estrelles(1-5), missatge, id esdeveniment, usuari
    print(controllerfeedback.text);
    print(_rate);
    Navigator.pop(context);
  }
}

_contrata() {
  runApp(MaterialApp(
    home: Reserves(),
  ));
  //saltar a la pestanya de Comprar / Reservar
}

_contacta() {
  //saltar a la pestanya de Xat amb la empresa
}
