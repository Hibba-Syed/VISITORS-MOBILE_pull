// To parse this JSON data, do
//
//     final checkInLogModel = checkInLogModelFromJson(jsonString);

import 'dart:convert';

CheckInLogModel checkInLogModelFromJson(String str) => CheckInLogModel.fromJson(json.decode(str));

String checkInLogModelToJson(CheckInLogModel data) => json.encode(data.toJson());

class CheckInLogModel {
  String? status;
  List<CheckInLogRecord>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CheckInLogModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckInLogModel.fromJson(Map<String, dynamic> json) => CheckInLogModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<CheckInLogRecord>.from(json["record"]!.map((x) => CheckInLogRecord.fromJson(x))),
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

class CheckInLogRecord {
  int? id;
  int? visitorCheckinId;
  String? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  CheckInLogRecord({
    this.id,
    this.visitorCheckinId,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory CheckInLogRecord.fromJson(Map<String, dynamic> json) => CheckInLogRecord(
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
