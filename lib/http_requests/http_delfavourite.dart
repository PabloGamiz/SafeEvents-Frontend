import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/Favourite_model.dart';

Future<Favourite> http_delfavourite(String cookie, int eventid) async {
  final String apitUrl = "http://10.4.41.148:8080/delfav";
  var queryParamaters = {
    "cookie": cookie,
    "eventid": eventid
  };
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return favouriteFromJson(responseString);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}