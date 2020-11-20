import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:safeevents/http_models/Reserva_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Structure.dart';
import 'http_models/resposta_reserva_model.dart';
import 'http_requests/http_entrades.dart';

class Reserves extends StatefulWidget {
  final int entradas;
  final int id;
  const Reserves({Key key, @required this.entradas, @required this.id})
      : super(key: key);
  @override
  _PantallaReserva createState() => _PantallaReserva(entradas, id);
}

class _PantallaReserva extends State<Reserves> {
  final int entradas;

  final int id;

  _PantallaReserva(this.entradas, this.id);

  final _controller = TextEditingController();

  set clientId(String clientId) {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign-In Demo'),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Encare quedan " +
              entradas.toString() +
              " per reservar o camprar d'aquest event"),
          //"Si selecciones reservar has de tenir en compte que les entrades nomes es reservaran per 24 hores"
          Container(
            width: 225.0,
            child: Align(
              alignment: Alignment.center,
              child: TextFormField(
                /*Presta atención a la siguiente línea:*/
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value.isEmpty) {
                    return "Quantitat d'entrades desitjades";
                  }
                  return null;
                },
                controller: _controller,
                decoration: InputDecoration(
                  hintText: "Quantitat",
                  labelText: "Quantitat d'entrades desitjades",
                ),
              ),
            ),
          ),
          Container(
            width: 350.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                child: Text("Reservar la quantitat seleccionada d'entrades"),
                onPressed: () {
                  if (int.parse(_controller.text) > 0) showAlertDialog(context);
                },
              ),
            ),
          ),
          Container(
            width: 350.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                  child: Text("Comprar la quantitat seleccionada d'entrades"),
                  onPressed: () {
                    if (int.parse(_controller.text) > 0)
                      showAlertDialogcompra(context);
                  }),
            ),
          ),
        ],
      )),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () => _reserva(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text(
          "Si selecciones reservar has de tenir en compte que les entrades nomes es reservaran per 24 hores."),
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

  _wait() {}
  showAlertDialogcompra(BuildContext context) {
    Widget okButton = FlatButton(
      child: Text("OK"),
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
    print('reserva');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    print('1');
    final RespostaReservaModel session =
        await http_reserva(stringValue, id, int.parse(_controller.text));
    print('1');

    if (session != null)
      prefs.setStringList('entrades_' + id.toString(), session.ticketsId);
    Navigator.of(context).pop();
    showConfirmationDialog(context);
  }

  _compra() async {
    sleep(const Duration(seconds: 2));
    print('compra');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String stringValue = prefs.getString('cookie');
    print('1');
    final RespostaReservaModel session =
        await http_reserva(stringValue, id, int.parse(_controller.text));
    print('1');

    if (session != null)
      prefs.setStringList('entrades_' + id.toString(), session.ticketsId);
    Navigator.of(context).pop();
    showConfirmationDialogCompra(context);
  }

  showConfirmationDialog(BuildContext context) {
    // set up the button

    Widget okButton = FlatButton(
        child: Text("Continuar"),
        onPressed: () => {
              Navigator.of(context).pop(),
              runApp(MaterialApp(
                home: Structure(),
              )),
            });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("S'ha fer la reserva correctament de les " +
          _controller.text +
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

  showConfirmationDialogCompra(BuildContext context) {
    // set up the button

    Widget okButton = FlatButton(
        child: Text("Continuar"),
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
          _controller.text +
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
}

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
