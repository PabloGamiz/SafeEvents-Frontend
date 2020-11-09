import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  UserModel({
    this.cookie,
    this.timeout,
  });

  String cookie;
  int timeout;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        cookie: json["cookie"],
        timeout: json["timeout"],
      );

  Map<String, dynamic> toJson() => {
        "cookie": cookie,
        "time_out": timeout,
      };
}
