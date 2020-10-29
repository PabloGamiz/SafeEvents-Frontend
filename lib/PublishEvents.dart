
import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

TextEditingController nomcontroller = new TextEditingController();
TextEditingController dircontroller = new TextEditingController();
TextEditingController preucontroller = new TextEditingController();

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
  String errorNom = '';
  String errorDir = '';
  String errorPreu = '';
  String errorPicklist = '';
  String errorDataHora = '';

  var showerror = false;
  var showerrorNom = false;
  var showerrorDir = false;
  var showerrorPreu = false;
  var showerrorPicklist = false;
  var showerrorDataHora = false;

  String tipus ='Escull el tipus d\'esdeveniment';
  String _nom ='';
  String _descripcio='';
  var _data;
  var _hora;
  String _direccio='';
  String _preu='';
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
              child: Column(
              children: <Widget>[TextField(
                controller: nomcontroller,
                decoration: InputDecoration(
                  labelText: "Nom Esdeveniment",
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(),
                  )
                ),
                maxLines: 1,
                onChanged: (input) => _descripcio = input,
              ),
                Container(
                  child:Visibility (
                      visible: showerrorNom,
                      child: Column(
                        children: <Widget>[
                          Text(
                            errorNom,
                            style: TextStyle(
                              color: Colors.red[700],
                            ),
                          ),
                        ],
                      )
                  ),
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
                      controller: dircontroller,
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
                ),Container(
                  child:Visibility (
                      visible: showerrorDir,
                      child: Column(
                        children: <Widget>[
                          Text(
                            errorDir,
                            style: TextStyle(
                              color: Colors.red[700],
                            ),
                          ),
                        ],
                      )
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, left: 10.0),
                  child: Column(
                    children: <Widget>[TextFormField(
                      controller:preucontroller,
                      decoration: InputDecoration(
                          labelText: "Preu (en €)",
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          )
                      ),
                      maxLines: 1,
                      validator: (input) => input.isEmpty ? 'Error' : null,
                      onSaved: (input) => _preu = input,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.digitsOnly
                      ], // Only numbers can be entered
                    ),

                    ],
                  ),
                ),Container(
                  child:Visibility (
                      visible: showerrorPreu,
                      child: Column(
                        children: <Widget>[
                          Text(
                            errorPreu,
                            style: TextStyle(
                              color: Colors.red[700],
                            ),
                          ),
                        ],
                      )
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
                  child:Visibility (
                      visible: showerrorPicklist,
                      child: Column(
                        children: <Widget>[
                          Text(
                            errorPicklist,
                            style: TextStyle(
                              color: Colors.red[700],
                            ),
                          ),
                        ],
                      )
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
                              _data = currentValue;
                              return showDatePicker(
                                  context: context,
                                  initialDate: currentValue ?? DateTime.now(),
                                  firstDate: DateTime(1900),
                                  lastDate: DateTime(2100),
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
                              _hora = DateTimeField.convert(time);
                              return DateTimeField.convert(time);
                            }
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0, left: 10.0),
                    child:Visibility (
                      visible: showerrorDataHora,
                      child: Column(
                        children: <Widget>[
                          Text(
                              errorDataHora,
                            style: TextStyle(
                              color: Colors.red[700],
                            ),
                          ),
                        ],
                      )
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
    //FALTEN VALIDACIONS, DEPENENT DEL SHOWERRORXXX ES MOSTRAN ERRORS DEPEN DEL LLOC
    var nom = nomcontroller.text;
    var dir = dircontroller.text;
    var preu = preucontroller.text;
    log('nom: '+nom+' dir: '+dir+ 'preu: '+preu);
    setState(() {
      if(/*nom.isEmpty ||*/ nom == ''){
        errorNom= 'El Nom de l\'esdeveniment ha d\'estar informat';
        showerrorNom = true;
      }else showerrorNom = false;

      if(/*dir.isEmpty ||*/ dir == ''){
        errorDir= 'La direcció de l\'esdeveniment ha d\'estar informada';
        showerrorDir = true;
      }else showerrorDir = false;

      if(/*preu.isEmpty || */preu == '') {
        errorPreu = 'El Preu de l\'esdeveniment ha d\'estar informat';
        showerrorPreu = true;
      }else if(int.parse(preu) < 0){
        errorPreu = 'El Preu de l\'esdeveniment ha de ser positiu';
        showerrorPreu = true;
      }else showerrorPreu = false;

      if(tipus == 'Escull el tipus d\'esdeveniment') {
        errorPicklist = 'No és un tipus d\'esdeveniment vàlid';
        showerrorPicklist = true;
      }else showerrorPicklist = false;

      if(/*_data.isEmpty ||*/ _data.toString() == '' /*|| _hora.isEmpty*/ || _hora.toString() == '') {
        errorDataHora =
        'La data i l\'hora de l\'esdeveniment han d\'estar informades';
        showerrorDataHora = true;
      }
        /*type 'DateTime' is not a subtype of type 'String'
      }else if(DateTime.parse(_data).isBefore(DateTime.now()) ){
        errorDataHora = 'La data no pot ser anterior o igual a avui';
        showerrorDataHora = true;
      }*/
      else showerrorDataHora = false;
      });
    }

  }





