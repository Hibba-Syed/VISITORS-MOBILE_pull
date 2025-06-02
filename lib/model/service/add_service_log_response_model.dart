// To parse this JSON data, do
//
//     final addServiceLogResponseModel = addServiceLogResponseModelFromJson(jsonString);

import 'dart:convert';

AddServiceLogResponseModel addServiceLogResponseModelFromJson(String str) => AddServiceLogResponseModel.fromJson(json.decode(str));

String addServiceLogResponseModelToJson(AddServiceLogResponseModel data) => json.encode(data.toJson());

class AddServiceLogResponseModel {
  String? status;
  List<dynamic>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  AddServiceLogResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory AddServiceLogResponseModel.fromJson(Map<String, dynamic> json) => AddServiceLogResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<dynamic>.from(json["record"]!.map((x) => x)),
    code: json["code"],
    meta: json["meta"],
    requestStatus: json["request_status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "record": record == null ? [] : List<dynamic>.from(record!.map((x) => x)),
    "code": code,
    "meta": meta,
    "request_status": requestStatus,
    "message": message,
  };
}
