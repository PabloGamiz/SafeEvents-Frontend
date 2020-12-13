// To parse this JSON data, do
//
//     final favourite = favouriteFromJson(jsonString);

import 'dart:convert';

Favourite favouriteFromJson(String str) => Favourite.fromJson(json.decode(str));

String favouriteToJson(Favourite data) => json.encode(data.toJson());

class Favourite {
    Favourite({
        this.cookie,
        this.eventid,
    });

    String cookie;
    int eventid;

    factory Favourite.fromJson(Map<String, dynamic> json) => Favourite(
        cookie: json["cookie"],
        eventid: json["eventid"],
    );

    Map<String, dynamic> toJson() => {
        "cookie": cookie,
        "eventid": eventid,
    };
}