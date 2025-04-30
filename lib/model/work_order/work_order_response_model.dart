// To parse this JSON data, do
//
//     final workOrderResponseModel = workOrderResponseModelFromJson(jsonString);

import 'dart:convert';

WorkOrderResponseModel workOrderResponseModelFromJson(String str) => WorkOrderResponseModel.fromJson(json.decode(str));

String workOrderResponseModelToJson(WorkOrderResponseModel data) => json.encode(data.toJson());

class WorkOrderResponseModel {
  String? status;
  List<Record>? record;
  int? code;
  Meta? meta;
  bool? requestStatus;
  String? message;

  WorkOrderResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory WorkOrderResponseModel.fromJson(Map<String, dynamic> json) => WorkOrderResponseModel(
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
  String? status;
  int? isAwarded;
  String? reference;
  int? associationId;
  String? title;
  DateTime? startDate;
  DateTime? finishDate;
  dynamic publishedDate;
  dynamic expiry;
  int? vendorId;
  DateTime? createdAt;
  NewVendor? newVendor;
  List<ActiveCheckIn>? activeCheckIns;

  Record({
    this.id,
    this.status,
    this.isAwarded,
    this.reference,
    this.associationId,
    this.title,
    this.startDate,
    this.finishDate,
    this.publishedDate,
    this.expiry,
    this.vendorId,
    this.createdAt,
    this.newVendor,
    this.activeCheckIns,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    status: json["status"],
    isAwarded: json["is_awarded"],
    reference: json["reference"],
    associationId: json["association_id"],
    title: json["title"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    finishDate: json["finish_date"] == null ? null : DateTime.parse(json["finish_date"]),
    publishedDate: json["published_date"],
    expiry: json["expiry"],
    vendorId: json["vendor_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    newVendor: json["new_vendor"] == null ? null : NewVendor.fromJson(json["new_vendor"]),
    activeCheckIns: json["active_check_ins"] == null ? [] : List<ActiveCheckIn>.from(json["active_check_ins"]!.map((x) => ActiveCheckIn.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "status": status,
    "is_awarded": isAwarded,
    "reference": reference,
    "association_id": associationId,
    "title": title,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "finish_date": "${finishDate!.year.toString().padLeft(4, '0')}-${finishDate!.month.toString().padLeft(2, '0')}-${finishDate!.day.toString().padLeft(2, '0')}",
    "published_date": publishedDate,
    "expiry": expiry,
    "vendor_id": vendorId,
    "created_at": createdAt?.toIso8601String(),
    "new_vendor": newVendor?.toJson(),
    "active_check_ins": activeCheckIns == null ? [] : List<dynamic>.from(activeCheckIns!.map((x) => x.toJson())),
  };
}

class ActiveCheckIn {
  int? id;
  int? associationId;
  dynamic unitId;
  int? vendorId;
  int? visitorId;
  int? serviceableId;
  String? serviceableType;
  String? checkinGate;
  DateTime? checkinTime;
  dynamic checkoutGate;
  dynamic checkoutTime;
  String? type;
  String? purpose;
  String? visitorCount;
  dynamic idExpiry;
  String? entryCardNumber;
  String? name;
  String? phone;
  String? email;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;

  ActiveCheckIn({
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
    this.createdAt,
    this.updatedAt,
  });

  factory ActiveCheckIn.fromJson(Map<String, dynamic> json) => ActiveCheckIn(
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
    checkoutTime: json["checkout_time"],
    type: json["type"],
    purpose: json["purpose"],
    visitorCount: json["visitor_count"],
    idExpiry: json["id_expiry"],
    entryCardNumber: json["entry_card_number"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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
    "checkout_time": checkoutTime,
    "type": type,
    "purpose": purpose,
    "visitor_count": visitorCount,
    "id_expiry": idExpiry,
    "entry_card_number": entryCardNumber,
    "name": name,
    "phone": phone,
    "email": email,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}

class NewVendor {
  int? id;
  String? name;
  String? companyName;
  dynamic user;

  NewVendor({
    this.id,
    this.name,
    this.companyName,
    this.user,
  });

  factory NewVendor.fromJson(Map<String, dynamic> json) => NewVendor(
    id: json["id"],
    name: json["name"],
    companyName: json["company_name"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "user": user,
  };
}
