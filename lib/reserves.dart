import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:share/share.dart';
import 'package:safeevents/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:numberpicker/numberpicker.dart';
import 'EsdevenimentEspecific.dart';
import 'Qr.dart';
import 'Structure.dart';
import 'http_models/resposta_reserva_model.dart';
import 'http_requests/http_entrades.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Reserves extends StatefulWidget {
  final int entradas;
  final int id;
  final String eventName;

  const Reserves(
      {Key key,
      @required this.entradas,
      @required this.id,
      @required this.eventName})
      : super(key: key);
  @override
  _PantallaReserva createState() => _PantallaReserva(entradas, id, eventName);
}

class _PantallaReserva extends State<Reserves> {
  final int entradas;
  final int id;
  final String eventName;
  int numero = 0;

  _PantallaReserva(this.entradas, this.id, this.eventName);
  @override
  Widget build(BuildContext context) {
    final levelIndicator = Container(
      child: Container(
        child: Icon(
          Icons.arrow_right_alt_sharp,
          color: Colors.white,
          size: 30.0,
        ),
      ),
    );

    final coursePrice = Container(
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        entradas.toString() + AppLocalizations.of(context).entradesDisponibles,
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );

    final courseentrades = Container(
      key: Key("courseentrades"),
      padding: const EdgeInsets.all(7.0),
      decoration: new BoxDecoration(
          border: new Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(5.0)),
      child: new Text(
        "Nombre d'entrades seleccionades: " + numero.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(color: Colors.white),
      ),
    );
    _comprovacionsreserva() {
      if (numero > entradas)
        return showAlertDialogentrades(context);
      else
        return showAlertDialog(context);
    }

    final reservaButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        key: Key("Reserva_reservaButton"),
        //width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {
            _comprovacionsreserva(),
          },
          color: Colors.blue,
          child:
              Text("Reservar entrades", style: TextStyle(color: Colors.white)),
        ));
    _comprovacionscompra() {
      if (numero > entradas)
        return showAlertDialogentrades(context);
      else
        return showAlertDialogcompra(context);
    }

    final compraButton = Container(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        key: Key("Comprar_reservaButton"),
        // width: MediaQuery.of(context).size.width,
        child: RaisedButton(
          onPressed: () => {
            _comprovacionscompra(),
          },
          color: Colors.blue,
          child:
              Text("Comprar entrades", style: TextStyle(color: Colors.white)),
        ));

    final topContentText = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 200.0,
          child: new Divider(color: Colors.green),
        ),
        SizedBox(height: 10.0),
        Text(
          "Entrades",
          style: TextStyle(color: Colors.white, fontSize: 45.0),
        ),
        SizedBox(height: 30.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(flex: 1, child: levelIndicator),
            Expanded(
                flex: 6,
                child: Padding(
                    padding: EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Entrades disponibles",
                      style: TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ))),
            Expanded(flex: 12, child: coursePrice)
          ],
        ),
        SizedBox(height: 30.0),
        Container(
            padding: EdgeInsets.symmetric(vertical: 10.0),
            key: Key("seleccionar_N_entrades"),
            // width: MediaQuery.of(context).size.width,
            child: Center(
                child: RaisedButton(
              onPressed: () => {
                showselectnumber(context),
              },
              color: Colors.blue,
              child: Text("Seleccionar entrades",
                  style: TextStyle(color: Colors.white)),
            ))),
        SizedBox(height: 10.0),
        Center(
          child: courseentrades,
        ),
      ],
    );

    final topContent = Stack(
      children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height * 0.57,
          padding: EdgeInsets.all(40.0),
          decoration: BoxDecoration(color: Colors.lightBlue),
          child: Center(
            child: topContentText,
          ),
        ),
        Positioned(
          left: 8.0,
          top: 70.0,
          child: InkWell(
            onTap: () {
              runApp(MaterialApp(
                home: Mostra(
                  idevent: id,
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
              ));
            },
            child: Icon(Icons.arrow_back, color: Colors.white),
          ),
        ),
      ],
    );

    final bottomContent = Container(
      //height: MediaQuery.of(context).size.height * 0.30,
      // width: MediaQuery.of(context).size.width,
      // color: Theme.of(context).primaryColor,
      padding: EdgeInsets.all(40.0),
      child: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            reservaButton,
            compraButton,
          ],
        ),
      ),
    );

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[topContent, bottomContent],
        ),
      ),
    );
  }

  showselectnumber(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      key: Key("Okey_selector"),
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    Widget selector =
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
      new NumberPicker.integer(
          initialValue: 0,
          minValue: 0,
          maxValue: entradas,
          key: Key("numberpicker_N_entrades"),
          onChanged: (newValue) => setState(() => numero = newValue)),
    ]);

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("Selecciona el nombre d'entrades desitjades"),
      actions: [
        selector,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogentrades(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      key: Key("Okey_button_alert_compra_1"),
      child: Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text(
          "El nombre d'entrades que intentes reservar o comprar és superior al nombre d'entrades que queden disponibles"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      key: Key("Okey_button_alert_reserva"),
      onPressed: () => _reserva(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text(
          "Si selecciones reservar has de tenir en compte que les entrades només es reservaran per 24 hores."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showAlertDialogcompra(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      key: Key("Okey_button_alert_compra_2"),
      onPressed: () => _compra(),
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("S'està processant la compra, si us plau esperi."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  _reserva() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    final RespostaReservaModel session =
        await http_reserva(stringValue, id, numero);
    if (session != null) {
      /*for (int i = 0; i < session.tickets.length; ++i)
        prefs.setStringList(
            'entrades_' + id.toString(), session.tickets[i].controller.id);*/
      Navigator.of(context).pop();
      showConfirmationDialog(context);
    } else {
      Navigator.of(context).pop();
      showErrorDialog(context);
    }
  }

  _compra() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    final RespostaReservaModel session = await compra(id, numero);
    if (session != null) {
      //prefs.setStringList('entrades_' + id.toString(), session.ticketsId);
      Navigator.of(context).pop();
      showConfirmationDialogCompra(context, session.tickets);
    } else {
      Navigator.of(context).pop();
      showErrorDialog(context);
    }
  }

  showErrorDialog(BuildContext context) {
    // set up the button

    Widget okButton = FlatButton(
        child: Text("Continuar"),
        key: Key("error_button_alert"),
        onPressed: () => {
              Navigator.of(context).pop(),
              runApp(MaterialApp(
                home: Reserves(
                  entradas: entradas,
                  id: id,
                  eventName: eventName,
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
              )),
            });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("No s'ha pogut fer l'acció si us plau torna a intentar-ho"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showConfirmationDialog(BuildContext context) {
    // set up the button

    Widget okButton = FlatButton(
        child: Text("Continuar"),
        key: Key("confirmation_button_alert_reserva"),
        onPressed: () => {
              Navigator.of(context).pop(),
              runApp(MaterialApp(
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
              )),
            });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("S'ha fer la reserva correctament de les " +
          numero.toString() +
          " entrades"),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  showConfirmationDialogCompra(BuildContext context, qrCode) {
    // set up the button

    void share(BuildContext context) {
      String message =
          "He comprat entrades per a l'event $eventName amb l'aplicació SafeEvents";
      Share.share(message);
    }

    Widget shareButton = FlatButton(
        child: Icon(Icons.share),
        onPressed: () => {
              share(context),
              Navigator.of(context).pop(),
              runApp(MaterialApp(
                home: QR(qrCode: qrCode),
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
              )),
            });

    Widget okButton = FlatButton(
        child: Text("Continuar"),
        key: Key("confirmation_button_alert_compra"),
        onPressed: () => {
              Navigator.of(context).pop(),
              runApp(MaterialApp(
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
              )),
            });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("S'ha fer la compra correctament de les " +
          numero.toString() +
          " entrades"),
      actions: [
        shareButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

/*
_compra_reserva() async {
  sleep(const Duration(seconds: 2));
  print('compra');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  final RespostaReservaModel session =
      await http_compra_reserva(stringValue, id, numero);

  if (session != null)
    prefs.setStringList('entrades_' + id.toString(), session.ticketsId);
  Navigator.of(context).pop();
  showConfirmationDialogCompra(context);
}
*/

/*
  
// Request
{
	"client_id": "",
	"event_id": "",
	"option": 0,
	"how_many": 0,
	"description": "hello world"
}
  post url 
        /purchase tener en cuenta la option
  get   /entradas pass event_id

// response
{
	"tickets_id": []
}
Tu18:23
option = 0 reserva, 1 = compra

*/
