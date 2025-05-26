// To parse this JSON data, do
//
//     final checkOutResponseModel = checkOutResponseModelFromJson(jsonString);

import 'dart:convert';

import '../check_out/check_out_model.dart';

CheckOutVisitorResponseModel checkOutResponseModelFromJson(String str) => CheckOutVisitorResponseModel.fromJson(json.decode(str));

String checkOutResponseModelToJson(CheckOutVisitorResponseModel data) => json.encode(data.toJson());

class CheckOutVisitorResponseModel {
  String? status;
  CheckOutVisitors? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CheckOutVisitorResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckOutVisitorResponseModel.fromJson(Map<String, dynamic> json) => CheckOutVisitorResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : CheckOutVisitors.fromJson(json["record"]),
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


