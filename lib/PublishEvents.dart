

import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:address_search_text_field/address_search_text_field.dart';

import 'package:safeevents/EventsGeneral.dart';
import 'package:safeevents/http_models/ModificaEsdevenimentModel.dart';
import 'package:safeevents/http_requests/http_publishevents.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'EsdevenimentEspecific.dart';

TextEditingController nomcontroller = new TextEditingController();
TextEditingController descrcontroller = new TextEditingController();
TextEditingController dircontroller = new TextEditingController();
TextEditingController preucontroller = new TextEditingController();
TextEditingController imgcontroller = new TextEditingController();
TextEditingController capcontroller = new TextEditingController();
TextEditingController mesurescontroller = new TextEditingController();

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
  String errorCap = '';

  var showerror = false;
  var showerrorNom = false;
  var showerrorDir = false;
  var showerrorPreu = false;
  var showerrorPicklist = false;
  var showerrorDataHora = false;
  var showerrorCap = false;

  String tipus ='Escull el tipus d\'esdeveniment';

  var _data;
  var _hora;
  var coordenades;
  Future<bool> _onBackPressed() async{
    return showDialog(
      context: context,
      builder: (context) =>
      AlertDialog(
        title: Text('Si tornes enrere no es publicarà l\'Esdeveniment \n\n N\'estàs segur/a?'),
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
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Positioned(
                      left: 8.0,
                      top: 70.0,
                      child: InkWell(
                        onTap: () {
                          _goBackDef();
                        },
                        child: Icon(Icons.arrow_back,
                            color: Colors.blue),
                      ),
                    ),
                  ),
                  TextField(
                  key: Key('nomesdeveniment'),
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
                        key: Key('nomerr'),
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
                    child: TextFormField(
                        controller: mesurescontroller,
                        decoration: InputDecoration(
                            labelText: "Afegeix els serveis que s'ofereixen",
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              borderSide: BorderSide(),
                            )
                        ),
                        maxLines: 3
                    ),
                  ),
                  Container(
                      child: Text(
                        'Afegeix un servei per línia',
                        style: TextStyle(
                            fontSize: 10
                        ),
                      ),
                  ),

                  Container(
                    margin: EdgeInsets.only(top: 20.0),
                    child: Column(
                      children: <Widget>[
                        AddressSearchTextField(
                          country: "Spain",//TODO passar pais
                          controller: dircontroller,
                          hintText: 'Introdueix la direcció',
                          decoration: InputDecoration(
                              labelText: "Direcció de l\'Esdeveniment",
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                                borderSide: BorderSide(),
                              )
                          ),
                          noResultsText: "No hi han resultats",
                          onDone: (AddressPoint point){
                            print(point.latitude);
                            print(point.longitude);
                            coordenades = point.latitude.toString() + ';' + point.longitude.toString();
                            print(coordenades);
                            if (point.latitude.toString() != '0.0') Navigator.of(context).pop();
                          },
                        )

                      ],
                    ),
                  ),Container(
                    margin: EdgeInsets.only(left: 15.0),
                    child:Visibility (
                        key: Key('direrr'),

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
                            items: <String>['Escull el tipus d\'esdeveniment','Musica', 'Teatre','Esports','Art','Altres'].map<DropdownMenuItem<String>>((String value) {
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
                              onShowPicker: (context, currentValue) async{

                                final date = await showDatePicker (
                                    context: context,
                                    initialDate: currentValue ?? DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                );
                                _data = date;
                                return date;
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
                          key: Key('bott'),
                            color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(18.0),
                          ),

                            child: Text('Publica',
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

      _cridabackend(nom,descripcio,capacity,dir,preu,data,hora,img,tipus);
      //SI LA CAPACITAT ESTA TOTA OCUPADA PUES SHA DE DESACTIVAR

    }

    }
  _cridabackend(String nom, String descripcio,String capacity,String direc,String preu, String data,String hora,String img,String tipus) async{
    var mesura = mesurescontroller.text;
    //List<String> mesuresCOVID = mesura.split('\n');
    /*List<String> s1 = new List<String>();
    for (var i in mesuresCOVID ){
      String querypar = '{ \'name\' : \'\' '+i+', \'description\' : \'\',\'kind\': \'\',\'location\':\'\',\'product\': null}';
      print('queryparam : '+querypar);
      s1.add(querypar);

    }*/
    String datahora = data+'T'+hora+'Z';
    print('Mesures contr '+mesurescontroller.text);
    print(coordenades);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cookie = prefs.getString('cookie');

    final ModificaEsdevenimentModel event = await http_publishevents(nom,descripcio,int.parse(capacity),datahora,int.parse(preu),direc, coordenades,img,cookie, tipus, mesura);
    nomcontroller = new TextEditingController();
     descrcontroller = new TextEditingController();
     dircontroller = new TextEditingController();
     preucontroller = new TextEditingController();
     imgcontroller = new TextEditingController();
     capcontroller = new TextEditingController();
     mesurescontroller = new TextEditingController();
    //event.id
    runApp(MaterialApp(
      home: Mostra(idevent: event.controller.id),
    ));

  }
  seleccionaImatge() {
    //do stuff per seleccionar la imatge (obrir explorador arxius)
  }

  _goBack() {
    Navigator.pop(context,false);
    _goBackDef();
  }
  _goBackDef() {

    runApp(
        MaterialApp(
          home: EventsGeneral(),
        ));
  }



  }





