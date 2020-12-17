// To parse this JSON data, do
//
//     final listEsdevenimentsModel = listEsdevenimentsModelFromJson(jsonString);

import 'dart:convert';

List<ListEsdevenimentsModel> listEsdevenimentsModelFromJson(String str) => List<ListEsdevenimentsModel>.from(json.decode(str).map((x) => ListEsdevenimentsModel.fromJson(x)));

String listEsdevenimentsModelToJson(List<ListEsdevenimentsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListEsdevenimentsModel {
  ListEsdevenimentsModel({
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

  factory ListEsdevenimentsModel.fromJson(Map<String, dynamic> json) => ListEsdevenimentsModel(
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
