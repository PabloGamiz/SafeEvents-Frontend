import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/SignIn_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

http_preu(int id) async {
  final String apitUrl = "http://10.4.41.148:8080/signin";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  var queryParamaters = {'event_id': id, 'cookie': stringValue};

  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return responseString;
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

http_sendpayinfo(String jsonCliend) async {
  final String apitUrl = "http://10.4.41.148:8080/signin";
  final response = await http.post(apitUrl, body: jsonCliend);
  return response.statusCode;
}
