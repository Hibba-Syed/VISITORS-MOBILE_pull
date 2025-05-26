// To parse this JSON data, do
//
//     final checkInLogModel = checkInLogModelFromJson(jsonString);

import 'dart:convert';

import 'check_in_log_model.dart';

CheckInLogResponseModel checkInLogModelFromJson(String str) => CheckInLogResponseModel.fromJson(json.decode(str));

String checkInLogModelToJson(CheckInLogResponseModel data) => json.encode(data.toJson());

class CheckInLogResponseModel {
  String? status;
  List<CheckInLogs>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CheckInLogResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckInLogResponseModel.fromJson(Map<String, dynamic> json) => CheckInLogResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<CheckInLogs>.from(json["record"]!.map((x) => CheckInLogs.fromJson(x))),
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


