import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/PublicaEsdevenimentsModel.dart';

Future<PublicaEsdevenimentsModel> http_publishevents(String title, String description, int capacity,String data, int price, String location, String coordenades ) async {
  print('Entra');
  final String apitUrl = "http://10.4.41.148:8080/event/publica";
  var queryParamaters = {
    'title': title,
    'description' : description,
    'capacity' : capacity,
    'checkInDate' : data,
    'closureDate': '2020-12-01T17:01:10Z',
    'price' : price,
    'locations' : {'id' : 1,'name':'', 'adress' : location,'coordinates': coordenades,'extension': 0}
  };
  final jsonID = json.encode(queryParamaters);
  print('b '+jsonID.toString());
  final response = await http.post(apitUrl,body: jsonID );
  print('STATUS? = '+response.statusCode.toString());
  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Status code = '+response.statusCode.toString());
    final PublicaEsdevenimentsModel list = publicaEsdevenimentsModelFromJson(response.body);
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
