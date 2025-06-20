// To parse this JSON data, do
//
//     final checkOutAllModel = checkOutAllModelFromJson(jsonString);

import 'dart:convert';

CheckOutAll checkOutAllModelFromJson(String str) => CheckOutAll.fromJson(json.decode(str));

String checkOutAllModelToJson(CheckOutAll data) => json.encode(data.toJson());

class CheckOutAll {
  String? status;
  bool? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CheckOutAll({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckOutAll.fromJson(Map<String, dynamic> json) => CheckOutAll(
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
