import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignIn extends StatelessWidget {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();

  // ignore: deprecated_member_use
  Future<FirebaseUser> _signIn(BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text('Sign in'),
    ));

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // ignore: deprecated_member_use
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // ignore: deprecated_member_use
    FirebaseUser userDetails =
        // ignore: deprecated_member_use
        (await _firebaseAuth.signInWithCredential(credential)) as FirebaseUser;

    return userDetails;
  }

  Widget build(BuildContext context) {
    return MaterialApp(
        home: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 10.0,
        ),
        Container(
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                color: Colors.white,
                // ignore: deprecated_member_use
                onPressed: () => _signIn(context)
                    .then((FirebaseUser user) => print(user))
                    .catchError((e) => print(e)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /* Icon(FontAwesomeIcons.google, color: Color(0xffCE107C),),  CAMBIAR POR IMAGEN*/
                    SizedBox(
                      width: 10.0,
                    ),
                    Text(
                      'Sign in with google',
                      style: TextStyle(color: Colors.black, fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            )),
        Container(
          width: 250.0,
          child: Align(
            alignment: Alignment.center,
            child: FlatButton(
              onPressed: () => print('Estructura'),
              /*llama a estructura*, para que depues esta muestre eventos general*/
              child: Text('Continue without sign in'),
            ),
          ),
        ),
      ],
    ));
  }
}

class UserDetails {
  final String providerDetails;
  final String username;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.username, this.photoUrl,
      this.userEmail, this.providerData);
}

class ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}
