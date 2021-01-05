//import 'package:qrscan/qrscan.dart' as scanner;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'Structure.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//import 'package:barcode_scanner/barcode_scanning_data.dart';

class QR extends StatefulWidget {
  List qrCode;
  QR({Key key, @required this.qrCode}) : super(key: key);
  @override
  _QRstate createState() => _QRstate(qrCode);
}

class _QRstate extends State<QR> {
  List qrCode;
  _QRstate(this.qrCode);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          runApp(MaterialApp(
            home: Structure(),
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('en', ''),
              const Locale('es', ''),
              const Locale('ca', ''),
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale.languageCode)
                  return supportedLocale;
              }
              return supportedLocales.first;
            },
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
                data: qrCode[index].qrCode,
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
