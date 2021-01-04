import 'dart:convert';

PreuModel preuModelFromJson(String str) => PreuModel.fromJson(json.decode(str));

String preuModelToJson(PreuModel data) => json.encode(data.toJson());

class PreuModel {
  PreuModel({
    this.price,
  });

  int price;

  factory PreuModel.fromJson(Map<String, dynamic> json) => PreuModel(
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "price": price,
      };
}
