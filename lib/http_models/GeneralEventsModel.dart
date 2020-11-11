import 'dart:convert';

EventsModel eventsModelFromJson(String str) =>
    EventsModel.fromJson(json.decode(str));

String eventsModelToJson(EventsModel data) => json.encode(data.toJson());

class EventsModel {
  EventsModel({
    this.events,
  });

  List<Event> events;

  factory EventsModel.fromJson(Map<String, dynamic> json) => EventsModel(
        events: List<Event>.from(json["events"].map((x) => Event.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "events": List<dynamic>.from(events.map((x) => x.toJson())),
      };
}

class Event {
  Event({
    this.id,
    this.title,
    this.date,
    this.location,
    this.services,
  });

  int id;
  String title;
  int date;
  Location location;
  List<Service> services;

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        id: json["id"],
        title: json["title"],
        date: json["date"],
        location: Location.fromJson(json["location"]),
        services: List<Service>.from(
            json["services"].map((x) => Service.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "date": date,
        "location": location.toJson(),
        "services": List<dynamic>.from(services.map((x) => x.toJson())),
      };
}

class Location {
  Location({
    this.id,
    this.name,
  });

  int id;
  String name;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Service {
  Service({
    this.id,
    this.products,
  });

  int id;
  List<Product> products;

  factory Service.fromJson(Map<String, dynamic> json) => Service(
        id: json["id"],
        products: List<Product>.from(
            json["products"].map((x) => Product.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "products": List<dynamic>.from(products.map((x) => x.toJson())),
      };
}

class Product {
  Product({
    this.id,
    this.price,
  });

  int id;
  int price;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "price": price,
      };
}
