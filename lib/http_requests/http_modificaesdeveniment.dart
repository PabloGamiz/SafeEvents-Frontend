import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/PublicaEsdevenimentsModel.dart';

Future<PublicaEsdevenimentsModel> http_modificaesdeveniment (String cookie,int id, String title, String description, int capacity, int price,String data, String location, List<dynamic> services, String image, String tipus ) async {
  print('Entra');
  final String apitUrl = "http://10.4.41.148:8080/event/modifica";
  var queryParamaters = {
    'cookie' : cookie ,
    'id' : id ,
    'title': title,
    'description' : description,
    'capacity' : capacity,
    'price' : price,
    'checkInDate' : data,
    'closureDate': '1999-19-01T17:01:10Z',
    'price' : price,
    'location' : 0000000,//location
    'services' : services,
    'image' : image,
    'tipus' : tipus
  };
  final jsonID = json.encode(queryParamaters);
  print('b '+jsonID.toString());
  final response = await http.put(apitUrl,headers: { "Content-Type" : "application/json"}, body:jsonID );
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
