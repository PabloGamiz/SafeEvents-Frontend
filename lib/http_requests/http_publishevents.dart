import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/ModificaEsdevenimentModel.dart';
import 'package:safeevents/http_models/PublicaEsdevenimentsModel.dart';

Future<ModificaEsdevenimentModel> http_publishevents(String title, String description, int capacity,String data, int price, String location, String coordenades, String image, String cookie, String tipus, List<String> mesuresCOVID ) async {
  print('Entra');
  final String apitUrl = "http://10.4.41.148:8080/event/publica";
  var queryParamaters = {
    'title': title,
    'description' : description,
    'image' : image,
    'capacity' : capacity,
    'checkInDate' : data,
    'closureDate': data,
    'price' : price,
    'location' : location + '--' + coordenades, //format nom localitzacio + -- + lat + ';' + long
    'cookie' : cookie,
    'tipus' : tipus
    //mesuresCOVID
  };
  final jsonID = json.encode(queryParamaters);
  print('b '+jsonID.toString());
  final response = await http.post(apitUrl,body: jsonID );
  print('STATUS? = '+response.statusCode.toString());
  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Status code = '+response.statusCode.toString());
    final ModificaEsdevenimentModel list = modificaEsdevenimentModelFromJson(response.body);
    print(list);
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
