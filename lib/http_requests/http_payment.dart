import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/SignIn_model.dart';
import 'package:safeevents/http_models/preuModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

http_preu(int id) async {
  final String apitUrl = "http://10.4.41.148:8080/ticketprice";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  var queryParamaters = {
    'cookie': stringValue,
    'ticket_id': id,
  };

  final jsonCliend = json.encode(queryParamaters);
  final response = await http.put(apitUrl, body: jsonCliend);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return preuModelFromJson(response.body);
  } else {
    print(response.statusCode);
    print(response.body);
    return null;
  }
}

http_sendpayinfo(String jsonCliend) async {
  final String apitUrl = "http://10.4.41.148:8080/ticket/paypal";
  final response = await http.put(apitUrl, body: jsonCliend);
  print(response.statusCode);
  print(response.body);
  return response.statusCode;
}
