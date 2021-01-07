import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/SignIn_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

http_radar_activate(String name) async {
  final String apitUrl = "http://10.4.41.148:8080/radar/activate";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  var queryParamaters = {'cookie': stringValue, 'mac': name};
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.put(apitUrl, body: jsonCliend);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return json.decode(responseString);
  } else {
    return null;
  }
}

Future<int> http_radar_deactivate(String name) async {
  final String apitUrl = "http://10.4.41.148:8080/radar/activate";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  var queryParamaters = {'cookie': stringValue, 'mac': name};
  final jsonCliend = json.encode(queryParamaters);
  print(1);
  http.Request rq = http.Request('DELETE', Uri.parse(apitUrl));
  rq.body = jsonCliend;
  print("comença");
  final response = await http.Client().send(rq);

  print("acaba");
  print(response.statusCode);
  print(response.reasonPhrase);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.statusCode.toString();
    return json.decode(responseString);
  } else {
    return null;
  }
}

http_radar_interaction(List<String> nameDevice) async {
  final String apitUrl = "http://10.4.41.148:8080/radar/interaction";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  print("query");
  var queryParamaters = {
    'cookie': stringValue,
    'close_to': nameDevice,
    'instant': DateTime.now().toUtc().millisecondsSinceEpoch.toInt(),
  };

  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return json.decode(responseString);
  } else {
    return null;
  }
}

http_status(int status) async {
  final String apitUrl = "http://10.4.41.148:8080/status";
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  print("query");
  var queryParamaters = {
    'cookie': stringValue,
    'status': status,
    'date': DateTime.now().toUtc().millisecondsSinceEpoch.toInt(),
  };

  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return json.decode(responseString);
  } else {
    return null;
  }
}
