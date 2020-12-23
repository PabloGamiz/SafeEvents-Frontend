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
        id: json["id"] == null ? null : json["id"],
        email: json["email"] == null ? null : json["email"],
        organize: json["organize"] == null
            ? null
            : Organize.fromJson(json["organize"]),
        assists:
            json["assists"] == null ? null : Assists.fromJson(json["assists"]),
        favs: json["favs"] == null
            ? null
            : List<Fav>.from(json["favs"].map((x) => Fav.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "email": email == null ? null : email,
        "organize": organize == null ? null : organize.toJson(),
        "assists": assists == null ? null : assists.toJson(),
        "favs": favs == null
            ? null
            : List<dynamic>.from(favs.map((x) => x.toJson())),
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
        id: json["id"] == null ? null : json["id"],
        purchased: json["purchased"] == null
            ? null
            : List<Purchased>.from(
                json["purchased"].map((x) => Purchased.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "purchased": purchased == null
            ? null
            : List<dynamic>.from(purchased.map((x) => x.toJson())),
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
    this.checkIn,
    this.clientId,
  });

  int id;
  Description description;
  int eventId;
  int assistantId;
  int option;
  String qrCode;
  DateTime createdAt;
  dynamic checkIn;
  int clientId;

  factory Purchased.fromJson(Map<String, dynamic> json) => Purchased(
        id: json["id"] == null ? null : json["id"],
        description: json["description"] == null
            ? null
            : descriptionValues.map[json["description"]],
        eventId: json["event_id"] == null ? null : json["event_id"],
        assistantId: json["assistant_id"] == null ? null : json["assistant_id"],
        option: json["option"] == null ? null : json["option"],
        qrCode: json["qr_code"] == null ? null : json["qr_code"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        checkIn: json["check_in"],
        clientId: json["client_id"] == null ? null : json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "description":
            description == null ? null : descriptionValues.reverse[description],
        "event_id": eventId == null ? null : eventId,
        "assistant_id": assistantId == null ? null : assistantId,
        "option": option == null ? null : option,
        "qr_code": qrCode == null ? null : qrCode,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "check_in": checkIn,
        "client_id": clientId == null ? null : clientId,
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
    this.mesures,
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
  String mesures;

  factory Fav.fromJson(Map<String, dynamic> json) => Fav(
        id: json["id"] == null ? null : json["id"],
        title: json["title"] == null ? null : json["title"],
        description: json["description"] == null ? null : json["description"],
        capacity: json["capacity"] == null ? null : json["capacity"],
        taken: json["taken"] == null ? null : json["taken"],
        price: json["price"] == null ? null : json["price"],
        checkInDate: json["checkInDate"] == null
            ? null
            : DateTime.parse(json["checkInDate"]),
        closureDate: json["closureDate"] == null
            ? null
            : DateTime.parse(json["closureDate"]),
        location: json["location"] == null ? null : json["location"],
        feedbacks: json["feedbacks"],
        services: json["services"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
        image: json["image"] == null ? null : json["image"],
        tipus: json["tipus"] == null ? null : json["tipus"],
        mesures: json["mesures"] == null ? null : json["mesures"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "title": title == null ? null : title,
        "description": description == null ? null : description,
        "capacity": capacity == null ? null : capacity,
        "taken": taken == null ? null : taken,
        "price": price == null ? null : price,
        "checkInDate":
            checkInDate == null ? null : checkInDate.toIso8601String(),
        "closureDate":
            closureDate == null ? null : closureDate.toIso8601String(),
        "location": location == null ? null : location,
        "feedbacks": feedbacks,
        "services": services,
        "createdAt": createdAt == null ? null : createdAt.toIso8601String(),
        "updatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "image": image == null ? null : image,
        "tipus": tipus == null ? null : tipus,
        "mesures": mesures == null ? null : mesures,
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
        id: json["id"] == null ? null : json["id"],
        organizes: json["organizes"] == null
            ? null
            : List<Fav>.from(json["organizes"].map((x) => Fav.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "organizes": organizes == null
            ? null
            : List<dynamic>.from(organizes.map((x) => x.toJson())),
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
