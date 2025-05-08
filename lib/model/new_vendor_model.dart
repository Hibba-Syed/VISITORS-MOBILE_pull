class NewVendor {
  int? id;
  String? name;
  String? companyName;
  dynamic user;

  NewVendor({
    this.id,
    this.name,
    this.companyName,
    this.user,
  });

  factory NewVendor.fromJson(Map<String, dynamic> json) => NewVendor(
    id: json["id"],
    name: json["name"],
    companyName: json["company_name"],
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "user": user,
  };
}