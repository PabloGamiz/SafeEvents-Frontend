import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/FavsModel.dart';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

Future<List<FavsModel>> http_Favs() async {
  /*
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  */
  var body =
      json.encode({"cookie": "zZMZ7uE29f_olQIXSpV_AXWtPGHfBmbDuarXqSst12A="});
  var uri = Uri.http('10.4.41.148:8080', '/event/favorites');
  print(uri);
  final response = await http.put(uri, body: body);
  if (response.statusCode == 200 || response.statusCode == 201) {
    return favsModelFromJson(response.body);
  } else {
    print(response.statusCode);
    print(response.body);
    throw Exception('No favorites found');
  }
}
