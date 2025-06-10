// To parse this JSON data, do
//
//     final countriesResponseModel = countriesResponseModelFromJson(jsonString);

import 'dart:convert';

import 'countries_model.dart';

CountriesResponseModel countriesResponseModelFromJson(String str) => CountriesResponseModel.fromJson(json.decode(str));

String countriesResponseModelToJson(CountriesResponseModel data) => json.encode(data.toJson());

class CountriesResponseModel {
  String? status;
  List<Countries>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CountriesResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CountriesResponseModel.fromJson(Map<String, dynamic> json) => CountriesResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<Countries>.from(json["record"]!.map((x) => Countries.fromJson(x))),
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


