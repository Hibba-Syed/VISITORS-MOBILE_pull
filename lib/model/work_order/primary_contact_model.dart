class PrimaryContact {
  int? id;
  int? jpJobId;
  String? name;
  String? email;
  String? contactNumber;
  int? isPrimary;

  PrimaryContact({
    this.id,
    this.jpJobId,
    this.name,
    this.email,
    this.contactNumber,
    this.isPrimary,
  });

  factory PrimaryContact.fromJson(Map<String, dynamic> json) => PrimaryContact(
    id: json["id"],
    jpJobId: json["jp_job_id"],
    name: json["name"],
    email: json["email"],
    contactNumber: json["contact_number"],
    isPrimary: json["is_primary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jp_job_id": jpJobId,
    "name": name,
    "email": email,
    "contact_number": contactNumber,
    "is_primary": isPrimary,
  };
}