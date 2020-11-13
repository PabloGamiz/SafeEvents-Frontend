import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:safeevents/http_models/SignIn_model.dart';

Future<SignInModel> http_SignOut(String cookie) async {
  final String apitUrl = "http://10.4.41.148:8080/logout";
  var queryParamaters = {'cookie': cookie};
  final jsonCliend = json.encode(queryParamaters);
  final response = await http.put(apitUrl, body: jsonCliend);
  if (response.statusCode == 201 || response.statusCode == 200) {
    final String responseString = response.body;
    return signInModelFromJson(responseString);
  } else if (response.statusCode == 400) {
    return null;
  } else {
    return null;
  }
}
