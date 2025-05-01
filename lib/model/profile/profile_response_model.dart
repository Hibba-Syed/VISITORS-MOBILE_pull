// To parse this JSON data, do
//
//     final profileResponseModel = profileResponseModelFromJson(jsonString);

import 'dart:convert';

import '../user_model.dart';

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

class Association {
  int? id;
  String? name;
  dynamic arabicName;
  int? companyId;
  String? email;
  String? phone;
  String? slug;
  int? cityId;
  int? isVisitorDirHidden;
  City? city;
  dynamic associationType;
  OamCompany? oamCompany;
  List<VisitorsPurpose>? visitorsPurposes;

  Association({
    this.id,
    this.name,
    this.arabicName,
    this.companyId,
    this.email,
    this.phone,
    this.slug,
    this.cityId,
    this.isVisitorDirHidden,
    this.city,
    this.associationType,
    this.oamCompany,
    this.visitorsPurposes,
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
    id: json["id"],
    name: json["name"],
    arabicName: json["arabic_name"],
    companyId: json["company_id"],
    email: json["email"],
    phone: json["phone"],
    slug: json["slug"],
    cityId: json["city_id"],
    isVisitorDirHidden: json["is_visitor_dir_hidden"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    associationType: json["association_type"],
    oamCompany: json["oam_company"] == null ? null : OamCompany.fromJson(json["oam_company"]),
    visitorsPurposes: json["visitors_purposes"] == null ? [] : List<VisitorsPurpose>.from(json["visitors_purposes"]!.map((x) => VisitorsPurpose.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "arabic_name": arabicName,
    "company_id": companyId,
    "email": email,
    "phone": phone,
    "slug": slug,
    "city_id": cityId,
    "is_visitor_dir_hidden": isVisitorDirHidden,
    "city": city?.toJson(),
    "association_type": associationType,
    "oam_company": oamCompany?.toJson(),
    "visitors_purposes": visitorsPurposes == null ? [] : List<dynamic>.from(visitorsPurposes!.map((x) => x.toJson())),
  };
}

class City {
  int? id;
  String? name;
  String? label;
  String? value;

  City({
    this.id,
    this.name,
    this.label,
    this.value,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "label": label,
    "value": value,
  };
}

class OamCompany {
  int? id;
  String? type;
  int? userId;
  String? companyName;
  String? contactNumber;
  String? contactEmail;
  User? user;

  OamCompany({
    this.id,
    this.type,
    this.userId,
    this.companyName,
    this.contactNumber,
    this.contactEmail,
    this.user,
  });

  factory OamCompany.fromJson(Map<String, dynamic> json) => OamCompany(
    id: json["id"],
    type: json["type"],
    userId: json["user_id"],
    companyName: json["company_name"],
    contactNumber: json["contact_number"],
    contactEmail: json["contact_email"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "user_id": userId,
    "company_name": companyName,
    "contact_number": contactNumber,
    "contact_email": contactEmail,
    "user": user?.toJson(),
  };
}



class VisitorsPurpose {
  int? id;
  int? associationId;
  String? purpose;
  int? order;
  DateTime? createdAt;
  DateTime? updatedAt;

  VisitorsPurpose({
    this.id,
    this.associationId,
    this.purpose,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  factory VisitorsPurpose.fromJson(Map<String, dynamic> json) => VisitorsPurpose(
    id: json["id"],
    associationId: json["association_id"],
    purpose: json["purpose"],
    order: json["order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "association_id": associationId,
    "purpose": purpose,
    "order": order,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
