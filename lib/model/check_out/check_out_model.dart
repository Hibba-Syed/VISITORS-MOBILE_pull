import '../unit/unit_model.dart';
import '../visitor_model.dart';

class CheckOutModel {
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
  UnitModel? unit;
  Visitor? visitor;
  dynamic vendor;

  CheckOutModel({
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

  factory CheckOutModel.fromJson(Map<String, dynamic> json) => CheckOutModel(
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
    unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
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