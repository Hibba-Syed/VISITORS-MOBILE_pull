// To parse this JSON data, do
//
//     final sendResponseMessagesModel = sendResponseMessagesModelFromJson(jsonString);

import 'dart:convert';

import 'package:visitors/model/message/send_model.dart';

SendMessageResponseModel sendResponseMessagesModelFromJson(String str) => SendMessageResponseModel.fromJson(json.decode(str));

String sendResponseMessagesModelToJson(SendMessageResponseModel data) => json.encode(data.toJson());

class SendMessageResponseModel {
  String? status;
  SendModel? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  SendMessageResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory SendMessageResponseModel.fromJson(Map<String, dynamic> json) => SendMessageResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : SendModel.fromJson(json["record"]),
    code: json["code"],
    meta: json["meta"],
    requestStatus: json["request_status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "record": record?.toJson(),
    "code": code,
    "meta": meta,
    "request_status": requestStatus,
    "message": message,
  };
}

