import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Structure.dart';
import 'http_models/SignIn_model.dart';
import 'http_requests/http_bluetooth.dart';
import 'http_requests/http_signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/database.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Notificar extends StatefulWidget {
  @override
  _NotificarState createState() => _NotificarState();
}

class _NotificarState extends State<Notificar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          'Select estate',
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            key: Key("NEGATIVE"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'NEGATIVE',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            onPressed: () {
              http_status(0);
              runApp(
                MaterialApp(
                  home: Structure(),
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
                ),
              );
            },
            color: Colors.green,
          ),
          FlatButton(
            key: Key("UNKNOWN"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'UNKNOWN',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            onPressed: () {
              http_status(2);
              runApp(
                MaterialApp(
                  home: Structure(),
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
                ),
              );
            },
            color: Colors.grey,
          ),
          FlatButton(
            key: Key("POSITIVE"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'POSITIVE',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            onPressed: () {
              http_status(1);
              runApp(
                MaterialApp(
                  home: Structure(),
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
                ),
              );
            },
            color: Colors.red,
          ),
        ],
      )),
    );
  }
}
