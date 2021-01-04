// To parse this JSON data, do
//
//     final feedbackEsdeveniments = feedbackEsdevenimentsFromJson(jsonString);

import 'dart:convert';

List<FeedbackEsdeveniments> feedbackEsdevenimentsFromJson(String str) => List<FeedbackEsdeveniments>.from(json.decode(str).map((x) => FeedbackEsdeveniments.fromJson(x)));

String feedbackEsdevenimentsToJson(List<FeedbackEsdeveniments> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FeedbackEsdeveniments {
  FeedbackEsdeveniments({
    this.id,
    this.rating,
    this.message,
    this.isOwner,
  });

  int id;
  int rating;
  String message;
  bool isOwner;

  factory FeedbackEsdeveniments.fromJson(Map<String, dynamic> json) => FeedbackEsdeveniments(
    id: json["id"],
    rating: json["rating"],
    message: json["message"],
    isOwner: json["isOwner"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "rating": rating,
    "message": message,
    "isOwner": isOwner,
  };
}
