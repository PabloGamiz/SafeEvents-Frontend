
import 'dart:developer';

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_models/EsdevenimentEspecificModel.dart';

TextEditingController nomcontroller = new TextEditingController();
TextEditingController descrcontroller = new TextEditingController();
TextEditingController dircontroller = new TextEditingController();
TextEditingController preucontroller = new TextEditingController();
TextEditingController imgcontroller = new TextEditingController();
TextEditingController capcontroller = new TextEditingController();

var idfake = 20;


void main() => runApp(MaterialApp(
  title: "ModificaEvents",
  home: Modifica(),
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
  String img;

  MyInfo(int id, String title, String desc, int cap, DateTime date,
      String location, dynamic organizers, dynamic services, int preu,String img) {
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
    this.img = img;
  }
}
class Modifica extends StatefulWidget {
  Modifica({Key key}) : super(key: key);
  @override
  _ModificaState createState() => _ModificaState();
}
class _ModificaState extends State<Modifica> {
  DateTime selectedDate = DateTime.now();

  final format = DateFormat("yyyy-MM-dd");
  final formath = DateFormat("HH:mm");
  String errorNom = '';
  String errorDir = '';
  String errorPreu = '';
  String errorPicklist = '';
  String errorDataHora = '';
  String errorCap = '';

  var showerror = false;
  var showerrorNom = false;
  var showerrorDir = false;
  var showerrorPreu = false;
  var showerrorPicklist = false;
  var showerrorDataHora = false;
  var showerrorCap = false;

  String tipus ='';

  var _data;
  var _hora;
  MyInfo mi;

  @override
  void initState() {
    // TODO: implement initState
    int id;
    setState(() {
      _initEvent(id);
      _data = DateTime.parse(mi.checkInDate);
      _hora = DateTime.parse(mi.checkInDate);
      nomcontroller.text = mi.title;
      dircontroller.text = mi.location;
      descrcontroller.text = mi.description;
      preucontroller.text = mi.preu.toString();
      imgcontroller.text = mi.img;
      tipus = mi.services;
      capcontroller.text = mi.capacity.toString();
    });
    super.initState();
  }
  Future<bool> _onBackPressed() async{
    return showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: Text('Si tornes enrere no es modificarà l\'Esdeveniment \n\n N\'estàs segur/a?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () =>
                    Navigator.pop(context,false),
                child: Text('No'),
              ),
              FlatButton(
                onPressed: () =>
                    _goBack(),
                child: Text('Sí'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
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
                      maxLines: 1
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
                        controller: descrcontroller,
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
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20.0),
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
                            maxLines: 1
                        ),

                        ],
                      ),
                    ),Container(
                      margin: EdgeInsets.only(left: 15.0),
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
                      margin: EdgeInsets.only(top: 20.0),
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
                    ),Container(
                      margin: EdgeInsets.only(top: 20.0),
                      child: Column(
                        children: <Widget>[TextFormField(
                          controller:capcontroller,
                          decoration: InputDecoration(
                              labelText: "Capacitat de l'esdeveniment",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              )
                          ),
                          maxLines: 1,
                          inputFormatters: <TextInputFormatter>[
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),

                        ],
                      ),
                    ),Container(
                      child:Visibility (
                          visible: showerrorCap,
                          child: Column(
                            children: <Widget>[
                              Text(
                                errorCap,
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
                      child: Column(
                        children: <Widget>[TextField(
                            controller: imgcontroller,
                            decoration: InputDecoration(
                                labelText: "Afegeix un enllaç d'imatge",
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                )
                            ),
                            maxLines: 1
                        ),
                          Text(
                            'Per afegir una imatge és obligatori que estigui pujada a internet',
                            style: TextStyle(
                                fontSize: 10
                            ),
                          )],
                      ),
                      /*child: Row(
                      children: <Widget>[
                        Text(
                          'Selecciona una imatge (Opcional): '
                      ),
                        Container(
                            child: Align(
                                alignment: Alignment.centerRight,
                                child: RaisedButton(
                                  color: Colors.blue,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.circular(18.0),
                                  ),
                                  child: Text(
                                    'Select',
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  onPressed: () => {
                                    seleccionaImatge()
                                  },
                                )
                            )
                        )],
                    ),*/
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
                            items: <String>['Escull el tipus d\'esdeveniment','Musica', 'Teatre','Esport','Art','Altres'].map<DropdownMenuItem<String>>((String value) {
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
                                initialValue: _data,
                                onShowPicker: (context, currentValue) async{

                                  final date = await showDatePicker (
                                    context: context,
                                    initialDate: currentValue ?? DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                  );
                                  _data = date;
                                  return _data;
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

                                initialValue: _hora,
                                onShowPicker: (context, currentValue) async{
                                  final time = await showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.fromDateTime(currentValue ?? DateTime.now()),
                                  );
                                  _hora = DateTimeField.convert(time);
                                  return _hora;
                                }
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10.0, left: 20.0),
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
                              color: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(18.0),
                              ),

                              child: Text('Actualitza',
                                style: TextStyle(
                                  color: Colors.white,

                                ),),
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
        ),
      ) ,
    );
  }

  void _initEvent(int id) async {
    /*final EsdevenimentEspecificModel event =
    await http_esdevenimentespecific(id);*/
    List<String> event;
    /*_rate = event.controller.rating;
    print(event.controller.title);
    print(event.controller.description);
    print(event.controller.capacity);
    print(event.controller.checkInDate);
    print(event.controller.location);
    //print(event.controller.organizers);
    //print(event.controller.services);

     */

    /*SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    setState(() {
      if (stringValue != null)
        mostrar = true;
      else
        mostrar = false;

      /*if (event.controller.title != null) _esperaCarrega = false;
      print(_esperaCarrega);*/
    });*/

    mi = MyInfo(
        /*event.controller.id,
        event.controller.title,
        event.controller.description,
        event.controller.capacity,
        event.controller.checkInDate,
        event.controller.location,
        event.controller.organizers,
        event.controller.services,
        event.controller.price*/
        id,'Kiko Rivera on Tour',
        'El Kiko Rivera torna a Barcelona en el seu tour per Europa',
        12,DateTime.parse('2018-09-27 13:27:00'), 'Palau Sant Jordi',"club","Teatre",25, "google.com/foto");
  }

  publicaEsdeveniment() {
    var nom = nomcontroller.text;
    var descripcio = descrcontroller.text;
    var dir = dircontroller.text;
    var preu = preucontroller.text;
    var data = '';
    var hora = '';
    var img = imgcontroller.text;
    var capacity = capcontroller.text;

    if(_data.toString() != 'null') data = _data.toString().split(' ')[0];
    else data = 'null';

    if(_hora.toString() != 'null') hora = _hora.toString().split(' ')[1];
    else hora = 'null';

    var someError = false;

    setState(() {
      if(nom == ''){
        errorNom= 'El Nom de l\'esdeveniment ha d\'estar informat';
        showerrorNom = true;
      }else showerrorNom = false;

      if(dir == ''){
        errorDir= 'La direcció de l\'esdeveniment ha d\'estar informada';
        showerrorDir = true;
      }else showerrorDir = false;

      if(preu == '') {
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

      if(data=='null' || hora == 'null') {
        errorDataHora ='La data i l\'hora de l\'esdeveniment han d\'estar informades';
        showerrorDataHora = true;
      }
      else showerrorDataHora = false;

      if(capacity == ''){
        errorCap = 'La capacitat ha d\'estar informada';
        showerrorCap = true;
      }
      else showerrorCap = false;

      if(showerrorDataHora || showerrorDir ||showerrorNom || showerrorPicklist || showerrorPreu || showerrorCap)someError = true;
      else someError = false;
    });
    //Si no hi ha errors enviarem les dades al BackEnd i redirigirem la pantalla a la de l'esdeveniment/la principal
    if(!someError){
      //Envia data al backend i redirecciona

      runApp(MaterialApp(
        home: Mostra(idevent: idfake),
      ));

    }

  }

  seleccionaImatge() {
    //do stuff per seleccionar la imatge (obrir explorador arxius)
  }

  _goBack() {
    Navigator.pop(context,false);
    runApp(
        MaterialApp(
          home: Mostra(idevent: idfake),
        ));
  }



}





