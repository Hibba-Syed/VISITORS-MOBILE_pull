import '../serviceable.dart';
import '../unit/unit_model.dart';
import '../visitor_info/visitor_model.dart';
import 'check_ins_response_model.dart';

class CheckInModel {
  int? id;
  int? associationId;
  int? unitId;
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
  dynamic visitorCount;
  dynamic idExpiry;
  String? entryCardNumber;
  String? name;
  String? phone;
  String? email;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;
  UnitModel? unit;
  VisitorModel? visitor;
  Serviceable? serviceable;
  Vendor? vendor;
  bool? isMobile;

  CheckInModel({
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
    this.unit,
    this.visitor,
    this.serviceable,
    this.vendor,
    this.isMobile,
  });

  factory CheckInModel.fromJson(Map<String, dynamic> json) => CheckInModel(
        id: json["id"],
        associationId: json["association_id"],
        unitId: json["unit_id"],
        vendorId: json["vendor_id"],
        visitorId: json["visitor_id"],
        serviceableId: json["serviceable_id"],
        serviceableType: json["serviceable_type"],
        checkinGate: json["checkin_gate"],
        checkinTime: json["checkin_time"] == null
            ? null
            : DateTime.parse(json["checkin_time"]),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
        visitor:
            json["visitor"] == null ? null : VisitorModel.fromJson(json["visitor"]),
        serviceable: json["serviceable"] == null
            ? null
            : Serviceable.fromJson(json["serviceable"]),
        vendor: json["vendor"] == null ? null : Vendor.fromJson(json["vendor"]),
        isMobile: json["is_mobile"],
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
        "unit": unit?.toJson(),
        "visitor": visitor?.toJson(),
        "serviceable": serviceable?.toJson(),
        "vendor": vendor?.toJson(),
        "is_mobile": isMobile,
      };
}
