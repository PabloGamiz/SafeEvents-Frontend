import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safeevents/Structure.dart';

import 'http_requests/http_bluetooth.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Bluetooth extends StatefulWidget {
  @override
  _BluetoothState createState() => _BluetoothState();
}

bool exit = false;
bool start = false;
bool scan = false;

class _BluetoothState extends State<Bluetooth> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Container(
          height: 55,
          child: Center(
            child: Image(
              image: AssetImage('assets/SafeEventsBlack.png'),
            ),
          ),
        ),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          FlatButton(
            key: Key("scan"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context).startscanning,
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            onPressed: (bluetooth),
            color: Colors.lightBlue,
          ),
          FlatButton(
            key: Key("scanning"),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                AppLocalizations.of(context).stopscanning,
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            onPressed: () => {stop()},
            color: Colors.grey,
          ),
        ],
      )),
    );
  }

  stop() {
    exit = true;
    print(start);
    if (!start) {
      runApp(
        MaterialApp(
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
        ),
      );
    }
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(AppLocalizations.of(context).avis),
      content: Text(AppLocalizations.of(context).avisscanning),
      actions: [],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bluetooth() async {
    exit = false;
    start = true;
    print("scanning");
    showAlertDialog(context);
    await new Future.delayed(const Duration(seconds: 2));
    String deviceName;
    String deviceVersion;
    String identifier;
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    try {
      if (Platform.isAndroid) {
        var build = await deviceInfoPlugin.androidInfo;
        deviceName = build.model;
        deviceVersion = build.version.toString();
        identifier = build.androidId; //UUID for Android
      } else if (Platform.isIOS) {
        var data = await deviceInfoPlugin.iosInfo;
        deviceName = data.name;
        deviceVersion = data.systemVersion;
        identifier = data.identifierForVendor; //UUID for iOS
      }
    } on PlatformException {
      print('Failed to get platform version');
    }
    print(deviceName);
    print(deviceVersion);
    print(identifier);
    print("activate");
    final activate = await http_radar_activate(deviceName);
    await new Future.delayed(const Duration(seconds: 3));
    scan = true;
    Navigator.of(context).pop();
    print("scan");
    await scan_device();
    print("deactivate");
    final deactivate = await http_radar_deactivate(deviceName);
  }

  scan_device() async {
    print("exit: " + exit.toString());
    while (!exit) {
      if (scan) {
        print("scannning");

        final List<String> nameDevice = new List();
        FlutterBlue flutterBlue = FlutterBlue.instance;
        flutterBlue.startScan(timeout: Duration(seconds: 10));
        // Listen to scan results
        var subscription = flutterBlue.scanResults.listen((results) {
          // do something with scan results
          for (ScanResult r in results) {
            nameDevice.add(r.device.name);
            print("---------");
            print("---------");
            print("name: " + r.device.name);
            print("---------");
            print("---------");
            //r.device.connect();
          }
        });

        // Stop scanning
        flutterBlue.stopScan();
        print("interaction");
        final interaction = await http_radar_interaction(nameDevice);
        print("sleep");
        await new Future.delayed(const Duration(seconds: 5));
        //sleep(const Duration(seconds: 15));
      }
      if (exit) {
        runApp(
          MaterialApp(
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
          ),
        );
      }
      print("exit: " + exit.toString());
    }
  }
}
