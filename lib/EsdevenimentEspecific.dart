import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

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
                          height: 5,
                          child: IconButton(
                            icon: Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                          ),
                          alignment: Alignment(1, 1),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            children: <Widget>[
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20.0),
                                child: Image.network(
                                  'https://static2.elcomercio.es/www/pre2017/multimedia/noticias/201702/02/media/cortadas/kiko%20Rivera%2002-kHLI-U211857221190OJH-575x323@El%20Comercio.jpg',
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
                                      Row(
                                        children: [
                                          Text(
                                            '\nEmpresa org',
                                            style: TextStyle(
                                                fontSize: 11,
                                                color: Colors.white
                                                    .withOpacity(1)),
                                          ),
                                          Image.network(
                                            "http://assets.stickpng.com/images/5873869ef3a71010b5e8ef41.png",
                                            width: 80,
                                            loadingBuilder:
                                                (context, child, progress) {
                                              return progress == null
                                                  ? child
                                                  : LinearProgressIndicator();
                                            },
                                          ),
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
                      onPressed: () => {},
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
}
