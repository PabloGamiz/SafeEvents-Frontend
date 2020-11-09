import 'dart:convert';
import 'package:http/http.dart' as http;
import '../http_models/user_model.dart';

Future<UserModel> createUser(String tokenid) async {
  final String apitUrl = "http://10.4.41.148:8080/signin";
  var queryParamaters = {'token_id': tokenid};
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  if (response.statusCode == 201 || response.statusCode == 200) {
    print("bien");
    final String responseString = response.body;
    return userModelFromJson(responseString);
  } else if (response.statusCode == 400) {
    print("Bad Request");
    return null;
  } else {
    print(response.statusCode);
    return null;
  }
}
