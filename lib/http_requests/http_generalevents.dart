/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/GeneralEventsModel.dart';

Future<List<Event>> http_GeneralEvents() async {
  print('hola');
  final String apitUrl = "http://10.4.41.148:8080/event/list";
  final response = await http.get(apitUrl);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final List<Event> list = _parseEvents(response.body);
    return list;
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}

List<Event> _parseEvents(String responseBody) {
  final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parse.map<Event>((json) => Event.fromJson(json)).toList();
}
*/
