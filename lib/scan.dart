import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/services.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

scan() async {
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
  flutterBlue.startScan(timeout: Duration(seconds: 1));

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
  flutterBlue.stopScan();
}
