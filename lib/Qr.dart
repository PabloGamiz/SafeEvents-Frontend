//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Structure.dart';

class QR extends StatefulWidget {
  var qrCode;

  QR({Key key, @required this.qrCode}) : super(key: key);
  @override
  _QRstate createState() => _QRstate(qrCode);
}

class _QRstate extends State<QR> {
  var qrCode;

  _QRstate(this.qrCode);
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
          Positioned(
            left: 8.0,
            top: 70.0,
            child: InkWell(
              onTap: () {
                runApp(MaterialApp(
                  home: Structure(),
                ));
              },
              child: Icon(Icons.arrow_back, color: Colors.black),
            ),
          ),

          //QrImage.withQr(qr: );
          QrImage(
            data: qrCode,
            version: QrVersions.auto,
            size: 320,
            gapless: false,
            embeddedImage: AssetImage('assets/SafeEventsBlack.png'),
            embeddedImageStyle: QrEmbeddedImageStyle(size: Size(80, 80)),
          )
        ],
      )),
    );
  }
}

class LectorQr extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<LectorQr> {
  String _scanResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lector códigos QR'),
      ),
      body: Center(
          child: _scanResult == null
              ? Text('Esperando datos de código')
              : Column(
                  children: [
                    Text(_scanResult),
                  ],
                )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _scanCode();
        },
        child: Icon(Icons.camera),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Future<void> _scanCode() async {
    // var result = await scanner.scan();
    setState(() {
      _scanResult = "w"; //result;
    });
  }
}

/*

{
	"cookie": "organizer cookie",
	"event_id": 1,
	"qr_code": "abcd1234567890"
}
put: /ticket/check

*/
