import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safeevents/http_models/ClientInfoModel.dart';

Future<ClientInfoMod> fetchClient(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  var uri = Uri.http('10.4.41.148:9090', '/clientInfo/');
  var body;
  if (id != 0) {
    body = {"id": id, "cookie": stringValue};
  } else {
    body = {"id": 0, "cookie": stringValue};
  }
  final response = await http.put(
    uri,
    body: body,
  );
  if (response.statusCode == 200) {
    return ClientInfoMod.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
