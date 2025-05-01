class User {
  int? id;
  String? reference;
  String? username;
  String? firstName;
  String? lastName;
  int? companyId;
  int? roleId;
  String? email;
  String? mobile;
  String? fullName;
  int? isCompanyAvailable;
  String? profileImageUrl;
  List<dynamic>? myCityAssociations;
  String? idFileUrl;

  User({
    this.id,
    this.reference,
    this.username,
    this.firstName,
    this.lastName,
    this.companyId,
    this.roleId,
    this.email,
    this.mobile,
    this.fullName,
    this.isCompanyAvailable,
    this.profileImageUrl,
    this.myCityAssociations,
    this.idFileUrl,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        reference: json["reference"],
        username: json["username"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        companyId: json["company_id"],
        roleId: json["role_id"],
        email: json["email"],
        mobile: json["mobile"],
        fullName: json["full_name"],
        isCompanyAvailable: json["is_company_available"],
        profileImageUrl: json["profile_image_url"],
        myCityAssociations: json["my_city_associations"] == null
            ? []
            : List<dynamic>.from(json["my_city_associations"]!.map((x) => x)),
        idFileUrl: json["id_file_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "reference": reference,
        "username": username,
        "first_name": firstName,
        "last_name": lastName,
        "company_id": companyId,
        "role_id": roleId,
        "email": email,
        "mobile": mobile,
        "full_name": fullName,
        "is_company_available": isCompanyAvailable,
        "profile_image_url": profileImageUrl,
        "my_city_associations": myCityAssociations == null
            ? []
            : List<dynamic>.from(myCityAssociations!.map((x) => x)),
        "id_file_url": idFileUrl,
      };
}
