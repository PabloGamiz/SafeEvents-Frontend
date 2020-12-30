import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'http_models/resposta_reserva_model.dart';
import 'http_requests/http_entrades.dart';
import 'http_requests/http_payment.dart';

compra(int id, int numero) async {
  sleep(const Duration(seconds: 2));
  print('compra');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  RespostaReservaModel session = await http_compra(stringValue, id, numero);
  int resposta = paypal(id, numero);
  if (resposta != 200 || resposta != 201) {
    print('error al guardar dades');
  }

  return session;
}

paypal(int id, int numero) async {
  Float totalAmount = (numero * await http_preu(id)) as Float;
  Float subTotalAmount = totalAmount;
  Float shippingCost = 0 as Float;
  int shippingDiscountCost = 0;
  String userFirstName = 'Gulshan';
  String userLastName = 'Yadav';
  String addressCity = 'Delhi';
  String addressStreet = 'Mathura Road';
  String addressZipCode = '110014';
  String addressCountry = 'India';
  String addressState = 'Delhi';
  String addressPhoneNumber = '+919990119091';

  var queryParamaters = {
    'totalAmount': totalAmount,
    'subTotalAmount': subTotalAmount,
    'shippingCost': shippingCost,
    'shippingDiscountCost': shippingDiscountCost,
    'userFirstName': userFirstName,
    'userLastName': userLastName,
    'addressCity': addressCity,
    'addressStreet': addressStreet,
    'addressZipCode': addressZipCode,
    'addressCountry': addressCountry,
    'addressState': addressState,
    'addressPhoneNumber': addressPhoneNumber,
  };
  final jsonCliend = json.encode(queryParamaters);
  int confimation = await http_sendpayinfo(jsonCliend);
  return confimation;
}
