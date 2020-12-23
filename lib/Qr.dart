//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Structure.dart';
//import 'package:barcode_scanner/barcode_scanning_data.dart';

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
