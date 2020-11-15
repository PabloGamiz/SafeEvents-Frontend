import 'dart:convert';

EsdevenimentEspecific esdevenimentEspecificFromJson(String str) => EsdevenimentEspecific.fromJson(json.decode(str));

String esdevenimentEspecificToJson(EsdevenimentEspecific data) => json.encode(data.toJson());

class EsdevenimentEspecific {
  EsdevenimentEspecific({
    this.controller,
  });

  Controller controller;

  factory EsdevenimentEspecific.fromJson(Map<String, dynamic> json) => EsdevenimentEspecific(
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
    this.checkInDate,
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
  DateTime checkInDate;
  Location location;
  dynamic organizers;
  dynamic services;
  DateTime createdAt;
  DateTime updatedAt;

  factory Controller.fromJson(Map<String, dynamic> json) => Controller(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    capacity: json["capacity"],
    checkInDate: DateTime.parse(json["checkInDate"]),
    location: Location.fromJson(json["location"]),
    organizers: json["organizers"],
    services: json["services"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "capacity": capacity,
    "checkInDate": checkInDate.toIso8601String(),
    "location": location.toJson(),
    "organizers": organizers,
    "services": services,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
  };
}

class Location {
  Location({
    this.name,
  });

  String name;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
  };
}
