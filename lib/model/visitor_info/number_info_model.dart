class NumberInfo {
  int? id;
  String? name;
  String? phone;
  dynamic email;
  dynamic idNumber;
  dynamic idIssueDate;
  dynamic idExpiryDate;
  dynamic passportNumber;
  dynamic passportCountry;
  dynamic passportIssueDate;
  dynamic passportExpiryDate;
  dynamic companyName;
  dynamic gender;
  dynamic dob;
  String? nationality;
  dynamic imagePath;
  dynamic occupation;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? imageUrl;

  NumberInfo({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.idNumber,
    this.idIssueDate,
    this.idExpiryDate,
    this.passportNumber,
    this.passportCountry,
    this.passportIssueDate,
    this.passportExpiryDate,
    this.companyName,
    this.gender,
    this.dob,
    this.nationality,
    this.imagePath,
    this.occupation,
    this.createdAt,
    this.updatedAt,
    this.imageUrl,
  });

  factory NumberInfo.fromJson(Map<String, dynamic> json) => NumberInfo(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    email: json["email"],
    idNumber: json["id_number"],
    idIssueDate: json["id_issue_date"],
    idExpiryDate: json["id_expiry_date"],
    passportNumber: json["passport_number"],
    passportCountry: json["passport_country"],
    passportIssueDate: json["passport_issue_date"],
    passportExpiryDate: json["passport_expiry_date"],
    companyName: json["company_name"],
    gender: json["gender"],
    dob: json["dob"],
    nationality: json["nationality"],
    imagePath: json["image_path"],
    occupation: json["occupation"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "email": email,
    "id_number": idNumber,
    "id_issue_date": idIssueDate,
    "id_expiry_date": idExpiryDate,
    "passport_number": passportNumber,
    "passport_country": passportCountry,
    "passport_issue_date": passportIssueDate,
    "passport_expiry_date": passportExpiryDate,
    "company_name": companyName,
    "gender": gender,
    "dob": dob,
    "nationality": nationality,
    "image_path": imagePath,
    "occupation": occupation,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "image_url": imageUrl,
  };
}