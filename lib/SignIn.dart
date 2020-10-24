import 'package:flutter/material.dart';

class IniciarSessio extends StatelessWidget {

  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn(); 

  Future<FirebaseUser> _signIn (BuildContext context) async {
    Scaffold.of(context).showSnackBar(new SnackBar(
      content: new Text ( 'Sign in'),
      ));

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authetication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    FirebaseUser userDetails = await _firebaseAuth.signInWithCredential(credential);
    ProviderDetails providerInfo = new ProviderDetails(userDetails.providerId);   

    List<ProviderDetails> providerData = new List<ProviderDetails>();
    providerData.add(providerInfo);

    UserDetails details = new UserDetails(userDetails.providerId,  userDetails.displayName, userDetails.photoUrl, userDetails.email, providerData);
  
    Navigator.push(context,
    new MaterialPageRoute(
      builder: (context) => new ProfileScreen(detailsUser: details))
      );
      return userDetails;  
  }


  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
              child: Column(
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
                        onPressed: () => _signIn(context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                                /* Icon(FontAwesomeIcons.google, color: Color(0xffCE107C),),  CAMBIAR POR IMAGEN*/
                            SizedBox(
                              width: 10.0,
                            ),
                            Text(
                              'Sign in with google',
                              style: (
                                TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0
                                ),
                              ),
                            ),
                          ],
                        ),        
                      ),
                    )
                  ),
                  Container(
                    width: 250.0,
                    child: Align(
                      alignment: Alignment.center,
                      child: FlatButton (
                        onPressed: () => /*llama a estructura*, para que depues esta muestre eventos general*/,
                        child: Text (
                          'Continue without sign in'
                        ),
                      ),
                    ),
                  ),
                ],
              )
      )
    );
  }
}

class UserDetails {

  final String  providerDetails;
  final String username;
  final String photoUrl;
  final String userEmail;
  final List<ProviderDetails> providerData;
  UserDetails(this.providerDetails, this.username, this.photoUrl, this.userEmail, this.providerData);

}

class  ProviderDetails {
  ProviderDetails(this.providerDetails);
  final String providerDetails;
}