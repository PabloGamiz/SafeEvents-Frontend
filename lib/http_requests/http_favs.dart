import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/FavsModel.dart';

Future<List<FavsModel>> http_Favs() async {
  /*
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  */
  var queryParameters = {'id': "1"};
  var uri = Uri.http('10.4.41.148:9090', '/listfavorites', queryParameters);
  print(uri);
  final response = await http.get(uri);
  if (response.statusCode == 200 || response.statusCode == 201) {
    return favsModelFromJson(jsonDecode(response.body));
  } else {
    print(response.statusCode);
    throw Exception('No favorites found');
  }
}
