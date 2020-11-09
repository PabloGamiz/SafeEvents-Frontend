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
                      height: 100,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0)
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
                              margin: EdgeInsets.only(left: 10.0,),
                             child: Align(
                               alignment: Alignment.centerLeft,
                               child: Column(
                                   children: <Widget>[Text(
                                    'NOM DEL CONCERT',
                                     style: TextStyle(
                                       fontSize: 14,
                                         fontWeight: FontWeight.bold,
                                         color: Colors.white.withOpacity(1)
                                     ) ,
                                    ),
                                     Text(
                                        'Direcció de l\'esdeveniment per backend',
                                       style: TextStyle(
                                           fontSize: 9,
                                           color: Colors.white.withOpacity(1)
                                       ) ,
                                     ),
                                     Text(
                                       'DD/MM/AAAA - HH:MM',
                                       style: TextStyle(
                                           fontSize: 12,
                                           color: Colors.white.withOpacity(1)
                                       ) ,
                                       //style: , Ha de ser més petit ja que es un subtitol
                                     ),
                                     Text(
                                       'preu €',
                                        style: TextStyle(
                                          fontSize: 20,
                                            color: Colors.white.withOpacity(1)
                                        ), //Ha de ser més gran
                                     )
                                   ]),
                             )
                            )
                          ],
                        ),
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        'https://www.adslzone.net/app/uploads-adslzone.net/2017/06/google-maps.jpg',
                        loadingBuilder: (context,child,progress){
                          return progress == null?
                          child:LinearProgressIndicator();
                        },
                      ),
                    ),
                  ),
                    Container(
                      width: 500,
                      margin: EdgeInsets.only(top: 20.0),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.blue),
                          borderRadius: BorderRadius.all(
                              Radius.circular(20.0) //         <--- border radius here
                          ),
                          color: Colors.blue
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child:Column(
                          children: <Widget>[
                            Text('MESURES\n',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white.withOpacity(1)
                              ),
                            ),
                            Text("-Mascareta obligatòria\n"
                                  "-Dispensador de gel hidroalcohòlic\n"
                                  "-Aforament reduït al 60%\n\n",
                              style: TextStyle(
                                color: Colors.white.withOpacity(1),
                            ),
                            ),
                          ],
                      ),
                      ),
                    ),
                  ],
                ),

            ),
          ),
        ),
      ),
    );
  }
}