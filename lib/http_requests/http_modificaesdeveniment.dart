import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/ModificaEsdevenimentModel.dart';

Future<ModificaEsdevenimentModel> http_modificaesdeveniment (String cookie,int id, String title, String description, int capacity, int price,String data, String location,String coordenades, String services, String image, String tipus ) async {
  print('Entra');
  final String apitUrl = "http://10.4.41.148:8080/event/modifica";
  print('Entra+++++ '+services );
  print('Entra+++++ '+coordenades );
  String loc = location + "--" + coordenades;
  var queryParamaters = {
    'cookie' : cookie ,
    'id' : id ,
    'title': title,
    'description' : description,
    'capacity' : capacity,
    'price' : price,
    'checkInDate' : data,
    'closureDate': data,
    'location' :loc ,//location
    'mesures' : services,
    'image' : image,
    'tipus' : tipus
  };
  print('Entra');
  final jsonID = json.encode(queryParamaters);
  print('b '+jsonID.toString());
  final response = await http.put(apitUrl,headers: { "Content-Type" : "application/json"}, body:jsonID );
  print('STATUS? = '+response.statusCode.toString());
  print('STATUS? = '+response.body.toString());
  if (response.statusCode == 201 || response.statusCode == 200) {
    print('Status code = '+response.statusCode.toString());
    /*final ModificaEsdevenimentModel list = modificaEsdevenimentModelFromJson(response.body);
    print('LIST: '+list.toString());
    return list;*/

  } else if (response.statusCode == 400) {
    print('Status code = '+response.statusCode.toString());
    return null;
  } else {
    print('Status code = '+response.statusCode.toString());
    return null;
  }
}
