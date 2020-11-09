import 'package:flutter/material.dart';

class PantallaPrincipal extends StatefulWidget {
  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
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
                'Sign-In with Google',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            onPressed: _funcion(),
            color: Colors.lightBlue,
          ),
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () => print(
                    'boton presinado') /*llama a estructura, para que depues esta muestre eventos general*/,
                child: Text(
                  'Continue as guest user',
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

  _funcion() {
    print('vamos bien');
  }
}
