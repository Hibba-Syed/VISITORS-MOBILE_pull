// To parse this JSON data, do
//
//     final visitorPassesResponseModel = visitorPassesResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:visitors/model/visitor_passes/visitor_pass_model.dart';

VisitorPassResponseModel visitorPassesResponseModelFromJson(String str) => VisitorPassResponseModel.fromJson(json.decode(str));

String visitorPassesResponseModelToJson(VisitorPassResponseModel data) => json.encode(data.toJson());

class VisitorPassResponseModel {
  String? status;
  List<VisitorPasses>? record;
  int? code;
  Meta? meta;
  bool? requestStatus;
  String? message;

  VisitorPassResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory VisitorPassResponseModel.fromJson(Map<String, dynamic> json) => VisitorPassResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<VisitorPasses>.from(json["record"]!.map((x) => VisitorPasses.fromJson(x))),
    code: json["code"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    requestStatus: json["request_status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "record": record == null ? [] : List<dynamic>.from(record!.map((x) => x.toJson())),
    "code": code,
    "meta": meta?.toJson(),
    "request_status": requestStatus,
    "message": message,
  };
}

class Meta {
  int? page;
  int? lastPage;
  int? from;
  int? to;
  String? limit;
  int? total;
  bool? hasMorePages;
  bool? isFirstPage;

  Meta({
    this.page,
    this.lastPage,
    this.from,
    this.to,
    this.limit,
    this.total,
    this.hasMorePages,
    this.isFirstPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
    limit: json["limit"],
    total: json["total"],
    hasMorePages: json["has_more_pages"],
    isFirstPage: json["is_first_page"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "last_page": lastPage,
    "from": from,
    "to": to,
    "limit": limit,
    "total": total,
    "has_more_pages": hasMorePages,
    "is_first_page": isFirstPage,
  };
}



