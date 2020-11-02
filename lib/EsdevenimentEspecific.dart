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
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child:Container(
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0) //         <--- border radius here
                          ),
                          color: Colors.blue
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: <Widget>[
                            Image.network(
                                'https://www.imagetheatre.cz/wp-content/uploads/2018/09/66b_pullidi_c3-20.jpg',

                              width: 100,
                              height: 600,
                              loadingBuilder: (context,child,progress){
                                  return progress == null?
                                      child:LinearProgressIndicator();
                              },
                            ),
                            Container(

                             child: Column(
                                 children: <Widget>[Text(
                                  'Nom del concert desde backend',
                                   //style: , Ha de ser més gran ja que es un titol
                                  ),
                                   Text(
                                      'Direcció de l\'esdeveniment per backend',
                                      //style: , Ha de ser més petit ja que es un subtitol
                                   ),
                                   Text(
                                     'DD/MM/AAAA - HH:MM',
                                     //style: , Ha de ser més petit ja que es un subtitol
                                   ),
                                   Text(
                                     'preu €',
                                      style: TextStyle(
                                        fontSize: 20
                                      ), //Ha de ser més gran
                                   )
                                 ])
                            )
                          ],
                        ),
                      ),
                    ),

                        Text('Aqui aniria el mapa'),
                        Image.network(
                          'https://www.adslzone.net/app/uploads-adslzone.net/2017/06/google-maps.jpg',

                          loadingBuilder: (context,child,progress){
                            return progress == null?
                            child:LinearProgressIndicator();
                          },
                        ),

                      ],

                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}