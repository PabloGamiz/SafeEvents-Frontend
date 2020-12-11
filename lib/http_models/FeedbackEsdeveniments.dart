// To parse this JSON data, do
//
//     final feedbackEsdeveniments = feedbackEsdevenimentsFromJson(jsonString);

import 'dart:convert';

FeedbackEsdeveniments feedbackEsdevenimentsFromJson(String str) => FeedbackEsdeveniments.fromJson(json.decode(str));

String feedbackEsdevenimentsToJson(FeedbackEsdeveniments data) => json.encode(data.toJson());

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
