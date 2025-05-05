// To parse this JSON data, do
//
//     final loginResponseModel = loginResponseModelFromJson(jsonString);

import 'dart:convert';

LoginResponseModel loginResponseModelFromJson(String str) => LoginResponseModel.fromJson(json.decode(str));

String loginResponseModelToJson(LoginResponseModel data) => json.encode(data.toJson());

class LoginResponseModel {
  String? tokenType;
  int? expiresIn;
  String? accessToken;

  LoginResponseModel({
    this.tokenType,
    this.expiresIn,
    this.accessToken,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) => LoginResponseModel(
    tokenType: json["token_type"],
    expiresIn: json["expires_in"],
    accessToken: json["access_token"],
  );

  Map<String, dynamic> toJson() => {
    "token_type": tokenType,
    "expires_in": expiresIn,
    "access_token": accessToken,
  };
}
