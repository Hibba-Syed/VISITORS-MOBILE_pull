// To parse this JSON data, do
//
//     final vendorsModel = vendorsModelFromJson(jsonString);

import 'dart:convert';

import 'package:visitors/model/vendor/vendor_model.dart';

VendorsResponseModel vendorsModelFromJson(String str) => VendorsResponseModel.fromJson(json.decode(str));

String vendorsModelToJson(VendorsResponseModel data) => json.encode(data.toJson());

class VendorsResponseModel {
  String? status;
  List<VendorModel>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  VendorsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory VendorsResponseModel.fromJson(Map<String, dynamic> json) => VendorsResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<VendorModel>.from(json["record"]!.map((x) => VendorModel.fromJson(x))),
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


