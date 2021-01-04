//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Structure.dart';
//import 'package:barcode_scanner/barcode_scanning_data.dart';

class QR extends StatefulWidget {
  List qrCode;
  int i;
  QR({Key key, @required this.qrCode, @required this.i}) : super(key: key);
  @override
  _QRstate createState() => _QRstate(qrCode, i);
}

class _QRstate extends State<QR> {
  List qrCode;
  int i;
  _QRstate(this.qrCode, this.i);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          runApp(MaterialApp(
            home: Structure(),
          ));
        },
        child: Icon(Icons.home),
        backgroundColor: Colors.lightBlue,
      ),
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height - 150,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: qrCode.length,
            itemBuilder: (context, index) {
              return QrImage(
                data: qrCode[index].controller.qrCode,
                version: QrVersions.auto,
                size: 450,
                gapless: false,
                embeddedImage: AssetImage('assets/SafeEventsBlack.png'),
                embeddedImageStyle: QrEmbeddedImageStyle(size: Size(70, 70)),
              );
            },
          ),
        ),
      ),
    );
  }
}
