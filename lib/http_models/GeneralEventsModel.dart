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

/*
final String apitUrl = "http://10.4.41.148:8080/event/list";
    print(await http.get(apitUrl));

    final response = await http.get(apitUrl);
    print(response.statusCode);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final String responseString = response.body;
      final listEsdevenimentsModel =
          listEsdevenimentsModelFromJson(responseString);
      print(listEsdevenimentsModel);
      for (int i = 0; i < 3; ++i) {
        print(i);
        print(listEsdevenimentsModel[i].controller.title);
      }
    }
    
*/
