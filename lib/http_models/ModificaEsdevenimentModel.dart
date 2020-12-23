// To parse this JSON data, do
//
//     final modificaEsdevenimentModel = modificaEsdevenimentModelFromJson(jsonString);

import 'dart:convert';

ModificaEsdevenimentModel modificaEsdevenimentModelFromJson(String str) => ModificaEsdevenimentModel.fromJson(json.decode(str));

String modificaEsdevenimentModelToJson(ModificaEsdevenimentModel data) => json.encode(data.toJson());

class ModificaEsdevenimentModel {
  ModificaEsdevenimentModel({
    this.controller,
  });

  Controller controller;

  factory ModificaEsdevenimentModel.fromJson(Map<String, dynamic> json) => ModificaEsdevenimentModel(
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
    this.taken,
    this.price,
    this.checkInDate,
    this.closureDate,
    this.location,
    this.feedbacks,
    this.services,
    this.createdAt,
    this.updatedAt,
    this.image,
    this.tipus,
  });

  int id;
  String title;
  String description;
  int capacity;
  int taken;
  int price;
  DateTime checkInDate;
  DateTime closureDate;
  String location;
  dynamic feedbacks;
  dynamic services;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  String tipus;

  factory Controller.fromJson(Map<String, dynamic> json) => Controller(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    capacity: json["capacity"],
    taken: json["taken"],
    price: json["price"],
    checkInDate: DateTime.parse(json["checkInDate"]),
    closureDate: DateTime.parse(json["closureDate"]),
    location: json["location"],
    feedbacks: json["feedbacks"],
    services: json["services"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    image: json["image"],
    tipus: json["tipus"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "capacity": capacity,
    "taken": taken,
    "price": price,
    "checkInDate": checkInDate.toIso8601String(),
    "closureDate": closureDate.toIso8601String(),
    "location": location,
    "feedbacks": feedbacks,
    "services": services,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "image": image,
    "tipus": tipus,
  };
}
