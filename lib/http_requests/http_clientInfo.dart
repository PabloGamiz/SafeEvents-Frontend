import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:safeevents/http_models/ClientInfoModel.dart';

Future<Client> fetchClient(int id) async {
  var uri;
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  if (id != 0) {
    var queryParameters = {'id': id.toString()};
    uri = Uri.http('10.4.41.148:9090', '/clientInfo/', queryParameters);
  } else {
    uri = Uri.http('10.4.41.148:9090', '/clientInfo/');
  }
  final response = await http.get(
    uri,
    headers: {HttpHeaders.authorizationHeader: stringValue},
  );
  if (response.statusCode == 200) {
    return Client.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}
