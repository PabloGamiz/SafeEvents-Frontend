import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/FeedbackEsdeveniments.dart';

Future<http.Response> http_afegeixfeedback(int rating, String message, String cookie, int eventid  ) async {

  final String apitUrl = "http://10.4.41.148:8080/event/feedback/new";
  var queryParamaters =
    {
      'id': null,
      'rating': rating,
      'message': message,
      'EventId': eventid,
      'cookie': cookie
  };
  final jsonID = json.encode(queryParamaters);

  final response = await http.post(apitUrl,body: jsonID );

  if (response.statusCode == 201 || response.statusCode == 200) {
    return response;
  } else if (response.statusCode == 400) {
    return response;
  } else {
    return response;
  }
}
