import '../unit/unit_model.dart';
import '../visitor_info/visitor_model.dart';

class CheckOutModel {
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
    this.visitorCountTotal,
    this.idExpiry,
    this.entryCardNumber,
    this.name,
    this.phone,
    this.email,
    this.description,
    this.isMobile,
    this.createdAt,
    this.updatedAt,
    this.unit,
    this.visitor,
    this.vendor,});

  CheckOutModel.fromJson(dynamic json) {
    id = json['id'];
    associationId = json['association_id'];
    unitId = json['unit_id'];
    vendorId = json['vendor_id'];
    visitorId = json['visitor_id'];
    serviceableId = json['serviceable_id'];
    serviceableType = json['serviceable_type'];
    checkinGate = json['checkin_gate'];
    checkinTime = json['checkin_time'];
    checkoutGate = json['checkout_gate'];
    checkoutTime = json['checkout_time'];
    type = json['type'];
    purpose = json['purpose'];
    visitorCount = json['visitor_count'];
    visitorCountTotal = json['visitor_count_total'];
    idExpiry = json['id_expiry'];
    entryCardNumber = json['entry_card_number'];
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    description = json['description'];
    isMobile = json['is_mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    unit = json['unit'] != null ? UnitModel.fromJson(json['unit']) : null;
    visitor = json['visitor'] != null ? VisitorModel.fromJson(json['visitor']) : null;
    vendor = json['vendor'];
  }
  int? id;
  int? associationId;
  int? unitId;
  dynamic vendorId;
  int? visitorId;
  int? serviceableId;
  String? serviceableType;
  String? checkinGate;
  String? checkinTime;
  String? checkoutGate;
  String? checkoutTime;
  String? type;
  String? purpose;
  dynamic visitorCount;
  dynamic visitorCountTotal;
  String? idExpiry;
  String? entryCardNumber;
  String? name;
  String? phone;
  String? email;
  String? description;
  bool? isMobile;
  String? createdAt;
  String? updatedAt;
  UnitModel? unit;
  VisitorModel? visitor;
  dynamic vendor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['association_id'] = associationId;
    map['unit_id'] = unitId;
    map['vendor_id'] = vendorId;
    map['visitor_id'] = visitorId;
    map['serviceable_id'] = serviceableId;
    map['serviceable_type'] = serviceableType;
    map['checkin_gate'] = checkinGate;
    map['checkin_time'] = checkinTime;
    map['checkout_gate'] = checkoutGate;
    map['checkout_time'] = checkoutTime;
    map['type'] = type;
    map['purpose'] = purpose;
    map['visitor_count'] = visitorCount;
    map['visitor_count_total'] = visitorCountTotal;
    map['id_expiry'] = idExpiry;
    map['entry_card_number'] = entryCardNumber;
    map['name'] = name;
    map['phone'] = phone;
    map['email'] = email;
    map['description'] = description;
    map['is_mobile'] = isMobile;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    if (unit != null) {
      map['unit'] = unit?.toJson();
    }
    if (visitor != null) {
      map['visitor'] = visitor?.toJson();
    }
    map['vendor'] = vendor;
    return map;
  }

}