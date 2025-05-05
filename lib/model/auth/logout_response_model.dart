// To parse this JSON data, do
//
//     final logoutResponseModel = logoutResponseModelFromJson(jsonString);

import 'dart:convert';

LogoutResponseModel logoutResponseModelFromJson(String str) => LogoutResponseModel.fromJson(json.decode(str));

String logoutResponseModelToJson(LogoutResponseModel data) => json.encode(data.toJson());

class LogoutResponseModel {
  String? status;
  bool? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  LogoutResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory LogoutResponseModel.fromJson(Map<String, dynamic> json) => LogoutResponseModel(
    status: json["status"],
    record: json["record"],
    code: json["code"],
    meta: json["meta"],
    requestStatus: json["request_status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "record": record,
    "code": code,
    "meta": meta,
    "request_status": requestStatus,
    "message": message,
  };
}
