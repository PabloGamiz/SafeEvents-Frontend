import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/GeneralEventsModel.dart';

Future<List<ListEsdevenimentsModel>> http_esdevenimentsrecomanats(String cookie) async {
  print('hola');
  final String apitUrl = "http://10.4.41.148:8080/event/recomanaEv";

  var json = {
    'cookie': "nq8uw8MDvaN0VavKoxLodIaBii7DzhDChsC5RxqiSMY="
  };
  String jsonStr = jsonEncode(json);
  print('S\'envia '+ jsonStr);
  final response = await http.put(apitUrl,headers: { "Content-Type" : "application/json"}, body:jsonStr );
  print('RESPONSE STATUS: '+ response.statusCode.toString());
  if (response.statusCode == 201 || response.statusCode == 200) {
    final listEsdevenimentsModel =
    listEsdevenimentsModelFromJson(response.body);
    return listEsdevenimentsModel;
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}