import '../unit/unit_model.dart';

class OwnerUnit {
  int? id;
  int? unitId;
  int? ownerId;
  String? titleDeedUrl;
  UnitModel? unit;

  OwnerUnit({
    this.id,
    this.unitId,
    this.ownerId,
    this.titleDeedUrl,
    this.unit,
  });

  factory OwnerUnit.fromJson(Map<String, dynamic> json) => OwnerUnit(
    id: json["id"],
    unitId: json["unit_id"],
    ownerId: json["owner_id"],
    titleDeedUrl: json["title_deed_url"],
    unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_id": unitId,
    "owner_id": ownerId,
    "title_deed_url": titleDeedUrl,
    "unit": unit?.toJson(),
  };
}