import 'dart:developer';

import 'owner_unit_model.dart';

class VisitorPasses {
  int? id;
  int? companyId;
  int? associationId;
  int? ownerUnitId;
  String? reference;
  String? visitor;
  String? visitorCompany;
  String? mobile;
  dynamic email;
  DateTime? startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  OwnerUnit? ownerUnit;
  int? activeCheckInsCount;

  VisitorPasses({
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

  factory VisitorPasses.fromJson(Map<String, dynamic> json) {
  log("Visitor Passes response::::: ${json.toString()}");
    return VisitorPasses(
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
}

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