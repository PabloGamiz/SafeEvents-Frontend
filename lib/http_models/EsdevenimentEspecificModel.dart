// To parse this JSON data, do
//
//     final esdevenimentEspecificModel = esdevenimentEspecificModelFromJson(jsonString);

import 'dart:convert';

EsdevenimentEspecificModel esdevenimentEspecificModelFromJson(String str) => EsdevenimentEspecificModel.fromJson(json.decode(str));

String esdevenimentEspecificModelToJson(EsdevenimentEspecificModel data) => json.encode(data.toJson());

class EsdevenimentEspecificModel {
  EsdevenimentEspecificModel({
    this.controller,
  });

  Controller controller;

  factory EsdevenimentEspecificModel.fromJson(Map<String, dynamic> json) => EsdevenimentEspecificModel(
    controller: Controller.fromJson(json["Controller"]),
  );

  Map<String, dynamic> toJson() => {
    "Controller": controller.toJson(),
  };
}

class Controller {
  Controller({
    this.id,
    this.title,
    this.description,
    this.capacity,
    this.price,
    this.checkInDate,
    this.closureDate,
    this.location,
    this.organizers,
    this.services,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String title;
  String description;
  int capacity;
  int price;
  DateTime checkInDate;
  DateTime closureDate;
  Location location;
  List<dynamic> organizers;
  List<dynamic> services;
  DateTime createdAt;
  DateTime updatedAt;

  factory Controller.fromJson(Map<String, dynamic> json) => Controller(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    capacity: json["capacity"],
    price: json["price"],
    checkInDate: DateTime.parse(json["checkInDate"]),
    closureDate: DateTime.parse(json["closureDate"]),
    location: Location.fromJson(json["location"]),
    organizers: List<dynamic>.from(json["organizers"].map((x) => x)),
    services: List<dynamic>.from(json["services"].map((x) => x)),
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "capacity": capacity,
    "price": price,
    "checkInDate": checkInDate.toIso8601String(),
    "closureDate": closureDate.toIso8601String(),
    "location": location.toJson(),
    "organizers": List<dynamic>.from(organizers.map((x) => x)),
    "services": List<dynamic>.from(services.map((x) => x)),
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Location {
  Location({
    this.id,
    this.name,
    this.address,
    this.coordinates,
    this.extension,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String address;
  String coordinates;
  int extension;
  DateTime createdAt;
  DateTime updatedAt;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    name: json["name"],
    address: json["address"],
    coordinates: json["coordinates"],
    extension: json["extension"],
    createdAt: DateTime.parse(json["CreatedAt"]),
    updatedAt: DateTime.parse(json["UpdatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "address": address,
    "coordinates": coordinates,
    "extension": extension,
    "CreatedAt": createdAt.toIso8601String(),
    "UpdatedAt": updatedAt.toIso8601String(),
  };
}
