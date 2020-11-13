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
          FlatButton(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Boton que no hace nada',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            onPressed: () => print('boton presinado'),
            color: Colors.lightBlue,
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

  _reserva() {}
}
