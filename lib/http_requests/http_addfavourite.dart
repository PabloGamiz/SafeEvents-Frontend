import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/Favourite_model.dart';

Future<Favourite> http_addfavourite(String cookie, int eventid) async {
  print('dentro future');
  final String apitUrl = "http://10.4.41.148:8080/addfav";
  var queryParamaters = {
    "cookie": cookie,
    "eventid": eventid
  };
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    print('dentro if final');
    return favouriteFromJson(responseString);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}