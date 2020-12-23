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

Future<List<ListEsdevenimentsModel>> http_CategoryFilter(String tipus) async {
  final String apitUrl = "http://10.4.41.148:8080/event/listByType";
  var queryParamaters = {"eventType": tipus};
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl,
      body: jsonCliend); //MIRAR COMO PASAR UN BODY AL BACKEND
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

/*
final String apitUrl = "http://10.4.41.148:8080/event/list";
    print(await http.get(apitUrl));

    final response = await http.get(apitUrl);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      final listEsdevenimentsModel =
          listEsdevenimentsModelFromJson(responseString);
      print(listEsdevenimentsModel);
      for (int i = 0; i < 3; ++i) {
        print(i);
        print(listEsdevenimentsModel[i].controller.title);
      }
    }
    
*/
