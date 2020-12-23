import 'package:flutter/material.dart';

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
          "Funcionalitat no disponible",
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
      "Si vols accedir a aquesta funcionalitat si us plau inicia sessió amb Google",
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
            ),
          ),
          color: Colors.blue,
          child: Text("Sing in", style: TextStyle(color: Colors.white)),
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

/*import 'package:flutter/material.dart';

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
*/
