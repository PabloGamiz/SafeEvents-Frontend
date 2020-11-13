import 'dart:convert';

SignInModel signInModelFromJson(String str) =>
    SignInModel.fromJson(json.decode(str));

String signInModelToJson(SignInModel data) => json.encode(data.toJson());

class SignInModel {
  SignInModel({
    this.cookie,
    this.deadline,
  });

  String cookie;
  int deadline;

  factory SignInModel.fromJson(Map<String, dynamic> json) => SignInModel(
        cookie: json["cookie"],
        deadline: json["time"],
      );

  Map<String, dynamic> toJson() => {
        "cookie": cookie,
        "timeout": deadline,
      };
}
