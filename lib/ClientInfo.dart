import 'dart:io';

import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safeevents/EsdevenimentEspecific.dart';
import 'package:safeevents/EventsGeneral.dart';
import 'package:safeevents/Qr.dart';
import 'package:safeevents/SignIn.dart';
import 'package:safeevents/Structure.dart';
import 'package:safeevents/http_models/resposta_reserva_model.dart';
import 'package:safeevents/payment.dart';
import 'package:safeevents/scan.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bluetooth.dart';
import 'http_models/GeneralEventsModel.dart';
import 'http_models/SignIn_model.dart';
import 'http_models/get_tickets_model.dart';
import 'http_requests/http_clientInfo.dart';
import 'http_models/ClientInfoModel.dart';
import 'http_requests/http_entrades.dart';
import 'http_requests/http_generalevents.dart';
import 'http_requests/http_pasarQr.dart';
import 'http_requests/http_signout.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ClientInfo extends StatefulWidget {
  final int id;

  ClientInfo(this.id);

  _ClientInfoState createState() => _ClientInfoState();
}

class _ClientInfoState extends State<ClientInfo> {
  Future<ClientInfoMod> futureClient;
  var dropdownValue = "Reservas";
  List<Purchased> selected = new List();
  String result = "Hey there !";
  int eventid = 1;
  Map<int, ListEsdevenimentsModel> generalEvents = Map();

  @override
  void initState() {
    super.initState();
    futureClient = fetchClient(widget.id);
    http_GeneralEvents().then((eventsFromServer) {
      setState(() {
        generalEvents = Map.fromIterable(eventsFromServer,
            key: (event) => event.id, value: (event) => event);
      });
    });
  }

