class City {
  int? id;
  String? name;
  String? label;
  String? value;
  int? stateId;
  DateTime? createdAt;
  DateTime? updatedAt;


  City({
    this.id,
    this.name,
    this.label,
    this.value,
    this.stateId,
    this.createdAt,
    this.updatedAt,

  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    label: json["label"],
    value: json["value"],
    stateId: json["state_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "label": label,
    "value": value,
    "state_id": stateId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}