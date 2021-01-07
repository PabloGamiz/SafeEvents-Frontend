import 'package:address_search_text_field/address_search_text_field.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:safeevents/http_models/ModificaEsdevenimentModel.dart';
import 'package:safeevents/http_requests/http_modificaesdeveniment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'http_models/EsdevenimentEspecificModel.dart';
import 'http_requests/http_esdevenimentespecific.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

TextEditingController nomcontroller = new TextEditingController();
TextEditingController descrcontroller = new TextEditingController();
TextEditingController dircontroller = new TextEditingController();
TextEditingController preucontroller = new TextEditingController();
TextEditingController imgcontroller = new TextEditingController();
TextEditingController capcontroller = new TextEditingController();
TextEditingController mesurescontroller = new TextEditingController();
var idfake = 4;
bool _esperaCarrega = true;


void main() => runApp(MaterialApp(
      title: "ModificaEvents",
      home: Modifica(idevent: idfake),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
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
  dynamic tipus;
  int preu;
  String img;
  String mesures;

  MyInfo(
      int id,
      String title,
      String desc,
      int cap,
      DateTime date,
      String location,
      dynamic organizers,
      dynamic services,
      int preu,
      String img,
      String mesures) {
    this.id = id;
    this.title = title;
    this.description = desc;
    this.capacity = cap;
    this.checkInDate = date.toString().split('.')[0];
    this.location = location;
    this.address = location;
    this.organizers = organizers;
    this.tipus = services;
    this.preu = preu;
    this.img = img;
    this.mesures = mesures;
  }
}

class Modifica extends StatefulWidget {
  var idevent;
  Modifica({Key key, @required this.idevent}) : super(key: key);
  @override
  _ModificaState createState() => _ModificaState(idevent);
}

class _ModificaState extends State<Modifica> {
  var cookie = "";
  DateTime selectedDate = DateTime.now();
  var coordenades;

  String tipus ;
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



  var _data;
  var _hora;
  MyInfo mi;

  int id;

  _ModificaState(idevent) {
    id = idevent;
  }

  @override
  void initState() {
    // TODO: implement initState
    _initEvent(id);

    super.initState();
  }

  Future<bool> _onBackPressed() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
            AppLocalizations.of(context).warnbackmodif),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => _goBack(),
            child: Text(  AppLocalizations.of(context).si),
          ),
        ],
      ),
    );
  }
  int i = 0;
  @override
  Widget build(BuildContext context) {
    if(i ==0){
      tipus = AppLocalizations.of(context).esculltipusesd;
      ++i;
    }
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          body: _esperaCarrega
              ? Align(
                  alignment: Alignment.center,
                  child: CircularProgressIndicator())
              : Container(
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
                                  _onBackPressed();
                                },
                                child:
                                    Icon(Icons.arrow_back, color: Colors.blue),
                              ),
                            ),
                          ),
                          TextField(
                              controller: nomcontroller,
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).nomesdev,
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(),
                                  )),
                              maxLines: 1),
                          Container(
                            child: Visibility(
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
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: TextFormField(
                              controller: descrcontroller,
                              decoration: InputDecoration(
                                  labelText: AppLocalizations.of(context).descr,
                                  fillColor: Colors.white,
                                  contentPadding: new EdgeInsets.symmetric(
                                      vertical: 30.0, horizontal: 20.0),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(),
                                  )),
                              maxLines: 4,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: TextFormField(
                                controller: mesurescontroller,
                                decoration: InputDecoration(
                                    labelText:
                                    AppLocalizations.of(context).addserv,
                                    fillColor: Colors.white,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(25.0),
                                      borderSide: BorderSide(),
                                    )),
                                maxLines: 3),
                          ),
                          Container(
                            child: Text(
                              AppLocalizations.of(context).addservwarn,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                /*TextFormField(
                              controller: dircontroller,
                              decoration: InputDecoration(
                                  labelText: "Direcció de l\'Esdeveniment",
                                  fillColor: Colors.white,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(25.0),
                                    borderSide: BorderSide(),
                                  )),
                              maxLines: 1),*/
                                AddressSearchTextField(
                                  country: "Spain", //TODO passar pais
                                  controller: dircontroller,
                                  hintText: AppLocalizations.of(context).introdueixdir,
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context).introdueixdir,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(),
                                      )),
                                  noResultsText: AppLocalizations.of(context).noresults,
                                  onDone: (AddressPoint point) {
                                    print(point.latitude);
                                    print(point.longitude);
                                    coordenades = point.latitude.toString() +
                                        ';' +
                                        point.longitude.toString();
                                    print(coordenades);
                                    if (point.latitude.toString() != '0.0')
                                      Navigator.of(context).pop();
                                  },
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 15.0),
                            child: Visibility(
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
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: preucontroller,
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context).preueneu,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(),
                                      )),
                                  maxLines: 1,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ], // Only numbers can be entered
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Visibility(
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
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                TextFormField(
                                  controller: capcontroller,
                                  decoration: InputDecoration(
                                      labelText: AppLocalizations.of(context).capacitatesd,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(25.0),
                                        borderSide: BorderSide(),
                                      )),
                                  maxLines: 1,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Visibility(
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
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0),
                            child: Column(
                              children: <Widget>[
                                TextField(
                                    controller: imgcontroller,
                                    decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context).enllimg,
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(),
                                        )),
                                    maxLines: 1),
                                Text(
                                  AppLocalizations.of(context).enllimgwarn,
                                  style: TextStyle(fontSize: 10),
                                )
                              ],
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
                                  items: <String>[
                                    AppLocalizations.of(context).esculltipusesd,
                                    AppLocalizations.of(context).musica,
                                    AppLocalizations.of(context).teatre,
                                    AppLocalizations.of(context).esport,
                                    AppLocalizations.of(context).art,
                                    AppLocalizations.of(context).altres
                                  ].map<DropdownMenuItem<String>>(
                                      (String value) {
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
                            child: Visibility(
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
                                )),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 20.0, left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).intrdata),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 60.0, right: 70.0),
                                  child: DateTimeField(
                                      format: format,
                                      initialValue: _data,
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final date = await showDatePicker(
                                          context: context,
                                          initialDate:
                                              currentValue ?? DateTime.now(),
                                          firstDate: DateTime(1900),
                                          lastDate: DateTime(2100),
                                        );
                                        _data = date;
                                        return _data;
                                      }),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 10.0),
                            child: Column(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).intrhora),
                                Container(
                                  margin:
                                      EdgeInsets.only(left: 70.0, right: 94.0),
                                  child: DateTimeField(
                                      format: formath,
                                      initialValue: _hora,
                                      onShowPicker:
                                          (context, currentValue) async {
                                        final time = await showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.fromDateTime(
                                              currentValue ?? DateTime.now()),
                                        );
                                        _hora = DateTimeField.convert(time);
                                        return _hora;
                                      }),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10.0, left: 20.0),
                            child: Visibility(
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
                                )),
                          ),
                          Container(
                              margin: EdgeInsets.only(top: 10.0, left: 10.0),
                              child: Row(
                                children: <Widget>[
                                  RaisedButton(
                                    color: Colors.blue,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(18.0),
                                    ),
                                    child: Text(
                                      AppLocalizations.of(context).actualitza,
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                    onPressed: () => {publicaEsdeveniment()},
                                  )
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
    );
  }

  void _initEvent(int id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');

    final EsdevenimentEspecificModel event =
        await http_esdevenimentespecific(id, stringValue);
    //ModificaEsdevenimentModel event;
    /*_rate = event.controller.rating;
    print(event.controller.title);
    print(event.controller.description);
    print(event.controller.capacity);
    print(event.controller.checkInDate);
    print(event.controller.location);
    //print(event.controller.organizers);
    //print(event.controller.services);

     */

    setState(() {
      cookie = stringValue;

      /*if (event.controller.title != null) _esperaCarrega = false;*/


      String aux = '';
      if(event.tipus == 'Teatre') aux = AppLocalizations.of(context).teatre;
      else if(event.tipus == 'Música') aux = AppLocalizations.of(context).musica;
      else if(event.tipus == 'Esport') aux = AppLocalizations.of(context).esport;
      else if(event.tipus == 'Art') aux = AppLocalizations.of(context).art;
      else if(event.tipus == 'Altres') aux = AppLocalizations.of(context).altres;
      tipus = aux;
      if (event.title != null) _esperaCarrega = false;

      mi = MyInfo(
        null,
        event.title,
        event.description,
        event.capacity,
        event.checkInDate,
        event.location,
        'org',
        aux,
        event.price,
        event.image,
        event.mesures,
        /*id,
        'Kiko Rivera on Tour',
        'El Kiko Rivera torna a Barcelona en el seu tour per Europa',
        12,
        DateTime.parse('2018-09-27 13:27:00'),
        'Palau Sant Jordi',
        "club",
        "Teatre",
        25,
        "google.com/foto"*/
      );

      _data = DateTime.parse(mi.checkInDate);
      _hora = DateTime.parse(mi.checkInDate);

      nomcontroller.text = mi.title;
      dircontroller.text = mi.location.toString().split('--')[0];
      mesurescontroller.text = mi.mesures.toString();
      var coord = mi.location.toString().split('--')[1];
      coordenades = coord;
      descrcontroller.text = mi.description;
      preucontroller.text = mi.preu.toString();
      imgcontroller.text = mi.img;
      tipus = mi.tipus;
      capcontroller.text = mi.capacity.toString();
    });
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
    var services = [];

    if (_data.toString() != 'null')
      data = _data.toString().split(' ')[0];
    else
      data = 'null';

    if (_hora.toString() != 'null')
      hora = _hora.toString().split(' ')[1];
    else
      hora = 'null';

    var someError = false;
    String tipusback;


    setState(() {
      if (nom == '') {
        errorNom = AppLocalizations.of(context).errornom;
        showerrorNom = true;
      } else
        showerrorNom = false;

      if (dir == '') {
        errorDir = AppLocalizations.of(context).errordir;
        showerrorDir = true;
      } else
        showerrorDir = false;

      if (preu == '') {
        errorPreu = AppLocalizations.of(context).errorpreu;
        showerrorPreu = true;
      } else if (int.parse(preu) < 0) {
        errorPreu = 'El Preu de l\'esdeveniment ha de ser positiu';
        showerrorPreu = true;
      } else
        showerrorPreu = false;

      if (tipus == AppLocalizations.of(context).esculltipusesd) {
        errorPicklist = AppLocalizations.of(context).errortipus;
        showerrorPicklist = true;
      } else {
        showerrorPicklist = false;
        if(tipus == AppLocalizations.of(context).teatre) tipusback = 'Teatre';
        else if(tipus == AppLocalizations.of(context).musica) tipusback = 'Música';
        else if(tipus == AppLocalizations.of(context).esport) tipusback = 'Esport';
        else if(tipus == AppLocalizations.of(context).art) tipusback = 'Art';
        else if(tipus == AppLocalizations.of(context).altres) tipusback = 'Altres';
      }

      if (data == 'null' || hora == 'null') {
        errorDataHora =AppLocalizations.of(context).errordatahora
        ;
        showerrorDataHora = true;
      } else
        showerrorDataHora = false;

      if (capacity == '') {
        errorCap = AppLocalizations.of(context).errorcap;
        showerrorCap = true;
      } else
        showerrorCap = false;

      if (showerrorDataHora ||
          showerrorDir ||
          showerrorNom ||
          showerrorPicklist ||
          showerrorPreu ||
          showerrorCap)
        someError = true;
      else
        someError = false;
    });
    //Si no hi ha errors enviarem les dades al BackEnd i redirigirem la pantalla a la de l'esdeveniment/la principal
    if (!someError) {
      //Envia data al backend i redirecciona
      _callbackend(cookie, id, nom, descripcio, capacity, preu, data, hora, dir,
          services, img, tipus);
    }
  }

  seleccionaImatge() {
    //do stuff per seleccionar la imatge (obrir explorador arxius)
  }

  _goBack() {
    Navigator.pop(context, false);
    _goBackDef();
  }

  _goBackDef() {
    runApp(MaterialApp(
      home: Mostra(idevent: id),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
    ));
  }

  void _callbackend(
      String cookie,
      int id,
      String nom,
      String descripcio,
      String capacity,
      String preu,
      String data,
      String hora,
      String dir,
      List<dynamic> services,
      String img,
      String tipus) async {
    var mesura = mesurescontroller.text;
    List<String> mesuresCOVID = mesura.split('\n');
    String datahora = data + 'T' + hora + 'Z';
    if(tipus.startsWith('M')) tipus = 'Música';
    else if(tipus.startsWith('T'))tipus = 'Teatre';
    else if(tipus.startsWith('E'))tipus = 'Esport';
    else if(tipus.startsWith('D')) tipus = 'Esport';
    else if(tipus.startsWith('A')){
      if(tipus.contains('Al'))tipus = 'Altres';
      else tipus = 'Art';
    }
    else if(tipus.startsWith('O'))tipus = 'Altres';
    final ModificaEsdevenimentModel event = await http_modificaesdeveniment(
        cookie,
        id,
        nom,
        descripcio,
        int.parse(capacity),
        int.parse(preu),
        datahora,
        dir,
        coordenades,
        mesura,
        img,
        tipus);
    nomcontroller = new TextEditingController();
    descrcontroller = new TextEditingController();
    dircontroller = new TextEditingController();
    preucontroller = new TextEditingController();
    imgcontroller = new TextEditingController();
    capcontroller = new TextEditingController();
    mesurescontroller = new TextEditingController();

    runApp(MaterialApp(
      home: Mostra(idevent: id),
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''),
        const Locale('es', ''),
        const Locale('ca', ''),
      ],
      localeResolutionCallback: (locale, supportedLocales) {
        for (var supportedLocale in supportedLocales) {
          if (supportedLocale.languageCode == locale.languageCode)
            return supportedLocale;
        }
        return supportedLocales.first;
      },
    ));
  }
}
