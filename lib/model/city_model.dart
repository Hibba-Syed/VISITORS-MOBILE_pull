class City {
  int? id;
  String? name;
  String? label;
  String? value;

  City({
    this.id,
    this.name,
    this.label,
    this.value,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "label": label,
    "value": value,
  };
}