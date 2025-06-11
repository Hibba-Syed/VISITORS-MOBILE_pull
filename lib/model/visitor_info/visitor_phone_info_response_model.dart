// To parse this JSON data, do
//
//     final visitorPhoneInfoResponseModel = visitorPhoneInfoResponseModelFromJson(jsonString);

import 'dart:convert';

import 'number_info_model.dart';

VisitorPhoneInfoResponseModel visitorPhoneInfoResponseModelFromJson(String str) => VisitorPhoneInfoResponseModel.fromJson(json.decode(str));

String visitorPhoneInfoResponseModelToJson(VisitorPhoneInfoResponseModel data) => json.encode(data.toJson());

class VisitorPhoneInfoResponseModel {
  String? status;
  List<NumberInfo>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  VisitorPhoneInfoResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory VisitorPhoneInfoResponseModel.fromJson(Map<String, dynamic> json) => VisitorPhoneInfoResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<NumberInfo>.from(json["record"]!.map((x) => NumberInfo.fromJson(x))),
    code: json["code"],
    meta: json["meta"],
    requestStatus: json["request_status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "record": record == null ? [] : List<dynamic>.from(record!.map((x) => x.toJson())),
    "code": code,
    "meta": meta,
    "request_status": requestStatus,
    "message": message,
  };
}