  Future _scanQr(int event_id) async {
    try {
      String qrResult = await BarcodeScanner.scan();
      setState(() {
        result = qrResult;

        Future<int> ok = http_pasarQr(result, event_id);
      });
    } on PlatformException catch (ex) {
      if (ex.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          result = "Camera permission was denied";
        });
      } else {
        setState(() {
          result = "Unknown Error $ex";
        });
      }
      showAlertDialog(context);
    } on FormatException {
      setState(() {
        result = "You pressed the back button before scanning anything";
      });
      showAlertDialog(context);
    } catch (ex) {
      setState(() {
        result = "Unknown Error $ex";
      });
      showAlertDialog(context);
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the button

    Widget okButton = FlatButton(
        child: Text("Okey"),
        key: Key("showAlertDialog"),
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
      title: Text("Error"),
      content: Text(result),
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

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ClientInfoMod>(
      future: futureClient,
      builder: (context, snapshot) {
        if (snapshot.hasData && generalEvents.isNotEmpty) {
          if (widget.id == 0)
            return buildProfileWidget(snapshot);
          else
            return buildClientInfoWidget(snapshot);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        // By default, show a loading spinner.
        return CircularProgressIndicator();
      },
    );
  }

  Widget buildProfileWidget(AsyncSnapshot<ClientInfoMod> snapshot) {
    var client = snapshot.data;
    var assistant = client.assists;
    var organizer = client.organize;
    selected = _selectTicket(dropdownValue, assistant);
    return Column(
      children: [
        generalInfo(client),
        DropdownButton(
          value: dropdownValue,
          elevation: 16,
          items: ["Reservas", "Entradas", "Eventos organizados"]
              .map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          style: TextStyle(color: Colors.lightBlue),
          underline: Container(
            height: 2,
            color: Colors.lightBlue,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
              if (dropdownValue != "Eventos organizados")
                selected = _selectTicket(dropdownValue, assistant);
            });
          },
        ),
        if (dropdownValue != "Eventos organizados")
          _ticketsList()
        else
          _eventsList(organizer)
      ],
    );
  }

  Widget _ticketsList() {
    if (selected.length != 0)
      return Expanded(
        child: ListView(
          children: selected.map(_buildTicketWidget).toList(),
          shrinkWrap: true,
        ),
      );
    else
      return Text("No tienes " + dropdownValue);
  }

  Widget _eventsList(Organize organizer) {
    if (organizer.organizes.length != 0)
      return Expanded(
        child: ListView(
          children: organizer.organizes.map(_buildEventWidget).toList(),
          shrinkWrap: true,
        ),
      );
    else
      return Expanded(
        child: Text("No organiza ningun evento"),
      );
  }

  Widget buildClientInfoWidget(AsyncSnapshot<ClientInfoMod> snapshot) {
    var client = snapshot.data;
    var organizer = client.organize;
    return Column(
      children: [
        generalInfo(client),
        Container(
          child: Text(
            "Eventos organizados",
            style: TextStyle(
                color: Colors.black,
                decoration: TextDecoration.underline,
                decorationColor: Colors.lightBlue,
                decorationThickness: 2),
          ),
          margin: EdgeInsets.symmetric(vertical: 10),
        ),
        if (organizer.organizes.length != 0)
          Expanded(
            child: ListView(
              children: organizer.organizes.map(_buildEventWidget).toList(),
              shrinkWrap: true,
            ),
          )
        else
          Expanded(
            child: Text("No organiza ningun evento"),
          ),
      ],
      mainAxisAlignment: MainAxisAlignment.center,
    );
  }

  Widget generalInfo(client) {
    return Card(
      color: Colors.lightBlue,
      child: Column(
        children: [
          Row(
            children: [
              Container(
                child: Text(
                  client.email,
                  style: TextStyle(color: Colors.white),
                ),
                margin: EdgeInsets.symmetric(vertical: 20),
              )
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
          Row(
            children: [
              if (widget.id == 0)
                FlatButton(
                  onPressed: () => _tancarSessio(),
                  child: Icon(
                    Icons.exit_to_app,
                    color: Colors.white,
                  ),
                ),
              if (widget.id == 0)
                FlatButton(
                  onPressed: () {
                    runApp(
                      MaterialApp(
                        home: Bluetooth(),
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
                            if (supportedLocale.languageCode ==
                                locale.languageCode) return supportedLocale;
                          }
                          return supportedLocales.first;
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.location_on,
                    color: Colors.white,
                  ),
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
      ),
    );
  }

  Widget _buildEventWidget(Fav event) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 4.0,
      ),
      child: Card(
        color: Colors.lightBlue,
        child: ListTile(
          onTap: () {
            runApp(
              MaterialApp(
                home: Mostra(idevent: event.id),
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
                    Text(event.checkInDate.toString().substring(0, 16),
                        style: TextStyle(color: Colors.white)),
                    Container(
                      height: 5,
                    ),
                    Text(event.tipus, //filteredEvents[index].category,
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
              FlatButton(
                onPressed: () => _scanQr(event.id),
                child: Icon(
                  Icons.qr_code_scanner,
                  color: Colors.white,
                ),
                minWidth: 0.5,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTicketWidget(Purchased purchase) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 1.0,
        horizontal: 4.0,
      ),
      child: Card(
        color: Colors.lightBlue,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(generalEvents[purchase.eventId].title,
                    style: TextStyle(fontSize: 30, color: Colors.white)),
              ),
            ],
          ),
          subtitle: Row(
            children: [
              Row(
                children: [
                  Container(
                    child: Text(
                      generalEvents[purchase.eventId].price.toString() + '€',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                      maxLines: 2,
                      overflow: TextOverflow.fade,
                    ),
                    margin: EdgeInsets.only(right: 15),
                    alignment: Alignment.centerLeft,
                  ),
                  Column(
                    children: [
                      Text(
                        generalEvents[purchase.eventId]
                            .checkInDate
                            .toString()
                            .substring(0, 10),
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                      Text(
                        generalEvents[purchase.eventId]
                            .checkInDate
                            .toString()
                            .substring(11, 16),
                        style: TextStyle(fontSize: 14, color: Colors.white),
                        maxLines: 2,
                        overflow: TextOverflow.fade,
                      ),
                    ],
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              if (purchase.option == 1)
                FlatButton(
                  onPressed: () => _mostrarqr(),
                  child: Icon(
                    Icons.qr_code,
                    color: Colors.white,
                  ),
                )
              else
                FlatButton(
                  onPressed: () => _compra_reserva(
                      purchase.eventId, generalEvents[purchase.eventId].title),
                  child: Icon(
                    Icons.payment,
                    color: Colors.white,
                  ),
                ),
            ],
            mainAxisAlignment: MainAxisAlignment.start,
          ),
        ),
      ),
    );
  }

  List<Purchased> _selectTicket(String type, Assists assistant) {
    selected.clear();
    if (type == "Reservas") {
      if (assistant != null && assistant.purchased.length != 0) {
        for (int i = 0; i < assistant.purchased.length; ++i) {
          if (assistant.purchased[i].option == 0 &&
              generalEvents.containsKey(assistant.purchased[i].eventId)) {
            selected.add(assistant.purchased[i]);
          }
        }
      }
    } else if (type == "Entradas" && assistant != null) {
      if (assistant != null && assistant.purchased.length != 0) {
        for (int i = 0; i < assistant.purchased.length; ++i) {
          if (assistant.purchased[i].option == 1 &&
              generalEvents.containsKey(assistant.purchased[i].eventId)) {
            selected.add(assistant.purchased[i]);
          }
        }
      }
    }
    return selected;
  }

  showAlertDialogcompra(BuildContext context, int id, String name) {
    Widget okButton = FlatButton(
      child: Text("OK"),
      key: Key("Okey_button_alert_compra_2"),
      onPressed: () => _compra(id, name),
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

  compra(int id) async {
    //sleep(const Duration(seconds: 2));
    print('compra');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    RespostaReservaModel session = await http_compra_reserva(stringValue, id);
    for (int i = 0; i < session.tickets.length; ++i) {
      var resposta = paypal(session.tickets[i].controller.id);
    }

    return session;
  }

  _compra(int id, String name) async {
    final RespostaReservaModel session = await compra(id);
    Navigator.of(context).pop();
    if (session != null) {
      showConfirmationDialogCompra(context, session.tickets, id, name);
    } else {
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
                home: Structure(),
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

  showConfirmationDialogCompra(
      BuildContext context, qrCode, int id, String eventName) {
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
              )),
            });

    Widget okButton = FlatButton(
        child: Text("Continuar"),
        key: Key("confirmation_button_alert_compra"),
        onPressed: () => {
              Navigator.of(context).pop(),
              runApp(MaterialApp(
                home: Structure(),
              )),
            });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("S'ha fer la compra correctament de les " +
          1.toString() +
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

  _compra_reserva(int id, String name) async {
    print('compra reserva');
    showAlertDialogcompra(context, id, name);

    /*runApp(MaterialApp(
      home: QR(qrCode: session.tickets),
    ));*/
  }

  _mostrarqr() async {
    print('mostrar qr');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    List<GetTicketsModel> session =
        await http_get_tickets(stringValue, eventid);
    print(session.first.qrCode);
    runApp(MaterialApp(
      home: QR(qrCode: session),
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

  _tancarSessio() async {
    print('cerrar session');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    print(stringValue);
    SignInModel session = await http_SignOut(stringValue);
    prefs.setString('cookie', null);
    runApp(MaterialApp(
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
    ));
  }
}
