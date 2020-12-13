/*// To parse this JSON data, do
//
//     final listEsdevenimentsModel = listEsdevenimentsModelFromJson(jsonString);

import 'dart:convert';

List<ListEsdevenimentsModel> listEsdevenimentsModelFromJson(String str) =>
    List<ListEsdevenimentsModel>.from(
        json.decode(str).map((x) => ListEsdevenimentsModel.fromJson(x)));

String listEsdevenimentsModelToJson(List<ListEsdevenimentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListEsdevenimentsModel {
  ListEsdevenimentsModel({
    this.controller,
  });

  Controller controller;

  factory ListEsdevenimentsModel.fromJson(Map<String, dynamic> json) =>
      ListEsdevenimentsModel(
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

  Controller({
    this.id,
    this.title,
    this.description,
    this.capacity,
    this.price,
    this.location,
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

  Location({
    this.id,
    this.name,
    this.address,
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
}*/

// To parse this JSON data, do
//
//     final listEsdevenimentsModel = listEsdevenimentsModelFromMap(jsonString);

// To parse this JSON data, do
//
//     final listEsdevenimentsModel = listEsdevenimentsModelFromJson(jsonString);

import 'dart:convert';

List<ListEsdevenimentsModel> listEsdevenimentsModelFromJson(String str) =>
    List<ListEsdevenimentsModel>.from(
        json.decode(str).map((x) => ListEsdevenimentsModel.fromJson(x)));

String listEsdevenimentsModelToJson(List<ListEsdevenimentsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

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
  List<Feedback> feedbacks;
  List<dynamic> services;
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  String tipus;

  factory ListEsdevenimentsModel.fromJson(Map<String, dynamic> json) =>
      ListEsdevenimentsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        capacity: json["capacity"],
        taken: json["taken"],
        price: json["price"],
        checkInDate: DateTime.parse(json["checkInDate"]),
        closureDate: DateTime.parse(json["closureDate"]),
        location: json["location"],
        feedbacks: List<Feedback>.from(
            json["feedbacks"].map((x) => Feedback.fromJson(x))),
        services: List<dynamic>.from(json["services"].map((x) => x)),
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
        "feedbacks": List<dynamic>.from(feedbacks.map((x) => x.toJson())),
        "services": List<dynamic>.from(services.map((x) => x)),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "image": image,
        "tipus": tipus,
      };
}

class Feedback {
  Feedback({
    this.id,
    this.rating,
    this.message,
    this.assistant,
    this.updatedAt,
  });

  int id;
  int rating;
  String message;
  dynamic assistant;
  DateTime updatedAt;

  factory Feedback.fromJson(Map<String, dynamic> json) => Feedback(
        id: json["id"],
        rating: json["rating"],
        message: json["message"],
        assistant: json["assistant"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "rating": rating,
        "message": message,
        "assistant": assistant,
        "updatedAt": updatedAt.toIso8601String(),
      };
}
