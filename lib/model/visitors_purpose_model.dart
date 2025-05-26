class VisitorsPurpose {
  int? id;
  int? associationId;
  String? purpose;
  int? order;
  DateTime? createdAt;
  DateTime? updatedAt;

  VisitorsPurpose({
    this.id,
    this.associationId,
    this.purpose,
    this.order,
    this.createdAt,
    this.updatedAt,
  });

  factory VisitorsPurpose.fromJson(Map<String, dynamic> json) => VisitorsPurpose(
    id: json["id"],
    associationId: json["association_id"],
    purpose: json["purpose"],
    order: json["order"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "association_id": associationId,
    "purpose": purpose,
    "order": order,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}