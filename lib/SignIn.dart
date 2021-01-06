import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
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
FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

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
            key: Key("login_button"),
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
            key: Key("without_session"),
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

    var user = (await firebaseAuth.signInWithCredential(credential)).user;

    Map<String, String> userInfoMap = {
      "name": user.displayName,
      "email": user.email
    };
    database.uploadUserInfo(userInfoMap);

    prefs.setString('email', user.email);
    prefs.setString('user', user.displayName);

    String email = user.email;

    _firebaseMessaging.subscribeToTopic('$email');
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('onMessage: $message');
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('onLaunch: $message');
      },
      onResume: (Map<String, dynamic> message) async {
        print('onResume: $message');
      },
    );
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));

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

/*

_tancarSessio() async {
  print('5');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  print(stringValue);
  SignInModel session = await http_SignOut(stringValue);
  /*var now;
    do {
      session = await http_SignOut(stringValue);
      now = new DateTime.now();
    } while (!(session.cookie == stringValue) && (session.deadline < now));*/

  SharedPreferences preferences = await SharedPreferences.getInstance();
  await preferences.clear();
  runApp(MaterialApp(
    home: SignIn(),
  ));
}

*/
