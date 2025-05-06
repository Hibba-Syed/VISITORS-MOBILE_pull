import 'package:visitors/model/unit/unit_model.dart';

class UnitsResponseModel {
  String? status;
  List<UnitModel>? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  UnitsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory UnitsResponseModel.fromJson(Map<String, dynamic> json) =>
      UnitsResponseModel(
        status: json["status"],
        record: json["record"] == null
            ? []
            : List<UnitModel>.from(
                json["record"]!.map((x) => UnitModel.fromJson(x))),
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




