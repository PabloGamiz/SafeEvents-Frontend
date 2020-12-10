import 'dart:convert';

ClientInfoMod clientInfoModFromJson(String str) =>
    ClientInfoMod.fromJson(json.decode(str));

String clientInfoModToJson(ClientInfoMod data) => json.encode(data.toJson());

class ClientInfoMod {
  ClientInfoMod({
    this.id,
    this.email,
    this.organize,
    this.assists,
    this.favs,
  });

  int id;
  String email;
  Organize organize;
  Assists assists;
  List<Fav> favs;

  factory ClientInfoMod.fromJson(Map<String, dynamic> json) => ClientInfoMod(
        id: json["id"],
        email: json["email"],
        organize: Organize.fromJson(json["organize"]),
        assists: Assists.fromJson(json["assists"]),
        favs: List<Fav>.from(json["favs"].map((x) => Fav.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "organize": organize.toJson(),
        "assists": assists.toJson(),
        "favs": List<dynamic>.from(favs.map((x) => x.toJson())),
      };
}

class Assists {
  Assists({
    this.id,
    this.purchased,
  });

  int id;
  List<Purchased> purchased;

  factory Assists.fromJson(Map<String, dynamic> json) => Assists(
        id: json["id"],
        purchased: List<Purchased>.from(
            json["purchased"].map((x) => Purchased.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "purchased": List<dynamic>.from(purchased.map((x) => x.toJson())),
      };
}

class Purchased {
  Purchased({
    this.id,
    this.description,
    this.eventId,
    this.assistantId,
    this.option,
    this.qrCode,
    this.createdAt,
    this.clientId,
  });

  int id;
  Description description;
  int eventId;
  int assistantId;
  int option;
  String qrCode;
  DateTime createdAt;
  int clientId;

  factory Purchased.fromJson(Map<String, dynamic> json) => Purchased(
        id: json["id"],
        description: descriptionValues.map[json["description"]],
        eventId: json["event_id"],
        assistantId: json["assistant_id"],
        option: json["option"],
        qrCode: json["qr_code"] == null ? null : json["qr_code"],
        createdAt: DateTime.parse(json["createdAt"]),
        clientId: json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": descriptionValues.reverse[description],
        "event_id": eventId,
        "assistant_id": assistantId,
        "option": option,
        "qr_code": qrCode == null ? null : qrCode,
        "createdAt": createdAt.toIso8601String(),
        "client_id": clientId,
      };
}

enum Description { TESTING }

final descriptionValues = EnumValues({"testing": Description.TESTING});

class Fav {
  Fav({
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

  factory Fav.fromJson(Map<String, dynamic> json) => Fav(
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

class Organize {
  Organize({
    this.id,
    this.organizes,
  });

  int id;
  List<Fav> organizes;

  factory Organize.fromJson(Map<String, dynamic> json) => Organize(
        id: json["id"],
        organizes:
            List<Fav>.from(json["organizes"].map((x) => Fav.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "organizes": List<dynamic>.from(organizes.map((x) => x.toJson())),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
