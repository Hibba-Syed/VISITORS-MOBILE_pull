// To parse this JSON data, do
//
//     final workOrderAddLogResponseModel = workOrderAddLogResponseModelFromJson(jsonString);

import 'dart:convert';

AddLogWorkOrderResponseModel workOrderAddLogResponseModelFromJson(String str) => AddLogWorkOrderResponseModel.fromJson(json.decode(str));

String workOrderAddLogResponseModelToJson(AddLogWorkOrderResponseModel data) => json.encode(data.toJson());

class AddLogWorkOrderResponseModel {
  String? status;
  List<dynamic>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  AddLogWorkOrderResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory AddLogWorkOrderResponseModel.fromJson(Map<String, dynamic> json) => AddLogWorkOrderResponseModel(
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
