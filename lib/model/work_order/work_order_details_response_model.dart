// To parse this JSON data, do
//
//     final workOrderDetailsModel = workOrderDetailsModelFromJson(jsonString);

import 'dart:convert';

import 'package:visitors/model/work_order/work_order_details_model.dart';

WorkOrderDetailsResponseModel workOrderDetailsModelFromJson(String str) => WorkOrderDetailsResponseModel.fromJson(json.decode(str));

String workOrderDetailsModelToJson(WorkOrderDetailsResponseModel data) => json.encode(data.toJson());

class WorkOrderDetailsResponseModel {
  String? status;
  WorkOrderDetailsModel? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  WorkOrderDetailsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory WorkOrderDetailsResponseModel.fromJson(Map<String, dynamic> json) => WorkOrderDetailsResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : WorkOrderDetailsModel.fromJson(json["record"]),
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







