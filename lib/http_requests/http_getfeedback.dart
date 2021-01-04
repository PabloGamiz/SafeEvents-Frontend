import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/FeedbackEsdeveniments.dart';

Future<List<FeedbackEsdeveniments> >http_getfeedback(String cookie, int eventid  ) async {
  print('Entra');
  final String apitUrl = "http://10.4.41.148:8080/event/feedback/get";
  var queryParamaters =
  {
    'EventId': eventid,
    'cookie': cookie
  };
  final jsonID = json.encode(queryParamaters);
  print('b '+jsonID.toString());
  final response = await http.post(apitUrl, body: jsonID );
  print('STATUS? = '+response.statusCode.toString());
  print('STATUS body? = '+response.body.toString());
  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Status code = '+response.statusCode.toString());
    final List<FeedbackEsdeveniments> list = feedbackEsdevenimentsFromJson(response.body);
    print('LISTTT: '+list.toString());
    return list;
  } else if (response.statusCode == 400) {
    print('Status code = '+response.statusCode.toString());
    return null;
  } else {
    print('Status code = '+response.statusCode.toString());
    return null;
  }
}
