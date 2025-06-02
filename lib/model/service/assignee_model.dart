class Assignee {
  int? id;
  String? reference;
  String? username;
  int? roleId;
  int? userTypeId;
  String? email;
  int? status;
  String? firstName;
  String? lastName;
  String? mobile;
  String? designation;
  String? profilePicture;
  dynamic dob;
  dynamic passportNumber;
  dynamic passportExpiry;
  dynamic emiratesId;
  dynamic emiratesIdExpiry;
  dynamic idFile;
  int? isEmailVerified;
  int? isMobileVerified;
  int? isBlocked;
  bool? isAuditor;
  dynamic organizationName;
  DateTime? passwordUpdatedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? companyId;
  String? view;
  int? canViewAll;
  String? intercomHash;
  dynamic pcLimit;
  String? fullName;
  int? isCompanyAvailable;
  String? profileImageUrl;
  List<dynamic>? myCityAssociations;
  String? idFileUrl;

  Assignee({
    this.id,
    this.reference,
    this.username,
    this.roleId,
    this.userTypeId,
    this.email,
    this.status,
    this.firstName,
    this.lastName,
    this.mobile,
    this.designation,
    this.profilePicture,
    this.dob,
    this.passportNumber,
    this.passportExpiry,
    this.emiratesId,
    this.emiratesIdExpiry,
    this.idFile,
    this.isEmailVerified,
    this.isMobileVerified,
    this.isBlocked,
    this.isAuditor,
    this.organizationName,
    this.passwordUpdatedAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.companyId,
    this.view,
    this.canViewAll,
    this.intercomHash,
    this.pcLimit,
    this.fullName,
    this.isCompanyAvailable,
    this.profileImageUrl,
    this.myCityAssociations,
    this.idFileUrl,
  });

  factory Assignee.fromJson(Map<String, dynamic> json) => Assignee(
    id: json["id"],
    reference: json["reference"],
    username: json["username"],
    roleId: json["role_id"],
    userTypeId: json["user_type_id"],
    email: json["email"],
    status: json["status"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    mobile: json["mobile"],
    designation: json["designation"],
    profilePicture: json["profile_picture"],
    dob: json["dob"],
    passportNumber: json["passport_number"],
    passportExpiry: json["passport_expiry"],
    emiratesId: json["emirates_id"],
    emiratesIdExpiry: json["emirates_id_expiry"],
    idFile: json["id_file"],
    isEmailVerified: json["is_email_verified"],
    isMobileVerified: json["is_mobile_verified"],
    isBlocked: json["is_blocked"],
    isAuditor: json["is_auditor"],
    organizationName: json["organization_name"],
    passwordUpdatedAt: json["password_updated_at"] == null ? null : DateTime.parse(json["password_updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    companyId: json["company_id"],
    view: json["view"],
    canViewAll: json["can_view_all"],
    intercomHash: json["intercom_hash"],
    pcLimit: json["pc_limit"],
    fullName: json["full_name"],
    isCompanyAvailable: json["is_company_available"],
    profileImageUrl: json["profile_image_url"],
    myCityAssociations: json["my_city_associations"] == null ? [] : List<dynamic>.from(json["my_city_associations"]!.map((x) => x)),
    idFileUrl: json["id_file_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "username": username,
    "role_id": roleId,
    "user_type_id": userTypeId,
    "email": email,
    "status": status,
    "first_name": firstName,
    "last_name": lastName,
    "mobile": mobile,
    "designation": designation,
    "profile_picture": profilePicture,
    "dob": dob,
    "passport_number": passportNumber,
    "passport_expiry": passportExpiry,
    "emirates_id": emiratesId,
    "emirates_id_expiry": emiratesIdExpiry,
    "id_file": idFile,
    "is_email_verified": isEmailVerified,
    "is_mobile_verified": isMobileVerified,
    "is_blocked": isBlocked,
    "is_auditor": isAuditor,
    "organization_name": organizationName,
    "password_updated_at": passwordUpdatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "company_id": companyId,
    "view": view,
    "can_view_all": canViewAll,
    "intercom_hash": intercomHash,
    "pc_limit": pcLimit,
    "full_name": fullName,
    "is_company_available": isCompanyAvailable,
    "profile_image_url": profileImageUrl,
    "my_city_associations": myCityAssociations == null ? [] : List<dynamic>.from(myCityAssociations!.map((x) => x)),
    "id_file_url": idFileUrl,
  };
}