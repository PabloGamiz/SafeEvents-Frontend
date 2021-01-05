import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
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
  final String apitUrl = "http://10.4.41.148:8080/ticket/purchase";
  var queryParamaters = {
    "cookie": stringValue,
    "event_id": id,
    "option": 0,
    "how_many": howmany,
    "description": "testing"
  };
  print(stringValue);
  String reservaModel = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: reservaModel);
  print(response.statusCode);
  print(response.body);
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
  final String apitUrl = "http://10.4.41.148:8080/ticket/purchase";
  var queryParamaters = {
    "cookie": stringValue,
    "event_id": id,
    "option": 1,
    "how_many": howmany,
    "description": "testing"
  };
  String reservaModel = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: reservaModel);
  print(response.statusCode);
  print(response.body);
  if (response.statusCode == 201 || response.statusCode == 200) {
    return respostaReservaModelFromJson(response.body);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

Future<RespostaReservaModel> http_compra_reserva(
    String stringValue, int id, int howmany) async {
  final String apitUrl = "http://10.4.41.148:8080/ticket/activate";
  var queryParamaters = {
    'cookie': stringValue,
    'event_id': id,
    'how_many': howmany,
  };
  String reservaModel = json.encode(queryParamaters);
  final response = await http.put(apitUrl, body: reservaModel);
  print(response.statusCode);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print(response.body);
    return respostaReservaModelFromJson(response.body);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

Future<RespostaReservaModel> http_get_tickets(
    String stringValue, int id) async {
  final String apitUrl = "http://10.4.41.148:8080/ticket";
  var queryParamaters = {'cookie': stringValue, 'event_id': id};
  String dades = json.encode(queryParamaters);
  final uri = Uri.http('http://10.4.41.148:8080', '/ticket', queryParamaters);
  http.Request rq = http.Request('GET', Uri.parse(apitUrl));
  rq.body = dades;
  print("comença");
  final response = await http.Client().send(rq);
  //final request = Request('GET', 'http://10.4.41.148:8080/ticket');
  //request.body = dades;
  //final response = request.send().stream.first;
  //final response = await http.get(uri);
  print(response.statusCode);
  print(response.reasonPhrase);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print(response.reasonPhrase);
    return respostaReservaModelFromJson(response.reasonPhrase);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

/*
APIActivatePath = "/ticket/activate"
*/
