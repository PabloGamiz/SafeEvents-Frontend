import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/GeneralEventsModel.dart';

Future<List<ListEsdevenimentsModel>> http_GeneralEvents() async {
  final String apitUrl = "http://10.4.41.148:8080/event/list";
  final response = await http.get(apitUrl);
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
