import 'dart:convert';

import 'package:visitors/model/service/service_details_model.dart';

ServiceDetailsResponseModel serviceDetailsResponseModelFromJson(String str) => ServiceDetailsResponseModel.fromJson(json.decode(str));

String serviceDetailsResponseModelToJson(ServiceDetailsResponseModel data) => json.encode(data.toJson());

class ServiceDetailsResponseModel {
  String? status;
  ServiceDetailsModel? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  ServiceDetailsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory ServiceDetailsResponseModel.fromJson(Map<String, dynamic> json) => ServiceDetailsResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : ServiceDetailsModel.fromJson(json["record"]),
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


