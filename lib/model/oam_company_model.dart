import 'package:visitors/model/user_model.dart';

class OamCompany {
  int? id;
  String? type;
  int? userId;
  String? companyName;
  String? contactNumber;
  String? contactEmail;
  User? user;

  OamCompany({
    this.id,
    this.type,
    this.userId,
    this.companyName,
    this.contactNumber,
    this.contactEmail,
    this.user,
  });

  factory OamCompany.fromJson(Map<String, dynamic> json) => OamCompany(
    id: json["id"],
    type: json["type"],
    userId: json["user_id"],
    companyName: json["company_name"],
    contactNumber: json["contact_number"],
    contactEmail: json["contact_email"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "user_id": userId,
    "company_name": companyName,
    "contact_number": contactNumber,
    "contact_email": contactEmail,
    "user": user?.toJson(),
  };
}