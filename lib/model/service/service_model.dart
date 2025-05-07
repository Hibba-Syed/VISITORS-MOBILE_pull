import '../active_checkIn_model.dart';
import '../association_model.dart';
import '../unit/unit_model.dart';

class ServiceModel {
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
  UnitModel? unit;
  List<ActiveCheckIn>? activeCheckIns;
  Association? association;

  ServiceModel({
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

  factory ServiceModel.fromJson(Map<String, dynamic> json) => ServiceModel(
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
    unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
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