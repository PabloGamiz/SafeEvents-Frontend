import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'Structure.dart';
import 'http_models/SignIn_model.dart';
import 'http_requests/http_signin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'services/database.dart';
import 'package:http/http.dart' as http;

//esto es chat
class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
final DatabaseMethods database = new DatabaseMethods();

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Sign-In'),
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
            onPressed: (_signInWithGoogle),
            color: Colors.lightBlue,
          ),
          Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () =>
                    _launchStructure() /*llama a estructura, para que depues esta muestre eventos general*/,
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
    print(googleAuth.idToken);
    final SignInModel session = await http_SignIn(googleAuth.idToken);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString('cookie', session.cookie);
    prefs.setInt('timeout', session.deadline);

    AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    FirebaseUser user =
        (await firebaseAuth.signInWithCredential(credential)).user;

    if (database.getUserByUsername(user.displayName) == null) {
      //mirar que el usuario no este en la base de datos
      Map<String, String> userInfoMap = {
        "name": user.displayName, //obtener nombre del perfil de google,
        "email": user.email //obtener email del perfil de google
      };
      database.uploadUserInfo(userInfoMap);
    }

    prefs.setString('email', user.email);
    prefs.setString('user', user.displayName);

    runApp(MaterialApp(
      home: Structure(),
    ));
  }

  _launchStructure() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('cookie', null);
    preferences.setInt('timeout', null);

    await preferences.clear();

    runApp(MaterialApp(
      home: Structure(),
    ));
  }
}
