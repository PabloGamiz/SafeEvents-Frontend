import 'dart:convert';

List<FavsModel> favsModelFromJson(String str) =>
    List<FavsModel>.from(json.decode(str).map((x) => FavsModel.fromJson(x)));

String favsModelToJson(List<FavsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FavsModel {
  FavsModel({
    this.id,
    this.title,
    this.description,
    this.capacity,
    this.taken,
    this.price,
    this.checkInDate,
    this.closureDate,
    this.location,
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
  DateTime createdAt;
  DateTime updatedAt;
  String image;
  String tipus;

  factory FavsModel.fromJson(Map<String, dynamic> json) => FavsModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        capacity: json["capacity"],
        taken: json["taken"],
        price: json["price"],
        checkInDate: DateTime.parse(json["checkInDate"]),
        closureDate: DateTime.parse(json["closureDate"]),
        location: json["location"],
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
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "image": image,
        "tipus": tipus,
      };
}
