// To parse this JSON data, do
//
//     final publicaEsdevenimentsModel = publicaEsdevenimentsModelFromJson(jsonString);

import 'dart:convert';

PublicaEsdevenimentsModel publicaEsdevenimentsModelFromJson(String str) => PublicaEsdevenimentsModel.fromJson(json.decode(str));

String publicaEsdevenimentsModelToJson(PublicaEsdevenimentsModel data) => json.encode(data.toJson());

class PublicaEsdevenimentsModel {
  PublicaEsdevenimentsModel({
    this.title,
    this.description,
    this.capacity,
    this.checkInDate,
    this.closureDate,
    this.price,
    this.locations,
  });

  String title;
  String description;
  int capacity;
  DateTime checkInDate;
  DateTime closureDate;
  int price;
  Locations locations;

  factory PublicaEsdevenimentsModel.fromJson(Map<String, dynamic> json) => PublicaEsdevenimentsModel(
    title: json["title"],
    description: json["description"],
    capacity: json["capacity"],
    checkInDate: DateTime.parse(json["checkInDate"]),
    closureDate: DateTime.parse(json["closureDate"]),
    price: json["price"],
    locations: Locations.fromJson(json["locations"]),
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "description": description,
    "capacity": capacity,
    "checkInDate": checkInDate.toIso8601String(),
    "closureDate": closureDate.toIso8601String(),
    "price": price,
    "locations": locations.toJson(),
  };
}

class Locations {
  Locations({
    this.id,
    this.name,
    this.address,
    this.coordinates,
    this.extension,
  });

  int id;
  String name;
  String address;
  String coordinates;
  int extension;

  factory Locations.fromJson(Map<String, dynamic> json) => Locations(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    coordinates: json["coordinates"],
    extension: json["extension"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "coordinates": coordinates,
    "extension": extension,
  };
}
