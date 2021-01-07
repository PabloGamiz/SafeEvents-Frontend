import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'SignIn.dart';

class Nologin extends StatefulWidget {
  @override
  _NologinState createState() => _NologinState();
}

class _NologinState extends State<Nologin> {
  @override
  Widget build(BuildContext context) {
    final topContentText = Column(
      children: <Widget>[
        SizedBox(height: 20.0),
        Icon(
          Icons.app_blocking_outlined,
          color: Colors.black,
          size: 40.0,
        ),
        SizedBox(height: 10.0),
        Text(
          AppLocalizations.of(context).funcionalitat_no_disponible,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.35,
          padding: EdgeInsets.all(40.0),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.lightBlue),
          child: Center(
            child: topContentText,
          ),
        ),
      ],
    );

    final bottomContentText = Text(
      AppLocalizations.of(context).bottomContentText,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 18.0),
    );
    final readButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => runApp(
            MaterialApp(
              home: SignIn(),
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
          ),
          color: Colors.blue,
          child: Text(AppLocalizations.of(context).sign_in,
              style: TextStyle(color: Colors.white)),
        ));
    final bottomContent = Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[bottomContentText, readButton],
        ),
      ),
    );

    return Scaffold(
      body: Column(
        children: <Widget>[topContent, bottomContent],
      ),
    );
  }
}
