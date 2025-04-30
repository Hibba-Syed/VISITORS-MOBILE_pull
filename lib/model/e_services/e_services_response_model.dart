// To parse this JSON data, do
//
//     final eServicesResponseModel = eServicesResponseModelFromJson(jsonString);

import 'dart:convert';

EServicesResponseModel eServicesResponseModelFromJson(String str) => EServicesResponseModel.fromJson(json.decode(str));

String eServicesResponseModelToJson(EServicesResponseModel data) => json.encode(data.toJson());

class EServicesResponseModel {
  String? status;
  List<Record>? record;
  int? code;
  Meta? meta;
  bool? requestStatus;
  String? message;

  EServicesResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory EServicesResponseModel.fromJson(Map<String, dynamic> json) => EServicesResponseModel(
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
  String? reference;
  String? applicationTitle;
  int? unitId;
  String? clientName;
  String? status;
  int? associationId;
  int? applicationId;
  DateTime? createdAt;
  String? applicationType;
  Unit? unit;
  List<ActiveCheckIn>? activeCheckIns;
  Association? association;

  Record({
    this.id,
    this.reference,
    this.applicationTitle,
    this.unitId,
    this.clientName,
    this.status,
    this.associationId,
    this.applicationId,
    this.createdAt,
    this.applicationType,
    this.unit,
    this.activeCheckIns,
    this.association,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    reference: json["reference"],
    applicationTitle: json["application_title"],
    unitId: json["unit_id"],
    clientName: json["client_name"],
    status: json["status"],
    associationId: json["association_id"],
    applicationId: json["application_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    applicationType: json["application_type"],
    unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
    activeCheckIns: json["active_check_ins"] == null ? [] : List<ActiveCheckIn>.from(json["active_check_ins"]!.map((x) => ActiveCheckIn.fromJson(x))),
    association: json["association"] == null ? null : Association.fromJson(json["association"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "application_title": applicationTitle,
    "unit_id": unitId,
    "client_name": clientName,
    "status": status,
    "association_id": associationId,
    "application_id": applicationId,
    "created_at": createdAt?.toIso8601String(),
    "application_type": applicationType,
    "unit": unit?.toJson(),
    "active_check_ins": activeCheckIns == null ? [] : List<dynamic>.from(activeCheckIns!.map((x) => x.toJson())),
    "association": association?.toJson(),
  };
}

class ActiveCheckIn {
  int? id;
  int? associationId;
  int? unitId;
  dynamic vendorId;
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

class Association {
  int? id;
  String? name;
  dynamic arabicName;
  int? remainingUnit;
  String? aboutPageImageUrl;
  String? backgroundImageUrl;
  String? logoImageUrl;
  String? fullAddress;
  double? unitsArea;
  int? applicableArea;
  int? suiteArea;
  int? balconyArea;
  int? filledParkings;
  dynamic subdomain;
  String? contractUrl;
  dynamic gmap;
  int? paymentGatewayEnabled;
  dynamic city;
  dynamic associationType;

  Association({
    this.id,
    this.name,
    this.arabicName,
    this.remainingUnit,
    this.aboutPageImageUrl,
    this.backgroundImageUrl,
    this.logoImageUrl,
    this.fullAddress,
    this.unitsArea,
    this.applicableArea,
    this.suiteArea,
    this.balconyArea,
    this.filledParkings,
    this.subdomain,
    this.contractUrl,
    this.gmap,
    this.paymentGatewayEnabled,
    this.city,
    this.associationType,
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
    id: json["id"],
    name: json["name"],
    arabicName: json["arabic_name"],
    remainingUnit: json["remaining_unit"],
    aboutPageImageUrl: json["about_page_image_url"],
    backgroundImageUrl: json["background_image_url"],
    logoImageUrl: json["logo_image_url"],
    fullAddress: json["full_address"],
    unitsArea: json["units_area"]?.toDouble(),
    applicableArea: json["applicable_area"],
    suiteArea: json["suite_area"],
    balconyArea: json["balcony_area"],
    filledParkings: json["filled_parkings"],
    subdomain: json["subdomain"],
    contractUrl: json["contract_url"],
    gmap: json["gmap"],
    paymentGatewayEnabled: json["payment_gateway_enabled"],
    city: json["city"],
    associationType: json["association_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "arabic_name": arabicName,
    "remaining_unit": remainingUnit,
    "about_page_image_url": aboutPageImageUrl,
    "background_image_url": backgroundImageUrl,
    "logo_image_url": logoImageUrl,
    "full_address": fullAddress,
    "units_area": unitsArea,
    "applicable_area": applicableArea,
    "suite_area": suiteArea,
    "balcony_area": balconyArea,
    "filled_parkings": filledParkings,
    "subdomain": subdomain,
    "contract_url": contractUrl,
    "gmap": gmap,
    "payment_gateway_enabled": paymentGatewayEnabled,
    "city": city,
    "association_type": associationType,
  };
}

class Unit {
  int? id;
  String? unitNumber;
  String? titleDeedUrl;

  Unit({
    this.id,
    this.unitNumber,
    this.titleDeedUrl,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    unitNumber: json["unit_number"],
    titleDeedUrl: json["title_deed_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_number": unitNumber,
    "title_deed_url": titleDeedUrl,
  };
}
