import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'http_models/FavsModel.dart';
import 'http_requests/http_favs.dart';

class ConsultaFavortis extends StatefulWidget {
  ConsultaFavortis();

  _ConsultaFavoritsState createState() => _ConsultaFavoritsState();
}

class _ConsultaFavoritsState extends State<ConsultaFavortis> {
  Future<List<FavsModel>> favs;

  @override
  void initState() {
    super.initState();
    favs = fetchFavEvents();
  }

  Future<List<FavsModel>> fetchFavEvents() async {
    return await http_Favs();
  }

  Widget createListEventWidget(AsyncSnapshot<List<FavsModel>> snapshot) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: snapshot.data.map(_buildEventWidget).toList(),
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget createNoFavsWidget() {
    return Scaffold(
      body: Center(
        child: Text(
          AppLocalizations.of(context).noFavsMessage,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FavsModel>>(
      future: favs,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length != 0)
            return createListEventWidget(snapshot);
          else
            return createNoFavsWidget();
        } else if (snapshot.hasError) {
          return Text(AppLocalizations.of(context).favsErrorMessage);
        }

        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }
}

_esdevenimentEspecific(int id) {
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

Widget _buildEventWidget(FavsModel event) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 1.0,
      horizontal: 4.0,
    ),
    child: Card(
      color: Colors.lightBlue,
      child: ListTile(
        onTap: () {
          _esdevenimentEspecific(event.id);
        },
        title: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                event.title,
                style: TextStyle(fontSize: 24, color: Colors.white),
                maxLines: 2,
                overflow: TextOverflow.fade,
              ),
            ),
            SizedBox(
              height: 10,
            ),
          ],
        ),
        subtitle: Row(
          children: [
            SizedBox(
              width: 25,
            ),
            Expanded(
              child: Text(event.price.toString() + '€',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
            ),
            Expanded(
              //color: Colors.red,
              //height: 80,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Container(
                      child: Text(
                        event.location,
                        /*filteredEvents[index].location.name,*/
                        style: TextStyle(color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ),
                  ),
                  Container(
                    height: 5,
                  ),
                  Text(event.closureDate.toString().substring(0, 16),
                      style: TextStyle(color: Colors.white)),
                  Container(
                    height: 5,
                  ),
                  Text(event.tipus, style: TextStyle(color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
