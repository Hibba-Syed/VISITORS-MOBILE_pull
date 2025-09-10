// To parse this JSON data, do
//
//     final checkInLogModel = checkInLogModelFromJson(jsonString);


import '../log_model.dart';

class CheckOutLogResponseModel {
  String? status;
  List<LogModel>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  CheckOutLogResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckOutLogResponseModel.fromJson(Map<String, dynamic> json) =>
      CheckOutLogResponseModel(
        status: json["status"],
        record: json["record"] == null
            ? []
            : List<LogModel>.from(
                json["record"]!.map((x) => LogModel.fromJson(x))),
        code: json["code"],
        meta: json["meta"],
        requestStatus: json["request_status"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "record": record == null
            ? []
            : List<dynamic>.from(record!.map((x) => x.toJson())),
        "code": code,
        "meta": meta,
        "request_status": requestStatus,
        "message": message,
      };
}
