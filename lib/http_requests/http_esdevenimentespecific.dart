import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/EsdevenimentEspecificModel.dart';

Future<Controller> http_esdevenimentespecific(int id) async {
  print('hola');
  final String apitUrl = "http://10.4.41.148:8080/event/single";
  var queryParamaters = {'id': id};
  final jsonID = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonID);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final Controller list = _parseEvents(response.body);
    return list;
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

Controller _parseEvents(String responseBody) {
  final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parse.map<Controller>((json) => Controller.fromJson(json));
}
