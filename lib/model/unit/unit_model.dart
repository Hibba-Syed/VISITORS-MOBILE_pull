class UnitModel {
  int? id;
  String? unitNumber;
  int? residentId;
  int? associationId;
  bool? isLegalNoticeActive;
  bool? isRdcActive;
  String? titleDeedUrl;
  List<PrimaryOwner>? primaryOwner;
  Resident? resident;

  UnitModel({
    this.id,
    this.unitNumber,
    this.residentId,
    this.associationId,
    this.isLegalNoticeActive,
    this.isRdcActive,
    this.titleDeedUrl,
    this.primaryOwner,
    this.resident,
  });

  factory UnitModel.fromJson(Map<String, dynamic> json) => UnitModel(
        id: json["id"],
        unitNumber: json["unit_number"],
        residentId: json["resident_id"],
        associationId: json["association_id"],
        isLegalNoticeActive: json["is_legal_notice_active"],
        isRdcActive: json["is_rdc_active"],
        titleDeedUrl: json["title_deed_url"],
        primaryOwner: json["primary_owner"] == null
            ? []
            : List<PrimaryOwner>.from(
                json["primary_owner"]!.map((x) => PrimaryOwner.fromJson(x))),
        resident: json["resident"] == null
            ? null
            : Resident.fromJson(json["resident"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "unit_number": unitNumber,
        "resident_id": residentId,
        "association_id": associationId,
        "is_legal_notice_active": isLegalNoticeActive,
        "is_rdc_active": isRdcActive,
        "title_deed_url": titleDeedUrl,
        "primary_owner": primaryOwner == null
            ? []
            : List<dynamic>.from(primaryOwner!.map((x) => x.toJson())),
        "resident": resident?.toJson(),
      };
}

class PrimaryOwner {
  int? id;
  String? firstName;
  String? lastName;
  String? primaryPhone;
  String? primaryEmail;
  String? fullName;
  String? idFileUrl;
  String? titleDeedUrl;
  String? tenancyContractUrl;
  String? tradeLicenseUrl;
  String? passportFileUrl;
  String? emiratesIdFileUrl;
  String? profileImageUrl;
  String? fullAddress;
  String? agentDocUrl;
  Pivot? pivot;

  PrimaryOwner({
    this.id,
    this.firstName,
    this.lastName,
    this.primaryPhone,
    this.primaryEmail,
    this.fullName,
    this.idFileUrl,
    this.titleDeedUrl,
    this.tenancyContractUrl,
    this.tradeLicenseUrl,
    this.passportFileUrl,
    this.emiratesIdFileUrl,
    this.profileImageUrl,
    this.fullAddress,
    this.agentDocUrl,
    this.pivot,
  });

  factory PrimaryOwner.fromJson(Map<String, dynamic> json) => PrimaryOwner(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        primaryPhone: json["primary_phone"],
        primaryEmail: json["primary_email"],
        fullName: json["full_name"],
        idFileUrl: json["id_file_url"],
        titleDeedUrl: json["title_deed_url"],
        tenancyContractUrl: json["tenancy_contract_url"],
        tradeLicenseUrl: json["trade_license_url"],
        passportFileUrl: json["passport_file_url"],
        emiratesIdFileUrl: json["emirates_id_file_url"],
        profileImageUrl: json["profile_image_url"],
        fullAddress: json["full_address"],
        agentDocUrl: json["agent_doc_url"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "primary_phone": primaryPhone,
        "primary_email": primaryEmail,
        "full_name": fullName,
        "id_file_url": idFileUrl,
        "title_deed_url": titleDeedUrl,
        "tenancy_contract_url": tenancyContractUrl,
        "trade_license_url": tradeLicenseUrl,
        "passport_file_url": passportFileUrl,
        "emirates_id_file_url": emiratesIdFileUrl,
        "profile_image_url": profileImageUrl,
        "full_address": fullAddress,
        "agent_doc_url": agentDocUrl,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  int? unitId;
  int? ownerId;
  int? id;
  int? isPrimary;
  DateTime? startDate;
  dynamic endDate;
  String? communicationEmail;
  String? communicationPhone;
  String? titleDeed;
  int? isCurrent;
  String? titleDeedNumber;
  String? ownerNumber;

  Pivot({
    this.unitId,
    this.ownerId,
    this.id,
    this.isPrimary,
    this.startDate,
    this.endDate,
    this.communicationEmail,
    this.communicationPhone,
    this.titleDeed,
    this.isCurrent,
    this.titleDeedNumber,
    this.ownerNumber,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        unitId: json["unit_id"],
        ownerId: json["owner_id"],
        id: json["id"],
        isPrimary: json["is_primary"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate: json["end_date"],
        communicationEmail: json["communication_email"],
        communicationPhone: json["communication_phone"],
        titleDeed: json["title_deed"],
        isCurrent: json["is_current"],
        titleDeedNumber: json["title_deed_number"],
        ownerNumber: json["owner_number"],
      );

  Map<String, dynamic> toJson() => {
        "unit_id": unitId,
        "owner_id": ownerId,
        "id": id,
        "is_primary": isPrimary,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date": endDate,
        "communication_email": communicationEmail,
        "communication_phone": communicationPhone,
        "title_deed": titleDeed,
        "is_current": isCurrent,
        "title_deed_number": titleDeedNumber,
        "owner_number": ownerNumber,
      };
}

class Resident {
  int? id;
  String? firstName;
  String? lastName;
  String? primaryPhone;
  String? primaryEmail;
  String? fullName;
  String? idFileUrl;
  String? titleDeedUrl;
  String? tenancyContractUrl;
  String? tradeLicenseUrl;
  String? passportFileUrl;
  String? emiratesIdFileUrl;
  String? profileImageUrl;
  String? fullAddress;
  String? agentDocUrl;

  Resident({
    this.id,
    this.firstName,
    this.lastName,
    this.primaryPhone,
    this.primaryEmail,
    this.fullName,
    this.idFileUrl,
    this.titleDeedUrl,
    this.tenancyContractUrl,
    this.tradeLicenseUrl,
    this.passportFileUrl,
    this.emiratesIdFileUrl,
    this.profileImageUrl,
    this.fullAddress,
    this.agentDocUrl,
  });

  factory Resident.fromJson(Map<String, dynamic> json) => Resident(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        primaryPhone: json["primary_phone"],
        primaryEmail: json["primary_email"],
        fullName: json["full_name"],
        idFileUrl: json["id_file_url"],
        titleDeedUrl: json["title_deed_url"],
        tenancyContractUrl: json["tenancy_contract_url"],
        tradeLicenseUrl: json["trade_license_url"],
        passportFileUrl: json["passport_file_url"],
        emiratesIdFileUrl: json["emirates_id_file_url"],
        profileImageUrl: json["profile_image_url"],
        fullAddress: json["full_address"],
        agentDocUrl: json["agent_doc_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "primary_phone": primaryPhone,
        "primary_email": primaryEmail,
        "full_name": fullName,
        "id_file_url": idFileUrl,
        "title_deed_url": titleDeedUrl,
        "tenancy_contract_url": tenancyContractUrl,
        "trade_license_url": tradeLicenseUrl,
        "passport_file_url": passportFileUrl,
        "emirates_id_file_url": emiratesIdFileUrl,
        "profile_image_url": profileImageUrl,
        "full_address": fullAddress,
        "agent_doc_url": agentDocUrl,
      };
}
