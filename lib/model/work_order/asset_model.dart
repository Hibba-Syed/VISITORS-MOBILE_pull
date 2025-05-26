import '../unit/unit_model.dart';

class Asset {
  int? id;
  String? name;
  dynamic fullLocation;
  String? warrantyAttachmentUrl;
  String? fullName;
  Pivot? pivot;

  Asset({
    this.id,
    this.name,
    this.fullLocation,
    this.warrantyAttachmentUrl,
    this.fullName,
    this.pivot,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json["id"],
    name: json["name"],
    fullLocation: json["full_location"],
    warrantyAttachmentUrl: json["warranty_attachment_url"],
    fullName: json["full_name"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "full_location": fullLocation,
    "warranty_attachment_url": warrantyAttachmentUrl,
    "full_name": fullName,
    "pivot": pivot?.toJson(),
  };
}