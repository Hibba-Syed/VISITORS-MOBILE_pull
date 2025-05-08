import '../active_checkIn_model.dart';
import '../new_vendor_model.dart';

class WorkOrderModel {
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

  WorkOrderModel({
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

  factory WorkOrderModel.fromJson(Map<String, dynamic> json) => WorkOrderModel(
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