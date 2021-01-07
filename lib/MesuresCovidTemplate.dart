import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'EsdevenimentEspecific.dart';
import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(
      title: "TemplateCOVID",
      home: Template(id: 2),
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

class Template extends StatefulWidget {
  var id;
  Template({Key key, @required this.id}) : super(key: key);
  @override
  _TemplateState createState() => _TemplateState(id);
}

class _TemplateState extends State<Template> {
  int idgeneral;
  _TemplateState(id) {
    idgeneral = id;
  }

  Future<bool> _onBackPressed() async {
    _goBack();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          backgroundColor: Colors.white,
          body: ListView(children: <Widget>[
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
              child: Positioned(
                left: 8.0,
                top: 70.0,
                child: InkWell(
                  onTap: () {
                    _goBackDef();
                  },
                  child: Icon(Icons.arrow_back, color: Colors.blue),
                ),
              ),
            ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      child: FadeInImage(
                        image: NetworkImage(
                            'https://github.com/noobcoder17/covid-19/blob/master/assets/corona_virus.png?raw=true'),

                        // En esta propiedad colocamos el gif o imagen de carga
                        placeholder: NetworkImage(
                            'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                        // En esta propiedad colocamos mediante el objeto BoxFit
                        // la forma de acoplar la imagen en su contenedor
                        fit: BoxFit.cover,

                        // En esta propiedad colocamos el alto de nuestra imagen
                        height: 120,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Image(
                        image: AssetImage('assets/SafeEventsBlack.png'),
                        //width: 130,
                        height: 100,
                      ),
                      /*FadeInImage(

                            image: Image(image:AssetImage('/assets/SafeEventsBlack.png') ) ,

                            // En esta propiedad colocamos el gif o imagen de carga
                            placeholder: NetworkImage(
                                'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                            // En esta propiedad colocamos mediante el objeto BoxFit
                            // la forma de acoplar la imagen en su contenedor
                            fit: BoxFit.cover,

                            // En esta propiedad colocamos el alto de nuestra imagen
                            height: 120,
                          ),*/
                    ),
                  ],
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text(
                    AppLocalizations.of(context).prevencio,
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Text(
                    AppLocalizations.of(context).prevenciosub,
                    style: TextStyle(color: Colors.blueGrey),
                  ),
                ),
              ],
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
                    title: Text(
                      AppLocalizations.of(context).mans + '\n',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    subtitle: Text(
                        AppLocalizations.of(context).manssub),
                    leading: FadeInImage(
                      // En esta propiedad colocamos la imagen a descargar
                      image: NetworkImage(
                          'https://github.com/noobcoder17/covid-19/blob/master/assets/prevention/wash_hands.png?raw=true'),

                      // En esta propiedad colocamos el gif o imagen de carga
                      // debe estar almacenado localmente
                      placeholder: NetworkImage(
                          'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                      // En esta propiedad colocamos mediante el objeto BoxFit
                      // la forma de acoplar la imagen en su contenedor
                      fit: BoxFit.cover,

                      // En esta propiedad colocamos el alto de nuestra imagen
                      height: 260,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
                    title: Text(
                      AppLocalizations.of(context).masc+'\n',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    subtitle: Text(
                        AppLocalizations.of(context).mascsub),
                    leading: FadeInImage(
                      // En esta propiedad colocamos la imagen a descargar
                      image: NetworkImage(
                          'https://github.com/noobcoder17/covid-19/blob/master/assets/prevention/face_mask.png?raw=true'),

                      // En esta propiedad colocamos el gif o imagen de carga
                      // debe estar almacenado localmente
                      placeholder: NetworkImage(
                          'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                      // En esta propiedad colocamos mediante el objeto BoxFit
                      // la forma de acoplar la imagen en su contenedor
                      fit: BoxFit.cover,

                      // En esta propiedad colocamos el alto de nuestra imagen
                      height: 260,
                    ),
                  ),
                ],
              ),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              margin: EdgeInsets.all(15),
              elevation: 10,
              child: Column(
                children: <Widget>[
                  ListTile(
                    contentPadding: EdgeInsets.fromLTRB(15, 10, 25, 20),
                    title: Text(
                      AppLocalizations.of(context).aglo + '\n',
                      style: TextStyle(color: Colors.blue, fontSize: 20),
                    ),
                    subtitle: Text(
                        AppLocalizations.of(context).aglosub),
                    leading: FadeInImage(
                      // En esta propiedad colocamos la imagen a descargar
                      image: NetworkImage(
                          'https://x-madrid.com/wp-content/uploads/2020/06/distancia_icono.png'),

                      // En esta propiedad colocamos el gif o imagen de carga
                      // debe estar almacenado localmente
                      placeholder: NetworkImage(
                          'https://github.com/andygeek/cards_app_flutter/blob/master/assets/loading.gif?raw=true'),

                      // En esta propiedad colocamos mediante el objeto BoxFit
                      // la forma de acoplar la imagen en su contenedor
                      fit: BoxFit.cover,

                      // En esta propiedad colocamos el alto de nuestra imagen
                      height: 260,
                    ),
                  ),
                ],
              ),
            )
          ]),
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

  _goBack() {
    //Navigator.pop(context,false);
    _goBackDef();
  }

  _goBackDef() {
    print('idgene : ' + idgeneral.toString());
    runApp(MaterialApp(
      home: Mostra(idevent: idgeneral),
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
