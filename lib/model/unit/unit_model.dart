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
  String? name;
  dynamic mollakUnitName;
  int? unitSizeSqft;
  dynamic unitTypeId;
  int? componentId;
  dynamic subComponentId;
  dynamic balconyArea;
  dynamic suiteArea;
  int? applicableArea;
  dynamic virtualAccountNumber;
  dynamic plotNo;
  int? parkingCount;
  int? actualArea;
  int? bedroomCount;
  dynamic bathroomCount;
  int? isOccupied;
  dynamic datePurchased;
  int? isActive;
  dynamic saleDeed;
  int? isParking;
  int? isParkingAvailable;
  int? parkings;
  String? adult;
  dynamic child;
  dynamic agentId;
  dynamic leaseCompanyId;
  String? unitExternalId;
  int? isMollakEnable;
  dynamic landType;
  dynamic landStatus;
  dynamic zoneCode;
  int? recoveryReminderStatus;
  String? recoveryAnalysisNote;
  String? status;
  double? balance;
  int? pdc;
  int? isLfpExempt;
  dynamic mollakBuildingEnglishName;
  dynamic mollakBuildingArabicName;
  dynamic dtcmPermit;
  dynamic dtcmPermitExpiry;
  String? titleDeed;
  String? titleDeedNumber;
  dynamic vaNumber;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic deletedAt;

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
    this.name,
    this.mollakUnitName,
    this.unitSizeSqft,
    this.unitTypeId,
    this.componentId,
    this.subComponentId,
    this.balconyArea,
    this.suiteArea,
    this.applicableArea,
    this.virtualAccountNumber,
    this.plotNo,
    this.parkingCount,
    this.actualArea,
    this.bedroomCount,
    this.bathroomCount,
    this.isOccupied,
    this.datePurchased,
    this.isActive,
    this.saleDeed,
    this.isParking,
    this.isParkingAvailable,
    this.parkings,
    this.adult,
    this.child,
    this.agentId,
    this.leaseCompanyId,
    this.unitExternalId,
    this.isMollakEnable,
    this.landType,
    this.landStatus,
    this.zoneCode,
    this.recoveryReminderStatus,
    this.recoveryAnalysisNote,
    this.status,
    this.balance,
    this.pdc,
    this.isLfpExempt,
    this.mollakBuildingEnglishName,
    this.mollakBuildingArabicName,
    this.dtcmPermit,
    this.dtcmPermitExpiry,
    this.titleDeed,
    this.titleDeedNumber,
    this.vaNumber,
    this.updatedAt,
    this.createdAt,
    this.deletedAt,
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
        name: json["name"],
        mollakUnitName: json["mollak_unit_name"],
        unitSizeSqft: json["unit_size_sqft"],
        unitTypeId: json["unit_type_id"],
        componentId: json["component_id"],
        subComponentId: json["sub_component_id"],
        balconyArea: json["balcony_area"],
        suiteArea: json["suite_area"],
        applicableArea: json["applicable_area"],
        virtualAccountNumber: json["virtual_account_number"],
        plotNo: json["plot_no"],
        parkingCount: json["parking_count"],
        actualArea: json["actual_area"],
        bedroomCount: json["bedroom_count"],
        bathroomCount: json["bathroom_count"],
        isOccupied: json["is_occupied"],
        datePurchased: json["date_purchased"],
        isActive: json["is_active"],
        saleDeed: json["sale_deed"],
        isParking: json["is_parking"],
        isParkingAvailable: json["is_parking_available"],
        parkings: json["parkings"],
        adult: json["adult"],
        child: json["child"],
        agentId: json["agent_id"],
        leaseCompanyId: json["lease_company_id"],
        unitExternalId: json["unit_external_id"],
        isMollakEnable: json["is_mollak_enable"],
        landType: json["land_type"],
        landStatus: json["land_status"],
        zoneCode: json["zone_code"],
        recoveryReminderStatus: json["recovery_reminder_status"],
        recoveryAnalysisNote: json["recovery_analysis_note"],
        status: json["status"],
        balance: json["balance"]?.toDouble(),
        pdc: json["pdc"],
        isLfpExempt: json["is_lfp_exempt"],
        mollakBuildingEnglishName: json["mollak_building_english_name"],
        mollakBuildingArabicName: json["mollak_building_arabic_name"],
        dtcmPermit: json["dtcm_permit"],
        dtcmPermitExpiry: json["dtcm_permit_expiry"],
        titleDeed: json["title_deed"],
        titleDeedNumber: json["title_deed_number"],
        vaNumber: json["va_number"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        deletedAt: json["deleted_at"],
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
        "name": name,
        "mollak_unit_name": mollakUnitName,
        "unit_size_sqft": unitSizeSqft,
        "unit_type_id": unitTypeId,
        "component_id": componentId,
        "sub_component_id": subComponentId,
        "balcony_area": balconyArea,
        "suite_area": suiteArea,
        "applicable_area": applicableArea,
        "virtual_account_number": virtualAccountNumber,
        "plot_no": plotNo,
        "parking_count": parkingCount,
        "actual_area": actualArea,
        "bedroom_count": bedroomCount,
        "bathroom_count": bathroomCount,
        "is_occupied": isOccupied,
        "date_purchased": datePurchased,
        "is_active": isActive,
        "sale_deed": saleDeed,
        "is_parking": isParking,
        "is_parking_available": isParkingAvailable,
        "parkings": parkings,
        "adult": adult,
        "child": child,
        "agent_id": agentId,
        "lease_company_id": leaseCompanyId,
        "unit_external_id": unitExternalId,
        "is_mollak_enable": isMollakEnable,
        "land_type": landType,
        "land_status": landStatus,
        "zone_code": zoneCode,
        "recovery_reminder_status": recoveryReminderStatus,
        "recovery_analysis_note": recoveryAnalysisNote,
        "status": status,
        "balance": balance,
        "pdc": pdc,
        "is_lfp_exempt": isLfpExempt,
        "mollak_building_english_name": mollakBuildingEnglishName,
        "mollak_building_arabic_name": mollakBuildingArabicName,
        "dtcm_permit": dtcmPermit,
        "dtcm_permit_expiry": dtcmPermitExpiry,
        "title_deed": titleDeed,
        "title_deed_number": titleDeedNumber,
        "va_number": vaNumber,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "deleted_at": deletedAt,
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
        "start_date":startDate==null?null:
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
