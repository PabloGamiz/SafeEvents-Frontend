import 'package:flutter/material.dart';

class IniciarSessio extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(Column(
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /* Icon(FontAwesomeIcons.google, color: Color(0xffCE107C),),  CAMBIAR POR IMAGEN*/
                          SizedBox(
                            width: 10.0,
                          ),
                          Text(
                            'Sign in with google',
                            style: (TextStyle(color: Colors.black, fontSize: 18.0),
                          ),
                        ],
                      ),
                      
              )
            )
          )
        ],
      )),
    );
  }
}
