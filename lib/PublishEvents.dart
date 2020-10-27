
import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
void main() => runApp(MaterialApp(
  title: "PublicaEvents",
  home: Publish(),
));
class Publish extends StatefulWidget {
  Publish({Key key}) : super(key: key);
  @override
  _PublishState createState() => _PublishState();
}
class _PublishState extends State<Publish> {
  DateTime selectedDate = DateTime.now();

  final format = DateFormat("yyyy-MM-dd");
  final formath = DateFormat("HH:mm");
  String tipus ='Escull el tipus d\'esdeveniment';
  @override
  Widget build(BuildContext context) {
    String _nom;
    String _descripcio;

    String _direccio;
    String _preu;
    return MaterialApp(
      home: Scaffold(
        body: Container(
          margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: SingleChildScrollView(
              child: Column(
              children: <Widget>[TextFormField(
                decoration: InputDecoration(
                  labelText: "Nom Esdeveniment",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  )
                ),
                maxLines: 1,
                validator: (input) => input.isEmpty ? 'Error' : null,
                onSaved: (input) => _descripcio = input,
              ),
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        labelText: "Descripció de l'Esdeveniment",
                        fillColor: Colors.white,
                        contentPadding: new EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        )
                    ),
                    maxLines: 4,
                    validator: (input) => input.isEmpty ? 'Error' : null,
                    onSaved: (input) => _nom = input,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[TextFormField(
                      decoration: InputDecoration(
                          labelText: "Direcció de l\'Esdeveniment",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          )
                      ),
                      maxLines: 1,
                      validator: (input) => input.isEmpty ? 'Error' : null,
                      onSaved: (input) => _direccio = input,
                    ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[TextFormField(
                      decoration: InputDecoration(
                          labelText: "Preu",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          )
                      ),
                      maxLines: 1,
                      validator: (input) => input.isEmpty ? 'Error' : null,
                      onSaved: (input) => _preu = input,
                    ),

                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[
                      DropdownButton<String>(
                          value: tipus,
                          onChanged: (String newValue) {
                            setState(() {
                              tipus = newValue;
                            });
                          },
                          items: <String>['Escull el tipus d\'esdeveniment','Concert', 'Teatre','Esdeveniment Esportiu','Altres'].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: new Text(value),
                            );
                          }).toList(),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text('Introdueix la Data de l\'Esdeveniment'),
                      Container(
                        margin: EdgeInsets.only(left: 60.0, right:70.0),
                        child: DateTimeField(
                            format: format,
                            onShowPicker: (context, currentValue){
                              return showDatePicker(
                                  context: context,
                                  initialDate: currentValue ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100)
                              );
                            }
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text('Introdueix l\'hora de l\'Esdeveniment'),
                      Container(
                        margin: EdgeInsets.only(left: 70.0, right:94.0),
                        child: DateTimeField(
                            format: formath,
                            onShowPicker: (context, currentValue) async{
                              final time = await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                              );
                              return DateTimeField.convert(time);
                            }
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.0, left: 10.0),
                  child: Row(
                    children: <Widget>[
                      RaisedButton(
                          child: Text('Publica  '),
                          onPressed: () =>{
                            publicaEsdeveniment()
                          },
                      )
                    ],
                  )
                ),

              ],
            ),
            ),
          ),
        ),
      ) ,
    );
  }

  publicaEsdeveniment() {
    //do stuff
  }




}




