import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/FavsModel.dart';
import 'dart:io';

Future<List<FavsModel>> http_Favs() async {
  /*
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  */
  var uri = Uri.http('10.4.41.148:8080', '/event/favorites');
  print(uri);
  final response = await http.get(uri, headers: {
    HttpHeaders.authorizationHeader:
        "1OKB62n2EU4J4TIBlnTx2Kr-YY26a_uwZtz9E7owAdk="
  });
  if (response.statusCode == 200 || response.statusCode == 201) {
    return favsModelFromJson(response.body);
  } else {
    print(response.statusCode);
    throw Exception('No favorites found');
  }
}
