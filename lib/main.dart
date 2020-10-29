import 'dart:convert';
import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

import 'SignIn.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class Album {
  final Int64 deadline;
  final String cookie;

  Album({this.deadline, this.cookie});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      deadline: json['timeout'],
      cookie: json['cookie'],
    );
  }
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

  _signInWithGoogle() async {
    // pop up del usuario que eliges para iniciar sesion
    final GoogleSignInAccount googleUser = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    {
      /*Future<Album> createAlbum(String title) {
        return http.post(
          'http://10.4.41.148:9090/signin',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "token_id": googleAuth.idToken,
          }),
        );
        if (response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          return Album.fromJson(jsonDecode(response.body));
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      }
    }*/

      Future<Album> createAlbum(String title) async {
        final http.Response response = await http.post(
          'http://10.4.41.148:9090/signin',
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: jsonEncode(<String, String>{
            "token_id": googleAuth.idToken,
          }),
        );
        if (response.statusCode == 201) {
          // If the server did return a 201 CREATED response,
          // then parse the JSON.
          return Album.fromJson(jsonDecode(response.body));
        } else {
          // If the server did not return a 201 CREATED response,
          // then throw an exception.
          throw Exception('Failed to load album');
        }
      }

      final FirebaseUser user =
          (await firebaseAuth.signInWithCredential(credential)).user;
    }
    FirebaseAuth.instance.signOut();
    FirebaseUser user = FirebaseAuth.instance.currentUser;

    runApp(new MaterialApp(
      home: new SignIn(),
    ));
  }
}
