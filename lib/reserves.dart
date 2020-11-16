import 'package:flutter/material.dart';

class Reserves extends StatefulWidget {
  @override
  _PantallaReserva createState() => _PantallaReserva();
}

class _PantallaReserva extends State<Reserves> {
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
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () =>
                    _reserva() /*llama a estructura, para que depues esta muestre eventos general*/,
                child: Text(
                  'Tancar sessió',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () =>
                    _reserva() /*llama a estructura, para que depues esta muestre eventos general*/,
                child: Text(
                  'Tancar sessió',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }

  _reserva() {
    /*   18:27
// Request
{
	"client_id": "",
	"event_id": "",
	"option": 0,
	"how_many": 0,
	"description": "hello world"
}

// response
{
	"tickets_id": []
}
Tu18:23
option = 0 reserva, 1 = compra

*/
  }
}
