// To parse this JSON data, do
//
//     final deleteVisitorResponseModel = deleteVisitorResponseModelFromJson(jsonString);

import 'dart:convert';

DeleteVisitorResponseModel deleteVisitorResponseModelFromJson(String str) => DeleteVisitorResponseModel.fromJson(json.decode(str));

String deleteVisitorResponseModelToJson(DeleteVisitorResponseModel data) => json.encode(data.toJson());

class DeleteVisitorResponseModel {
  String? status;
  dynamic record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  DeleteVisitorResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory DeleteVisitorResponseModel.fromJson(Map<String, dynamic> json) => DeleteVisitorResponseModel(
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
