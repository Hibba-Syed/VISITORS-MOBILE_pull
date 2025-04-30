// To parse this JSON data, do
//
//     final checkOutsResponseModel = checkOutsResponseModelFromJson(jsonString);

import 'dart:convert';

CheckOutsResponseModel checkOutsResponseModelFromJson(String str) => CheckOutsResponseModel.fromJson(json.decode(str));

String checkOutsResponseModelToJson(CheckOutsResponseModel data) => json.encode(data.toJson());

class CheckOutsResponseModel {
  String? status;
  List<Record>? record;
  int? code;
  Meta? meta;
  bool? requestStatus;
  String? message;

  CheckOutsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckOutsResponseModel.fromJson(Map<String, dynamic> json) => CheckOutsResponseModel(
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

class Record {
  int? id;
  int? associationId;
  int? unitId;
  dynamic vendorId;
  int? visitorId;
  int? serviceableId;
  String? serviceableType;
  String? checkinGate;
  DateTime? checkinTime;
  String? checkoutGate;
  DateTime? checkoutTime;
  String? type;
  String? purpose;
  String? visitorCount;
  dynamic idExpiry;
  String? entryCardNumber;
  String? name;
  String? phone;
  String? email;
  dynamic description;
  Unit? unit;
  Visitor? visitor;
  dynamic vendor;

  Record({
    this.id,
    this.associationId,
    this.unitId,
    this.vendorId,
    this.visitorId,
    this.serviceableId,
    this.serviceableType,
    this.checkinGate,
    this.checkinTime,
    this.checkoutGate,
    this.checkoutTime,
    this.type,
    this.purpose,
    this.visitorCount,
    this.idExpiry,
    this.entryCardNumber,
    this.name,
    this.phone,
    this.email,
    this.description,
    this.unit,
    this.visitor,
    this.vendor,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    associationId: json["association_id"],
    unitId: json["unit_id"],
    vendorId: json["vendor_id"],
    visitorId: json["visitor_id"],
    serviceableId: json["serviceable_id"],
    serviceableType: json["serviceable_type"],
    checkinGate: json["checkin_gate"],
    checkinTime: json["checkin_time"] == null ? null : DateTime.parse(json["checkin_time"]),
    checkoutGate: json["checkout_gate"],
    checkoutTime: json["checkout_time"] == null ? null : DateTime.parse(json["checkout_time"]),
    type: json["type"],
    purpose: json["purpose"],
    visitorCount: json["visitor_count"],
    idExpiry: json["id_expiry"],
    entryCardNumber: json["entry_card_number"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    description: json["description"],
    unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
    visitor: json["visitor"] == null ? null : Visitor.fromJson(json["visitor"]),
    vendor: json["vendor"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "association_id": associationId,
    "unit_id": unitId,
    "vendor_id": vendorId,
    "visitor_id": visitorId,
    "serviceable_id": serviceableId,
    "serviceable_type": serviceableType,
    "checkin_gate": checkinGate,
    "checkin_time": checkinTime?.toIso8601String(),
    "checkout_gate": checkoutGate,
    "checkout_time": checkoutTime?.toIso8601String(),
    "type": type,
    "purpose": purpose,
    "visitor_count": visitorCount,
    "id_expiry": idExpiry,
    "entry_card_number": entryCardNumber,
    "name": name,
    "phone": phone,
    "email": email,
    "description": description,
    "unit": unit?.toJson(),
    "visitor": visitor?.toJson(),
    "vendor": vendor,
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

class Visitor {
  int? id;
  String? name;
  String? phone;
  String? email;
  String? idNumber;
  DateTime? idIssueDate;
  DateTime? idExpiryDate;
  String? passportNumber;
  dynamic passportCountry;
  dynamic passportIssueDate;
  dynamic passportExpiryDate;
  dynamic companyName;
  String? gender;
  DateTime? dob;
  String? nationality;
  String? imagePath;
  dynamic occupation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  Visitor({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.idNumber,
    this.idIssueDate,
    this.idExpiryDate,
    this.passportNumber,
    this.passportCountry,
    this.passportIssueDate,
    this.passportExpiryDate,
    this.companyName,
    this.gender,
    this.dob,
    this.nationality,
    this.imagePath,
    this.occupation,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory Visitor.fromJson(Map<String, dynamic> json) => Visitor(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    idNumber: json["id_number"],
    idIssueDate: json["id_issue_date"] == null ? null : DateTime.parse(json["id_issue_date"]),
    idExpiryDate: json["id_expiry_date"] == null ? null : DateTime.parse(json["id_expiry_date"]),
    passportNumber: json["passport_number"],
    passportCountry: json["passport_country"],
    passportIssueDate: json["passport_issue_date"],
    passportExpiryDate: json["passport_expiry_date"],
    companyName: json["company_name"],
    gender: json["gender"],
    dob: json["dob"] == null ? null : DateTime.parse(json["dob"]),
    nationality: json["nationality"],
    imagePath: json["image_path"],
    occupation: json["occupation"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "id_number": idNumber,
    "id_issue_date": "${idIssueDate!.year.toString().padLeft(4, '0')}-${idIssueDate!.month.toString().padLeft(2, '0')}-${idIssueDate!.day.toString().padLeft(2, '0')}",
    "id_expiry_date": "${idExpiryDate!.year.toString().padLeft(4, '0')}-${idExpiryDate!.month.toString().padLeft(2, '0')}-${idExpiryDate!.day.toString().padLeft(2, '0')}",
    "passport_number": passportNumber,
    "passport_country": passportCountry,
    "passport_issue_date": passportIssueDate,
    "passport_expiry_date": passportExpiryDate,
    "company_name": companyName,
    "gender": gender,
    "dob": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "nationality": nationality,
    "image_path": imagePath,
    "occupation": occupation,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
  };
}
