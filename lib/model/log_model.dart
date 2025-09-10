class LogModel {
  int? id;
  int? visitorCheckinId;
  String? status;
  String? description;
  DateTime? createdAt;
  DateTime? updatedAt;

  LogModel({
    this.id,
    this.visitorCheckinId,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  factory LogModel.fromJson(Map<String, dynamic> json) => LogModel(
    id: json["id"],
    visitorCheckinId: json["visitor_checkin_id"],
    status: json["status"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "visitor_checkin_id": visitorCheckinId,
    "status": status,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}