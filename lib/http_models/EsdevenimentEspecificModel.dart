// To parse this JSON data, do
//
//     final esdevenimentEspecificModel = esdevenimentEspecificModelFromJson(jsonString);

import 'dart:convert';

EsdevenimentEspecificModel esdevenimentEspecificModelFromJson(String str) => EsdevenimentEspecificModel.fromJson(json.decode(str));

String esdevenimentEspecificModelToJson(EsdevenimentEspecificModel data) => json.encode(data.toJson());

class EsdevenimentEspecificModel {
  EsdevenimentEspecificModel({
    this.title,
    this.description,
    this.capacity,
    this.organizers,
    this.checkInDate,
    this.closureDate,
    this.price,
    this.location,
    this.services,
    this.image,
    this.tipus,
    this.faved,
    this.taken,
    this.esorg,
  });

  String title;
  String description;
  int capacity;
  String organizers;
  DateTime checkInDate;
  DateTime closureDate;
  int price;
  String location;
  dynamic services;
  String image;
  String tipus;
  bool faved;
  int taken;
  bool esorg;

  factory EsdevenimentEspecificModel.fromJson(Map<String, dynamic> json) => EsdevenimentEspecificModel(
    title: json["title"],
    description: json["description"],
    capacity: json["capacity"],
    organizers: json["organizers"],
    checkInDate: DateTime.parse(json["checkInDate"]),
    closureDate: DateTime.parse(json["closureDate"]),
    price: json["price"],
    location: json["location"],
    services: json["services"],
    image: json["image"],
    tipus: json["tipus"],
    faved: json["Faved"],
    taken: json["Taken"],
    esorg: json["esorg"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "capacity": capacity,
    "organizers": organizers,
    "checkInDate": checkInDate.toIso8601String(),
    "closureDate": closureDate.toIso8601String(),
    "price": price,
    "location": location,
    "services": services,
    "image": image,
    "tipus": tipus,
    "Faved": faved,
    "Taken": taken,
    "esorg": esorg,
  };
}
