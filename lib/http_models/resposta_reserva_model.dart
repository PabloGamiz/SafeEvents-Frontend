import 'dart:convert';

RespostaReservaModel respostaReservaModelFromJson(String str) =>
    RespostaReservaModel.fromJson(json.decode(str));

String respostaReservaModelToJson(RespostaReservaModel data) =>
    json.encode(data.toJson());

class RespostaReservaModel {
  RespostaReservaModel({
    this.tickets,
  });

  List<Ticket> tickets;

  factory RespostaReservaModel.fromJson(Map<String, dynamic> json) =>
      RespostaReservaModel(
        tickets:
            List<Ticket>.from(json["tickets"].map((x) => Ticket.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tickets": List<dynamic>.from(tickets.map((x) => x.toJson())),
      };
}

class Ticket {
  Ticket({
    this.controller,
  });

  Controller controller;

  factory Ticket.fromJson(Map<String, dynamic> json) => Ticket(
        controller: Controller.fromJson(json["Controller"]),
      );

  Map<String, dynamic> toJson() => {
        "Controller": controller.toJson(),
      };
}

class Controller {
  Controller({
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
  String description;
  int eventId;
  int assistantId;
  int option;
  dynamic qrCode;
  DateTime createdAt;
  int clientId;

  factory Controller.fromJson(Map<String, dynamic> json) => Controller(
        id: json["id"],
        description: json["description"],
        eventId: json["event_id"],
        assistantId: json["assistant_id"],
        option: json["option"],
        qrCode: json["qr_code"],
        createdAt: DateTime.parse(json["createdAt"]),
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
        "client_id": clientId,
      };
}
