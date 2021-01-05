import 'dart:async';
import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:safeevents/Structure.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
        backgroundColor: Colors.black,
        title: Text('Scanning'),
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
                "Començament de l'escanner",
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
                "Pulsar per detenir l'escanner",
                style: TextStyle(color: Colors.white, fontSize: 15),
              ),
            ),
            onPressed: (bluetooth),
            color: Colors.grey,
          ), /*
          Container(
            key: Key("scanning"),
            width: 250.0,
            child: Align(
              alignment: Alignment.center,
              child: FlatButton(
                onPressed: () => stop(),
                child: Text(
                  "Pulsar per detenir l'escanner",
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),*/
        ],
      )),
    );
  }

  stop() {
    exit = true;
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
    // set up the button
    Widget okButton = FlatButton(
      key: Key("Avis_scan"),
      child: Text("OK"),
      onPressed: () {},
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Avis"),
      content: Text("Scanning"),
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
    Timer timer;
    print("exit: " + exit.toString());
    while (!exit) {
      if (scan) {
        print("scannning");

        final List<String> nameDevice = new List();
        FlutterBlue flutterBlue = FlutterBlue.instance;
        flutterBlue.startScan(timeout: Duration(seconds: 20));
        // Listen to scan results
        var subscription = flutterBlue.scanResults.listen((results) {
          // do something with scan results
          for (ScanResult r in results) {
            nameDevice.add(r.device.name);
            print(r.device.name);
            //r.device.connect();
          }
        });

        // Stop scanning
        flutterBlue.stopScan();
        print("interaction");
        final interaction = await http_radar_interaction(nameDevice);
        print("sleep");
        await new Future.delayed(const Duration(seconds: 15));
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

/*
print("scanning");
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

    FlutterBlue flutterBlue = FlutterBlue.instance;
    flutterBlue.startScan(timeout: Duration(seconds: 4));

// Listen to scan results
    var subscription = flutterBlue.scanResults.listen((results) {
      // do something with scan results
      for (ScanResult r in results) {
        print('${r.device.name} found! rssi: ${r.rssi}');
        print('r.device.id= ${r.device.id}');
        //r.device.connect();
      }
    });

    // Stop scanning
    flutterBlue.stopScan();*/
