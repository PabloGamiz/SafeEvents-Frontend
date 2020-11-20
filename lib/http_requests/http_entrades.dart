import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/Reserva_model.dart';
import 'package:safeevents/http_models/resposta_reserva_model.dart';

Future<int> http_entradas(int id) async {
  final String apitUrl =
      "http://10.4.41.148:8080/entradas/?event_id=" + id.toString();
  final response = await http.get(apitUrl);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return int.parse(response.body);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

Future<RespostaReservaModel> http_reserva(
    String stringValue, int id, int howmany) async {
  final String apitUrl = "http://10.4.41.148:8080/purchase";
  var queryParamaters = {
    'clientId': stringValue,
    'eventId': id.toString(),
    'option': 0,
    'howMany': howmany,
    'desciption': "Hello world",
  };
  String reservaModel = json.encode(queryParamaters);
  final jsonCliend = json.encode(reservaModel);
  final response = await http.post(apitUrl, body: jsonCliend);
  print(response.statusCode);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return respostaReservaModelFromJson(response.body);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

Future<RespostaReservaModel> http_compra(
    String stringValue, int id, int howmany) async {
  final String apitUrl = "http://10.4.41.148:8080/purchase";
  var queryParamaters = {
    'clientId': stringValue,
    'eventId': id.toString(),
    'option': 1,
    'howMany': howmany,
    'desciption': "Hello world",
  };
  String reservaModel = json.encode(queryParamaters);
  final jsonCliend = json.encode(reservaModel);
  final response = await http.post(apitUrl, body: jsonCliend);
  print(response.statusCode);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return respostaReservaModelFromJson(response.body);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}
