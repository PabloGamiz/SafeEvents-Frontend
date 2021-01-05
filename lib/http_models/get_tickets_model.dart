import 'dart:convert';

List<GetTicketsModel> getTicketsModelFromJson(String str) =>
    List<GetTicketsModel>.from(
        json.decode(str).map((x) => GetTicketsModel.fromJson(x)));

String getTicketsModelToJson(List<GetTicketsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetTicketsModel {
  GetTicketsModel({
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
  String description;
  int eventId;
  int assistantId;
  int option;
  String qrCode;
  DateTime createdAt;
  dynamic checkIn;
  int clientId;

  factory GetTicketsModel.fromJson(Map<String, dynamic> json) =>
      GetTicketsModel(
        id: json["id"],
        description: json["description"],
        eventId: json["event_id"],
        assistantId: json["assistant_id"],
        option: json["option"],
        qrCode: json["qr_code"],
        createdAt: DateTime.parse(json["createdAt"]),
        checkIn: json["check_in"],
        clientId: json["client_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "event_id": eventId,
        "assistant_id": assistantId,
        "option": option,
        "qr_code": qrCode,
        "createdAt": createdAt.toIso8601String(),
        "check_in": checkIn,
        "client_id": clientId,
      };
}
