// To parse this JSON data, do
//
//     final countModel = countModelFromJson(jsonString);

import 'dart:convert';

import 'count_model.dart';

CountResponseModel countModelFromJson(String str) => CountResponseModel.fromJson(json.decode(str));

String countModelToJson(CountResponseModel data) => json.encode(data.toJson());

class CountResponseModel {
  String? status;
  CountModel? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CountResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CountResponseModel.fromJson(Map<String, dynamic> json) => CountResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : CountModel.fromJson(json["record"]),
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

