class Country {
  int? id;
  String? sortname;
  String? name;
  dynamic isoCode2;
  dynamic isoCode3;
  dynamic phoneCode;
  int? phonecode;
  dynamic addressFormat;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? label;
  String? value;

  Country({
    this.id,
    this.sortname,
    this.name,
    this.isoCode2,
    this.isoCode3,
    this.phoneCode,
    this.phonecode,
    this.addressFormat,
    this.createdAt,
    this.updatedAt,
    this.label,
    this.value,
  });

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    id: json["id"],
    sortname: json["sortname"],
    name: json["name"],
    isoCode2: json["iso_code2"],
    isoCode3: json["iso_code3"],
    phoneCode: json["phone_code"],
    phonecode: json["phonecode"],
    addressFormat: json["address_format"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "sortname": sortname,
    "name": name,
    "iso_code2": isoCode2,
    "iso_code3": isoCode3,
    "phone_code": phoneCode,
    "phonecode": phonecode,
    "address_format": addressFormat,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "label": label,
    "value": value,
  };
}