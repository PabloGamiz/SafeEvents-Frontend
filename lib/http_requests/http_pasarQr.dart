import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<int> http_pasarQr(String result, int event_id) async {
  final String apitUrl = "http://10.4.41.148:8080/ticket/check";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String sessio = prefs.getString('cookie');
  var queryParamaters = {
    "cookie": sessio,
    "event_id": event_id,
    "qr_code": result,
  };
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  print(response.statusCode);
  print(json.decode(response.body));
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return json.decode(responseString);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}
