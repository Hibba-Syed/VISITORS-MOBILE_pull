// To parse this JSON data, do
//
//     final checkInsDetailsResponseModel = checkInsDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

CheckInsDetailsResponseModel checkInsDetailsResponseModelFromJson(String str) => CheckInsDetailsResponseModel.fromJson(json.decode(str));

String checkInsDetailsResponseModelToJson(CheckInsDetailsResponseModel data) => json.encode(data.toJson());

class CheckInsDetailsResponseModel {
  String? status;
  List<Record>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CheckInsDetailsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckInsDetailsResponseModel.fromJson(Map<String, dynamic> json) => CheckInsDetailsResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<Record>.from(json["record"]!.map((x) => Record.fromJson(x))),
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

class Record {
  int? id;
  int? visitorCheckinId;
  String? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  Record({
    this.id,
    this.visitorCheckinId,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    visitorCheckinId: json["visitor_checkin_id"],
    status: json["status"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "visitor_checkin_id": visitorCheckinId,
    "status": status,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
