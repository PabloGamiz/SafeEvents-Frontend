import 'dart:convert';

RespostaReservaModel respostaReservaModelFromJson(String str) =>
    RespostaReservaModel.fromJson(json.decode(str));

String respostaReservaModelToJson(RespostaReservaModel data) =>
    json.encode(data.toJson());

class RespostaReservaModel {
  RespostaReservaModel({
    this.ticketsId,
  });

  List<dynamic> ticketsId;

  factory RespostaReservaModel.fromJson(Map<String, dynamic> json) =>
      RespostaReservaModel(
        ticketsId: List<dynamic>.from(json["tickets_id"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "tickets_id": List<dynamic>.from(ticketsId.map((x) => x)),
      };
}
