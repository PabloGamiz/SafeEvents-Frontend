import 'package:flutter/material.dart';

import 'SignIn.dart';

class Nologin extends StatefulWidget {
  @override
  _NologinState createState() => _NologinState();
}

class _NologinState extends State<Nologin> {
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
          Text(
            'Aquesta funcionalitat nomes esta disponible per usuaris registrats, si vols acedir-hi registrat o iniciar sessio en el següent boto',
            style: TextStyle(fontSize: 30),
            textAlign: TextAlign.center,
          ),
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () =>
                    _signInWithGoogle() /*llama a estructura, para que depues esta muestre eventos general*/,
                child: Text(
                  'Sign-In',
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

  _signInWithGoogle() {
    runApp(MaterialApp(
      home: SignIn(),
    ));
  }
}
