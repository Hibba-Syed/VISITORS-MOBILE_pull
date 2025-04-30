// To parse this JSON data, do
//
//     final visitorPassesResponseModel = visitorPassesResponseModelFromJson(jsonString);

import 'dart:convert';

VisitorPassesResponseModel visitorPassesResponseModelFromJson(String str) => VisitorPassesResponseModel.fromJson(json.decode(str));

String visitorPassesResponseModelToJson(VisitorPassesResponseModel data) => json.encode(data.toJson());

class VisitorPassesResponseModel {
  String? status;
  List<Record>? record;
  int? code;
  Meta? meta;
  bool? requestStatus;
  String? message;

  VisitorPassesResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory VisitorPassesResponseModel.fromJson(Map<String, dynamic> json) => VisitorPassesResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<Record>.from(json["record"]!.map((x) => Record.fromJson(x))),
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

class Record {
  int? id;
  int? companyId;
  int? associationId;
  int? ownerUnitId;
  String? reference;
  String? visitor;
  String? visitorCompany;
  String? mobile;
  String? email;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  OwnerUnit? ownerUnit;
  int? activeCheckInsCount;

  Record({
    this.id,
    this.companyId,
    this.associationId,
    this.ownerUnitId,
    this.reference,
    this.visitor,
    this.visitorCompany,
    this.mobile,
    this.email,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.ownerUnit,
    this.activeCheckInsCount,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    companyId: json["company_id"],
    associationId: json["association_id"],
    ownerUnitId: json["owner_unit_id"],
    reference: json["reference"],
    visitor: json["visitor"],
    visitorCompany: json["visitor_company"],
    mobile: json["mobile"],
    email: json["email"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    ownerUnit: json["owner_unit"] == null ? null : OwnerUnit.fromJson(json["owner_unit"]),
    activeCheckInsCount: json["active_check_ins_count"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "association_id": associationId,
    "owner_unit_id": ownerUnitId,
    "reference": reference,
    "visitor": visitor,
    "visitor_company": visitorCompany,
    "mobile": mobile,
    "email": email,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "owner_unit": ownerUnit?.toJson(),
    "active_check_ins_count": activeCheckInsCount,
  };
}

class OwnerUnit {
  int? id;
  int? unitId;
  int? ownerId;
  String? titleDeedUrl;
  Unit? unit;

  OwnerUnit({
    this.id,
    this.unitId,
    this.ownerId,
    this.titleDeedUrl,
    this.unit,
  });

  factory OwnerUnit.fromJson(Map<String, dynamic> json) => OwnerUnit(
    id: json["id"],
    unitId: json["unit_id"],
    ownerId: json["owner_id"],
    titleDeedUrl: json["title_deed_url"],
    unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_id": unitId,
    "owner_id": ownerId,
    "title_deed_url": titleDeedUrl,
    "unit": unit?.toJson(),
  };
}

class Unit {
  int? id;
  String? unitNumber;
  bool? isLegalNoticeActive;
  bool? isRdcActive;
  String? titleDeedUrl;

  Unit({
    this.id,
    this.unitNumber,
    this.isLegalNoticeActive,
    this.isRdcActive,
    this.titleDeedUrl,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    unitNumber: json["unit_number"],
    isLegalNoticeActive: json["is_legal_notice_active"],
    isRdcActive: json["is_rdc_active"],
    titleDeedUrl: json["title_deed_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_number": unitNumber,
    "is_legal_notice_active": isLegalNoticeActive,
    "is_rdc_active": isRdcActive,
    "title_deed_url": titleDeedUrl,
  };
}
