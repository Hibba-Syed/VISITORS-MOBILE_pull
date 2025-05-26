// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'dart:convert';

import '../association_model.dart';

ProfileResponseModel profileResponseModelFromJson(String str) => ProfileResponseModel.fromJson(json.decode(str));

String profileResponseModelToJson(ProfileResponseModel data) => json.encode(data.toJson());

class ProfileResponseModel {
  String? status;
  ProfileRecord? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  ProfileResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory ProfileResponseModel.fromJson(Map<String, dynamic> json) => ProfileResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : ProfileRecord.fromJson(json["record"]),
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

class ProfileRecord {
  int? id;
  int? associationId;
  String? gate;
  Association? association;

  ProfileRecord({
    this.id,
    this.associationId,
    this.gate,
    this.association,
  });

  factory ProfileRecord.fromJson(Map<String, dynamic> json) => ProfileRecord(
    id: json["id"],
    associationId: json["association_id"],
    gate: json["gate"],
    association: json["association"] == null ? null : Association.fromJson(json["association"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "association_id": associationId,
    "gate": gate,
    "association": association?.toJson(),
  };
}










