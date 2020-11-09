import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'http_models/user_model.dart';
import 'http_requests/http_signin.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _SignInState extends State<SignIn> {
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
            onPressed: _signInWithGoogle,
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

  _signInWithGoogle() async {
    // pop up del usuario que eliges para iniciar sesion
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    /*final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);*/
    final UserModel prova = await createUser(googleAuth.idToken);
    print("json:");

    print(prova.cookie);
    print(prova.timeout);
  }
}

/*
class HomePage extends StatelessWidget {
  UserModel _user;
  final TextEditingController tokenidController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Conexion'),
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(
          children: <Widget>[
            TextField(
              controller: tokenidController,
            ),
            SizedBox(
              height: 32,
            ),
            _user == null
                ? Container()
                : Text(
                    "The cookie: ${_user.cookie} and the ${_user.time.toString()}"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final String tokenid = tokenidController.text;
          print("0_0");
          final UserModel user = await createUser(tokenid);
          print("0_1");
          _user = user;
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

/*final String tokenid = tokenidController.text;
final UserModel user = await createUser(tokenid);*/

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class _HomePageState extends State<HomePage> {
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
            onPressed: _signInWithGoogle,
            color: Colors.lightBlue,
          )
        ],
      )),
    );
  }
}
*/
