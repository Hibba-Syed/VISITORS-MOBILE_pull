// To parse this JSON data, do
//
//     final checkOutsResponseModel = checkOutsResponseModelFromJson(jsonString);

import 'dart:convert';
import '../check_out/check_out_all_model.dart';


CheckOutsAllResponseModel checkOutsResponseModelFromJson(String str) => CheckOutsAllResponseModel.fromJson(json.decode(str));

String checkOutsResponseModelToJson(CheckOutsAllResponseModel data) => json.encode(data.toJson());

class CheckOutsAllResponseModel {
  String? status;
  List<CheckOutAllModel>? record;
  int? code;
  Meta? meta;
  bool? requestStatus;
  String? message;

  CheckOutsAllResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckOutsAllResponseModel.fromJson(Map<String, dynamic> json) => CheckOutsAllResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<CheckOutAllModel>.from(json["record"]!.map((x) => CheckOutAllModel.fromJson(x))),
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
  int? limit;
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





