// To parse this JSON data, do
//
//     final guestCheckInResponseModel = guestCheckInResponseModelFromJson(jsonString);

import 'dart:convert';

import 'check_in_model.dart';

GuestCheckInResponseModel guestCheckInResponseModelFromJson(String str) => GuestCheckInResponseModel.fromJson(json.decode(str));

String guestCheckInResponseModelToJson(GuestCheckInResponseModel data) => json.encode(data.toJson());

class GuestCheckInResponseModel {
  String? status;
  CheckInModel? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  GuestCheckInResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory GuestCheckInResponseModel.fromJson(Map<String, dynamic> json) => GuestCheckInResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : CheckInModel.fromJson(json["record"]),
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
