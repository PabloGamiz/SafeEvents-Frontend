import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';

import 'http_models/preuModel.dart';
import 'http_models/resposta_reserva_model.dart';
import 'http_requests/http_entrades.dart';
import 'http_requests/http_payment.dart';

compra(int id, int numero) async {
  sleep(const Duration(seconds: 2));
  print('compra');
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  RespostaReservaModel session = await http_compra(stringValue, id, numero);
  for (int i = 0; i < session.tickets.length; ++i) {
    var resposta = paypal(session.tickets[i].controller.id);
  }

  return session;
}

paypal(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String stringValue = prefs.getString('cookie');
  final PreuModel preumodel = await http_preu(id);
  int preu = preumodel.price;
  int totalAmount = preu;
  String subTotalAmount = totalAmount.toString();
  String shippingCost = "0";
  String shippingDiscountCost = "0";
  String userFirstName = 'Pepe';
  String userLastName = 'Antono';
  String addressCity = 'Delhi';
  String addressStreet = 'Mathura Road';
  String addressZipCode = '110014';
  String addressCountry = 'India';
  String addressState = 'Delhi';
  String addressPhoneNumber = '+919990119091';

  var queryParamaters = {
    'cookie': stringValue,
    'ticket_id': id,
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
