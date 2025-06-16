// To parse this JSON data, do
//
//     final visitorPassesCountResponseModel = visitorPassesCountResponseModelFromJson(jsonString);

import 'dart:convert';

VisitorPassesCountResponseModel visitorPassesCountResponseModelFromJson(String str) => VisitorPassesCountResponseModel.fromJson(json.decode(str));

String visitorPassesCountResponseModelToJson(VisitorPassesCountResponseModel data) => json.encode(data.toJson());

class VisitorPassesCountResponseModel {
  String? status;
  VisitorPassesCount? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  VisitorPassesCountResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory VisitorPassesCountResponseModel.fromJson(Map<String, dynamic> json) => VisitorPassesCountResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : VisitorPassesCount.fromJson(json["record"]),
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

class VisitorPassesCount {
  int? count;

  VisitorPassesCount({
    this.count,
  });

  factory VisitorPassesCount.fromJson(Map<String, dynamic> json) => VisitorPassesCount(
    count: json["count"],
  );

  Map<String, dynamic> toJson() => {
    "count": count,
  };
}
