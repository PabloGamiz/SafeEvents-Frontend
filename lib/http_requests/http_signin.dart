import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/SignIn_model.dart';

Future<SignInModel> http_SignIn(String tokenid) async {
  final String apitUrl = "http://10.4.41.148:8080/signin";
  var queryParamaters = {'token_id': tokenid};
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.post(apitUrl, body: jsonCliend);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return signInModelFromJson(responseString);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}
