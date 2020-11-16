/*import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/PublishEventsModel.dart';

Future<PublishEventsModel> http_publishevents(int id, String title, String ) async {
  print('hola');
  final String apitUrl = "http://10.4.41.148:8080/event/publish/";
  /var queryParamaters = {'id': id, 'title': title };
  final jsonID = json.encode(queryParamaters);
  final response = await http.post(apitUrl,body: jsonID );
  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Status code = '+response.statusCode.toString());
    final PublishEventsModel list = publishEventsModelFromJson(response.body);
    return list;
  } else if (response.statusCode == 400) {
    print('Status code = '+response.statusCode.toString());
    return null;
  } else {
    print('Status code = '+response.statusCode.toString());
    return null;
  }
}

/*EsdevenimentEspecificModel _parseEvents(String responseBody) {
  final parse = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parse.map<EsdevenimentEspecificModel>((json) => EsdevenimentEspecificModel.fromJson(json));
}*/
*/