import '../user_model.dart';

class StatusHistory {
  int? id;
  int? userId;
  dynamic type;
  int? applicationId;
  dynamic reference;
  dynamic refferedType;
  dynamic refferedId;
  String? status;
  String? note;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? userTo;
  int? userFrom;
  User? user;

  StatusHistory({
    this.id,
    this.userId,
    this.type,
    this.applicationId,
    this.reference,
    this.refferedType,
    this.refferedId,
    this.status,
    this.note,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.userTo,
    this.userFrom,
    this.user,

  });

  factory StatusHistory.fromJson(Map<String, dynamic> json) => StatusHistory(
    id: json["id"],
    userId: json["user_id"],
    type: json["type"],
    applicationId: json["application_id"],
    reference: json["reference"],
    refferedType: json["reffered_type"],
    refferedId: json["reffered_id"],
    status: json["status"],
    note: json["note"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    userTo: json["user_to"],
    userFrom: json["user_from"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "type": type,
    "application_id": applicationId,
    "reference": reference,
    "reffered_type": refferedType,
    "reffered_id": refferedId,
    "status": status,
    "note": note,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "user_to": userTo,
    "user_from": userFrom,
    "user": user?.toJson(),
  };
}