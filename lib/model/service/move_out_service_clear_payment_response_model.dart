// To parse this JSON data, do
//
//     final moveOutServiceClearPaymentResponseModel = moveOutServiceClearPaymentResponseModelFromJson(jsonString);

import 'dart:convert';

MoveOutServiceClearPaymentResponseModel moveOutServiceClearPaymentResponseModelFromJson(String str) => MoveOutServiceClearPaymentResponseModel.fromJson(json.decode(str));

String moveOutServiceClearPaymentResponseModelToJson(MoveOutServiceClearPaymentResponseModel data) => json.encode(data.toJson());

class MoveOutServiceClearPaymentResponseModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  MoveOutServiceClearPaymentResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory MoveOutServiceClearPaymentResponseModel.fromJson(Map<String, dynamic> json) => MoveOutServiceClearPaymentResponseModel(
    status: json["status"],
    record: json["record"] == null ? null : Record.fromJson(json["record"]),
    code: json["code"],
    meta: json["meta"],
    requestStatus: json["request_status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "record": record?.toJson(),
    "code": code,
    "meta": meta,
    "request_status": requestStatus,
    "message": message,
  };
}

class Record {
  int? id;
  String? reference;
  int? companyId;
  int? associationId;
  int? unitId;
  int? accountId;
  String? incomeType;
  int? isCommunityDetailHidden;
  int? assigneeId;
  String? applicationType;
  int? applicationId;
  dynamic parentId;
  String? clientName;
  String? clientEmail;
  String? clientPhone;
  String? firstName;
  dynamic lastName;
  String? email;
  dynamic profilePicture;
  dynamic clientIdType;
  String? clientIdNumber;
  dynamic clientIdFile;
  dynamic clientIdExpiry;
  String? passportFile;
  dynamic passportExpiry;
  String? passportNumber;
  dynamic clientCountryId;
  String? clientType;
  dynamic description;
  dynamic deletedAt;
  String? status;
  dynamic securityNumber;
  int? allSecurityPersonnel;
  int? payableAmount;
  dynamic securityDeposit;
  String? paymentStatus;
  dynamic paymentRef;
  int? documentsStatus;
  int? securityDepositRefundStatus;
  int? termsConditions;
  String? tradeLicense;
  dynamic contractNumber;
  dynamic tradeLicenseExpiry;
  dynamic titleDeed;
  String? titleDeedNumber;
  dynamic tenancyContract;
  dynamic tenancyContractExpiry;
  dynamic notifyStatus;
  dynamic serviceChargeStatus;
  dynamic convenienceFee;
  dynamic convenienceFeeAccount;
  String? approvalNote;
  dynamic rejectionNote;
  dynamic holdNote;
  dynamic cancelNote;
  dynamic completionNote;
  dynamic requestNote;
  dynamic processNote;
  dynamic documentNote;
  dynamic securityNote;
  dynamic nocNote;
  dynamic refundNote;
  String? paymentNote;
  dynamic terms;
  dynamic rating;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? clientIdFileUrl;
  String? passportFileUrl;
  String? titleDeedUrl;
  String? tenancyContractUrl;
  String? tradeLicenseUrl;
  bool? isMailable;
  String? fullName;
  String? profileImageUrl;
  Application? application;
  Association? association;
  Unit? unit;
  Assignee? assignee;

  Record({
    this.id,
    this.reference,
    this.companyId,
    this.associationId,
    this.unitId,
    this.accountId,
    this.incomeType,
    this.isCommunityDetailHidden,
    this.assigneeId,
    this.applicationType,
    this.applicationId,
    this.parentId,
    this.clientName,
    this.clientEmail,
    this.clientPhone,
    this.firstName,
    this.lastName,
    this.email,
    this.profilePicture,
    this.clientIdType,
    this.clientIdNumber,
    this.clientIdFile,
    this.clientIdExpiry,
    this.passportFile,
    this.passportExpiry,
    this.passportNumber,
    this.clientCountryId,
    this.clientType,
    this.description,
    this.deletedAt,
    this.status,
    this.securityNumber,
    this.allSecurityPersonnel,
    this.payableAmount,
    this.securityDeposit,
    this.paymentStatus,
    this.paymentRef,
    this.documentsStatus,
    this.securityDepositRefundStatus,
    this.termsConditions,
    this.tradeLicense,
    this.contractNumber,
    this.tradeLicenseExpiry,
    this.titleDeed,
    this.titleDeedNumber,
    this.tenancyContract,
    this.tenancyContractExpiry,
    this.notifyStatus,
    this.serviceChargeStatus,
    this.convenienceFee,
    this.convenienceFeeAccount,
    this.approvalNote,
    this.rejectionNote,
    this.holdNote,
    this.cancelNote,
    this.completionNote,
    this.requestNote,
    this.processNote,
    this.documentNote,
    this.securityNote,
    this.nocNote,
    this.refundNote,
    this.paymentNote,
    this.terms,
    this.rating,
    this.createdAt,
    this.updatedAt,
    this.clientIdFileUrl,
    this.passportFileUrl,
    this.titleDeedUrl,
    this.tenancyContractUrl,
    this.tradeLicenseUrl,
    this.isMailable,
    this.fullName,
    this.profileImageUrl,
    this.application,
    this.association,
    this.unit,
    this.assignee,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
    reference: json["reference"],
    companyId: json["company_id"],
    associationId: json["association_id"],
    unitId: json["unit_id"],
    accountId: json["account_id"],
    incomeType: json["income_type"],
    isCommunityDetailHidden: json["is_community_detail_hidden"],
    assigneeId: json["assignee_id"],
    applicationType: json["application_type"],
    applicationId: json["application_id"],
    parentId: json["parent_id"],
    clientName: json["client_name"],
    clientEmail: json["client_email"],
    clientPhone: json["client_phone"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    profilePicture: json["profile_picture"],
    clientIdType: json["client_id_type"],
    clientIdNumber: json["client_id_number"],
    clientIdFile: json["client_id_file"],
    clientIdExpiry: json["client_id_expiry"],
    passportFile: json["passport_file"],
    passportExpiry: json["passport_expiry"],
    passportNumber: json["passport_number"],
    clientCountryId: json["client_country_id"],
    clientType: json["client_type"],
    description: json["description"],
    deletedAt: json["deleted_at"],
    status: json["status"],
    securityNumber: json["security_number"],
    allSecurityPersonnel: json["all_security_personnel"],
    payableAmount: json["payable_amount"],
    securityDeposit: json["security_deposit"],
    paymentStatus: json["payment_status"],
    paymentRef: json["payment_ref"],
    documentsStatus: json["documents_status"],
    securityDepositRefundStatus: json["security_deposit_refund_status"],
    termsConditions: json["terms_conditions"],
    tradeLicense: json["trade_license"],
    contractNumber: json["contract_number"],
    tradeLicenseExpiry: json["trade_license_expiry"],
    titleDeed: json["title_deed"],
    titleDeedNumber: json["title_deed_number"],
    tenancyContract: json["tenancy_contract"],
    tenancyContractExpiry: json["tenancy_contract_expiry"],
    notifyStatus: json["notify_status"],
    serviceChargeStatus: json["service_charge_status"],
    convenienceFee: json["convenience_fee"],
    convenienceFeeAccount: json["convenience_fee_account"],
    approvalNote: json["approval_note"],
    rejectionNote: json["rejection_note"],
    holdNote: json["hold_note"],
    cancelNote: json["cancel_note"],
    completionNote: json["completion_note"],
    requestNote: json["request_note"],
    processNote: json["process_note"],
    documentNote: json["document_note"],
    securityNote: json["security_note"],
    nocNote: json["noc_note"],
    refundNote: json["refund_note"],
    paymentNote: json["payment_note"],
    terms: json["terms"],
    rating: json["rating"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    clientIdFileUrl: json["client_id_file_url"],
    passportFileUrl: json["passport_file_url"],
    titleDeedUrl: json["title_deed_url"],
    tenancyContractUrl: json["tenancy_contract_url"],
    tradeLicenseUrl: json["trade_license_url"],
    isMailable: json["is_mailable"],
    fullName: json["full_name"],
    profileImageUrl: json["profile_image_url"],
    application: json["application"] == null ? null : Application.fromJson(json["application"]),
    association: json["association"] == null ? null : Association.fromJson(json["association"]),
    unit: json["unit"] == null ? null : Unit.fromJson(json["unit"]),
    assignee: json["assignee"] == null ? null : Assignee.fromJson(json["assignee"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "reference": reference,
    "company_id": companyId,
    "association_id": associationId,
    "unit_id": unitId,
    "account_id": accountId,
    "income_type": incomeType,
    "is_community_detail_hidden": isCommunityDetailHidden,
    "assignee_id": assigneeId,
    "application_type": applicationType,
    "application_id": applicationId,
    "parent_id": parentId,
    "client_name": clientName,
    "client_email": clientEmail,
    "client_phone": clientPhone,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "profile_picture": profilePicture,
    "client_id_type": clientIdType,
    "client_id_number": clientIdNumber,
    "client_id_file": clientIdFile,
    "client_id_expiry": clientIdExpiry,
    "passport_file": passportFile,
    "passport_expiry": passportExpiry,
    "passport_number": passportNumber,
    "client_country_id": clientCountryId,
    "client_type": clientType,
    "description": description,
    "deleted_at": deletedAt,
    "status": status,
    "security_number": securityNumber,
    "all_security_personnel": allSecurityPersonnel,
    "payable_amount": payableAmount,
    "security_deposit": securityDeposit,
    "payment_status": paymentStatus,
    "payment_ref": paymentRef,
    "documents_status": documentsStatus,
    "security_deposit_refund_status": securityDepositRefundStatus,
    "terms_conditions": termsConditions,
    "trade_license": tradeLicense,
    "contract_number": contractNumber,
    "trade_license_expiry": tradeLicenseExpiry,
    "title_deed": titleDeed,
    "title_deed_number": titleDeedNumber,
    "tenancy_contract": tenancyContract,
    "tenancy_contract_expiry": tenancyContractExpiry,
    "notify_status": notifyStatus,
    "service_charge_status": serviceChargeStatus,
    "convenience_fee": convenienceFee,
    "convenience_fee_account": convenienceFeeAccount,
    "approval_note": approvalNote,
    "rejection_note": rejectionNote,
    "hold_note": holdNote,
    "cancel_note": cancelNote,
    "completion_note": completionNote,
    "request_note": requestNote,
    "process_note": processNote,
    "document_note": documentNote,
    "security_note": securityNote,
    "noc_note": nocNote,
    "refund_note": refundNote,
    "payment_note": paymentNote,
    "terms": terms,
    "rating": rating,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "client_id_file_url": clientIdFileUrl,
    "passport_file_url": passportFileUrl,
    "title_deed_url": titleDeedUrl,
    "tenancy_contract_url": tenancyContractUrl,
    "trade_license_url": tradeLicenseUrl,
    "is_mailable": isMailable,
    "full_name": fullName,
    "profile_image_url": profileImageUrl,
    "application": application?.toJson(),
    "association": association?.toJson(),
    "unit": unit?.toJson(),
    "assignee": assignee?.toJson(),
  };
}

class Application {
  int? id;
  String? requestType;
  dynamic emergencyNumber;
  DateTime? moveDate;
  String? moveTimeFrom;
  String? moveTimeTo;
  dynamic repairCost;
  dynamic refundAmount;
  dynamic securityDeposit;
  dynamic nationality;
  dynamic handoverMoveout;
  dynamic noteForSecurity;
  dynamic assetCondition;
  dynamic postEventReport;
  dynamic postEventReportBy;
  dynamic applicantDamageNote;
  dynamic completeChecklist;
  dynamic dubaiSiliconOasisPermit;
  dynamic serviceChargeStatus;
  dynamic residentRequestId;
  dynamic mcEmiratesId;
  dynamic mcContactPerson;
  dynamic mcTradeLicense;
  dynamic mcCompanyName;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? mcEmiratesPathUrl;
  String? mcTradeLicensePathUrl;

  Application({
    this.id,
    this.requestType,
    this.emergencyNumber,
    this.moveDate,
    this.moveTimeFrom,
    this.moveTimeTo,
    this.repairCost,
    this.refundAmount,
    this.securityDeposit,
    this.nationality,
    this.handoverMoveout,
    this.noteForSecurity,
    this.assetCondition,
    this.postEventReport,
    this.postEventReportBy,
    this.applicantDamageNote,
    this.completeChecklist,
    this.dubaiSiliconOasisPermit,
    this.serviceChargeStatus,
    this.residentRequestId,
    this.mcEmiratesId,
    this.mcContactPerson,
    this.mcTradeLicense,
    this.mcCompanyName,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.mcEmiratesPathUrl,
    this.mcTradeLicensePathUrl,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
    id: json["id"],
    requestType: json["request_type"],
    emergencyNumber: json["emergency_number"],
    moveDate: json["move_date"] == null ? null : DateTime.parse(json["move_date"]),
    moveTimeFrom: json["move_time_from"],
    moveTimeTo: json["move_time_to"],
    repairCost: json["repair_cost"],
    refundAmount: json["refund_amount"],
    securityDeposit: json["security_deposit"],
    nationality: json["nationality"],
    handoverMoveout: json["handover_moveout"],
    noteForSecurity: json["note_for_security"],
    assetCondition: json["asset_condition"],
    postEventReport: json["post_event_report"],
    postEventReportBy: json["post_event_report_by"],
    applicantDamageNote: json["applicant_damage_note"],
    completeChecklist: json["complete_checklist"],
    dubaiSiliconOasisPermit: json["dubai_silicon_oasis_permit"],
    serviceChargeStatus: json["service_charge_status"],
    residentRequestId: json["resident_request_id"],
    mcEmiratesId: json["mc_emirates_id"],
    mcContactPerson: json["mc_contact_person"],
    mcTradeLicense: json["mc_trade_license"],
    mcCompanyName: json["mc_company_name"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    mcEmiratesPathUrl: json["mc_emirates_path_url"],
    mcTradeLicensePathUrl: json["mc_trade_license_path_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "request_type": requestType,
    "emergency_number": emergencyNumber,
    "move_date": "${moveDate!.year.toString().padLeft(4, '0')}-${moveDate!.month.toString().padLeft(2, '0')}-${moveDate!.day.toString().padLeft(2, '0')}",
    "move_time_from": moveTimeFrom,
    "move_time_to": moveTimeTo,
    "repair_cost": repairCost,
    "refund_amount": refundAmount,
    "security_deposit": securityDeposit,
    "nationality": nationality,
    "handover_moveout": handoverMoveout,
    "note_for_security": noteForSecurity,
    "asset_condition": assetCondition,
    "post_event_report": postEventReport,
    "post_event_report_by": postEventReportBy,
    "applicant_damage_note": applicantDamageNote,
    "complete_checklist": completeChecklist,
    "dubai_silicon_oasis_permit": dubaiSiliconOasisPermit,
    "service_charge_status": serviceChargeStatus,
    "resident_request_id": residentRequestId,
    "mc_emirates_id": mcEmiratesId,
    "mc_contact_person": mcContactPerson,
    "mc_trade_license": mcTradeLicense,
    "mc_company_name": mcCompanyName,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "mc_emirates_path_url": mcEmiratesPathUrl,
    "mc_trade_license_path_url": mcTradeLicensePathUrl,
  };
}

class Assignee {
  int? id;
  String? reference;
  int? is2FaEnabled;
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
  dynamic passwordUpdatedAt;
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
    this.is2FaEnabled,
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
    is2FaEnabled: json["is_2fa_enabled"],
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
    passwordUpdatedAt: json["password_updated_at"],
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
    "is_2fa_enabled": is2FaEnabled,
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
    "password_updated_at": passwordUpdatedAt,
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

class Association {
  int? id;
  String? name;
  dynamic arabicName;
  int? associationTypeId;
  int? companyId;
  String? email;
  String? phone;
  String? slug;
  dynamic makanNo;
  dynamic mapLocation;
  dynamic securityContact;
  dynamic arabicAddress;
  String? address1;
  dynamic address2;
  dynamic postcode;
  String? area;
  String? landNumber;
  dynamic website;
  dynamic mapLocationUrl;
  int? unitCount;
  int? officeUnitsCount;
  int? shopUnitsCount;
  int? residentialUnitsCount;
  int? basement;
  dynamic parking;
  int? promade;
  int? ground;
  dynamic mezzanine;
  int? floorCount;
  dynamic rooftop;
  String? aboutPageImage;
  String? backgroundImage;
  dynamic logoImage;
  int? cityId;
  dynamic stateId;
  int? countryId;
  String? yearBuilt;
  dynamic fiscalMonthEnd;
  dynamic fiscalDayEnd;
  dynamic closingDate;
  String? description;
  dynamic reserveFundStudy;
  dynamic reserveFundStudyNotification;
  dynamic propertyReservationPrice;
  int? status;
  String? latitude;
  String? longitude;
  dynamic managerId;
  int? complaintAssigneeId;
  int? isComplaintsEnabled;
  int? isInquiryEnabled;
  int? isUrlEnabled;
  int? managedByTag;
  String? associationExternalId;
  String? trnNumber;
  int? isTrn;
  dynamic taxGraceDays;
  int? isMollakEnable;
  bool? isMaster;
  dynamic masterCommunityEngName;
  dynamic masterCommunityArabicName;
  dynamic projectName;
  dynamic merchantCode;
  dynamic syncFrom;
  int? autoSyncOwners;
  int? receivableAccountId;
  int? uwAccountId;
  int? lnLedgerId;
  int? autoPpReceipts;
  int? autoProvisions;
  int? pricingId;
  String? subscriptionStatus;
  dynamic extendedUntil;
  dynamic contract;
  int? publicStatus;
  String? yearStart;
  int? isVisitorEnabled;
  int? isVisitorDirHidden;
  int? isVisitorPassEnabled;
  int? visitorAssigneeId;
  int? isCallCenterEnabled;
  int? isAutoLnEnabled;
  String? vpStatus;
  dynamic receiptDisclaimer;
  dynamic invoiceDisclaimer;
  int? isBalanceDue;
  int? otpStatus;
  int? isArchived;
  DateTime? archivedAt;
  String? communityId;
  dynamic areaId;
  dynamic developerId;
  int? isBillAuditApproval;
  int? isResidentAppEnabled;
  dynamic residentAppKey;
  dynamic residentAppHeader;
  int? autoUpdateResident;
  int? allOwnersReminders;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  int? remainingUnit;
  String? aboutPageImageUrl;
  String? backgroundImageUrl;
  String? logoImageUrl;
  String? fullAddress;
  double? unitsArea;
  int? applicableArea;
  int? suiteArea;
  int? balconyArea;
  String? filledParkings;
  String? subdomain;
  String? contractUrl;
  String? gmap;
  int? paymentGatewayEnabled;
  City? city;
  AssociationType? associationType;

  Association({
    this.id,
    this.name,
    this.arabicName,
    this.associationTypeId,
    this.companyId,
    this.email,
    this.phone,
    this.slug,
    this.makanNo,
    this.mapLocation,
    this.securityContact,
    this.arabicAddress,
    this.address1,
    this.address2,
    this.postcode,
    this.area,
    this.landNumber,
    this.website,
    this.mapLocationUrl,
    this.unitCount,
    this.officeUnitsCount,
    this.shopUnitsCount,
    this.residentialUnitsCount,
    this.basement,
    this.parking,
    this.promade,
    this.ground,
    this.mezzanine,
    this.floorCount,
    this.rooftop,
    this.aboutPageImage,
    this.backgroundImage,
    this.logoImage,
    this.cityId,
    this.stateId,
    this.countryId,
    this.yearBuilt,
    this.fiscalMonthEnd,
    this.fiscalDayEnd,
    this.closingDate,
    this.description,
    this.reserveFundStudy,
    this.reserveFundStudyNotification,
    this.propertyReservationPrice,
    this.status,
    this.latitude,
    this.longitude,
    this.managerId,
    this.complaintAssigneeId,
    this.isComplaintsEnabled,
    this.isInquiryEnabled,
    this.isUrlEnabled,
    this.managedByTag,
    this.associationExternalId,
    this.trnNumber,
    this.isTrn,
    this.taxGraceDays,
    this.isMollakEnable,
    this.isMaster,
    this.masterCommunityEngName,
    this.masterCommunityArabicName,
    this.projectName,
    this.merchantCode,
    this.syncFrom,
    this.autoSyncOwners,
    this.receivableAccountId,
    this.uwAccountId,
    this.lnLedgerId,
    this.autoPpReceipts,
    this.autoProvisions,
    this.pricingId,
    this.subscriptionStatus,
    this.extendedUntil,
    this.contract,
    this.publicStatus,
    this.yearStart,
    this.isVisitorEnabled,
    this.isVisitorDirHidden,
    this.isVisitorPassEnabled,
    this.visitorAssigneeId,
    this.isCallCenterEnabled,
    this.isAutoLnEnabled,
    this.vpStatus,
    this.receiptDisclaimer,
    this.invoiceDisclaimer,
    this.isBalanceDue,
    this.otpStatus,
    this.isArchived,
    this.archivedAt,
    this.communityId,
    this.areaId,
    this.developerId,
    this.isBillAuditApproval,
    this.isResidentAppEnabled,
    this.residentAppKey,
    this.residentAppHeader,
    this.autoUpdateResident,
    this.allOwnersReminders,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.remainingUnit,
    this.aboutPageImageUrl,
    this.backgroundImageUrl,
    this.logoImageUrl,
    this.fullAddress,
    this.unitsArea,
    this.applicableArea,
    this.suiteArea,
    this.balconyArea,
    this.filledParkings,
    this.subdomain,
    this.contractUrl,
    this.gmap,
    this.paymentGatewayEnabled,
    this.city,
    this.associationType,
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
    id: json["id"],
    name: json["name"],
    arabicName: json["arabic_name"],
    associationTypeId: json["association_type_id"],
    companyId: json["company_id"],
    email: json["email"],
    phone: json["phone"],
    slug: json["slug"],
    makanNo: json["makan_no"],
    mapLocation: json["map_location"],
    securityContact: json["security_contact"],
    arabicAddress: json["arabic_address"],
    address1: json["address1"],
    address2: json["address2"],
    postcode: json["postcode"],
    area: json["area"],
    landNumber: json["land_number"],
    website: json["website"],
    mapLocationUrl: json["map_location_url"],
    unitCount: json["unit_count"],
    officeUnitsCount: json["office_units_count"],
    shopUnitsCount: json["shop_units_count"],
    residentialUnitsCount: json["residential_units_count"],
    basement: json["basement"],
    parking: json["parking"],
    promade: json["promade"],
    ground: json["ground"],
    mezzanine: json["mezzanine"],
    floorCount: json["floor_count"],
    rooftop: json["rooftop"],
    aboutPageImage: json["about_page_image"],
    backgroundImage: json["background_image"],
    logoImage: json["logo_image"],
    cityId: json["city_id"],
    stateId: json["state_id"],
    countryId: json["country_id"],
    yearBuilt: json["year_built"],
    fiscalMonthEnd: json["fiscal_month_end"],
    fiscalDayEnd: json["fiscal_day_end"],
    closingDate: json["closing_date"],
    description: json["description"],
    reserveFundStudy: json["reserve_fund_study"],
    reserveFundStudyNotification: json["reserve_fund_study_notification"],
    propertyReservationPrice: json["property_reservation_price"],
    status: json["status"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    managerId: json["manager_id"],
    complaintAssigneeId: json["complaint_assignee_id"],
    isComplaintsEnabled: json["is_complaints_enabled"],
    isInquiryEnabled: json["is_inquiry_enabled"],
    isUrlEnabled: json["is_url_enabled"],
    managedByTag: json["managed_by_tag"],
    associationExternalId: json["association_external_id"],
    trnNumber: json["trn_number"],
    isTrn: json["is_trn"],
    taxGraceDays: json["tax_grace_days"],
    isMollakEnable: json["is_mollak_enable"],
    isMaster: json["is_master"],
    masterCommunityEngName: json["master_community_eng_name"],
    masterCommunityArabicName: json["master_community_arabic_name"],
    projectName: json["project_name"],
    merchantCode: json["merchant_code"],
    syncFrom: json["sync_from"],
    autoSyncOwners: json["auto_sync_owners"],
    receivableAccountId: json["receivable_account_id"],
    uwAccountId: json["uw_account_id"],
    lnLedgerId: json["ln_ledger_id"],
    autoPpReceipts: json["auto_pp_receipts"],
    autoProvisions: json["auto_provisions"],
    pricingId: json["pricing_id"],
    subscriptionStatus: json["subscription_status"],
    extendedUntil: json["extended_until"],
    contract: json["contract"],
    publicStatus: json["public_status"],
    yearStart: json["year_start"],
    isVisitorEnabled: json["is_visitor_enabled"],
    isVisitorDirHidden: json["is_visitor_dir_hidden"],
    isVisitorPassEnabled: json["is_visitor_pass_enabled"],
    visitorAssigneeId: json["visitor_assignee_id"],
    isCallCenterEnabled: json["is_call_center_enabled"],
    isAutoLnEnabled: json["is_auto_ln_enabled"],
    vpStatus: json["vp_status"],
    receiptDisclaimer: json["receipt_disclaimer"],
    invoiceDisclaimer: json["invoice_disclaimer"],
    isBalanceDue: json["is_balance_due"],
    otpStatus: json["otp_status"],
    isArchived: json["is_archived"],
    archivedAt: json["archived_at"] == null ? null : DateTime.parse(json["archived_at"]),
    communityId: json["community_id"],
    areaId: json["area_id"],
    developerId: json["developer_id"],
    isBillAuditApproval: json["is_bill_audit_approval"],
    isResidentAppEnabled: json["is_resident_app_enabled"],
    residentAppKey: json["resident_app_key"],
    residentAppHeader: json["resident_app_header"],
    autoUpdateResident: json["auto_update_resident"],
    allOwnersReminders: json["all_owners_reminders"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    remainingUnit: json["remaining_unit"],
    aboutPageImageUrl: json["about_page_image_url"],
    backgroundImageUrl: json["background_image_url"],
    logoImageUrl: json["logo_image_url"],
    fullAddress: json["full_address"],
    unitsArea: json["units_area"]?.toDouble(),
    applicableArea: json["applicable_area"],
    suiteArea: json["suite_area"],
    balconyArea: json["balcony_area"],
    filledParkings: json["filled_parkings"],
    subdomain: json["subdomain"],
    contractUrl: json["contract_url"],
    gmap: json["gmap"],
    paymentGatewayEnabled: json["payment_gateway_enabled"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    associationType: json["association_type"] == null ? null : AssociationType.fromJson(json["association_type"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "arabic_name": arabicName,
    "association_type_id": associationTypeId,
    "company_id": companyId,
    "email": email,
    "phone": phone,
    "slug": slug,
    "makan_no": makanNo,
    "map_location": mapLocation,
    "security_contact": securityContact,
    "arabic_address": arabicAddress,
    "address1": address1,
    "address2": address2,
    "postcode": postcode,
    "area": area,
    "land_number": landNumber,
    "website": website,
    "map_location_url": mapLocationUrl,
    "unit_count": unitCount,
    "office_units_count": officeUnitsCount,
    "shop_units_count": shopUnitsCount,
    "residential_units_count": residentialUnitsCount,
    "basement": basement,
    "parking": parking,
    "promade": promade,
    "ground": ground,
    "mezzanine": mezzanine,
    "floor_count": floorCount,
    "rooftop": rooftop,
    "about_page_image": aboutPageImage,
    "background_image": backgroundImage,
    "logo_image": logoImage,
    "city_id": cityId,
    "state_id": stateId,
    "country_id": countryId,
    "year_built": yearBuilt,
    "fiscal_month_end": fiscalMonthEnd,
    "fiscal_day_end": fiscalDayEnd,
    "closing_date": closingDate,
    "description": description,
    "reserve_fund_study": reserveFundStudy,
    "reserve_fund_study_notification": reserveFundStudyNotification,
    "property_reservation_price": propertyReservationPrice,
    "status": status,
    "latitude": latitude,
    "longitude": longitude,
    "manager_id": managerId,
    "complaint_assignee_id": complaintAssigneeId,
    "is_complaints_enabled": isComplaintsEnabled,
    "is_inquiry_enabled": isInquiryEnabled,
    "is_url_enabled": isUrlEnabled,
    "managed_by_tag": managedByTag,
    "association_external_id": associationExternalId,
    "trn_number": trnNumber,
    "is_trn": isTrn,
    "tax_grace_days": taxGraceDays,
    "is_mollak_enable": isMollakEnable,
    "is_master": isMaster,
    "master_community_eng_name": masterCommunityEngName,
    "master_community_arabic_name": masterCommunityArabicName,
    "project_name": projectName,
    "merchant_code": merchantCode,
    "sync_from": syncFrom,
    "auto_sync_owners": autoSyncOwners,
    "receivable_account_id": receivableAccountId,
    "uw_account_id": uwAccountId,
    "ln_ledger_id": lnLedgerId,
    "auto_pp_receipts": autoPpReceipts,
    "auto_provisions": autoProvisions,
    "pricing_id": pricingId,
    "subscription_status": subscriptionStatus,
    "extended_until": extendedUntil,
    "contract": contract,
    "public_status": publicStatus,
    "year_start": yearStart,
    "is_visitor_enabled": isVisitorEnabled,
    "is_visitor_dir_hidden": isVisitorDirHidden,
    "is_visitor_pass_enabled": isVisitorPassEnabled,
    "visitor_assignee_id": visitorAssigneeId,
    "is_call_center_enabled": isCallCenterEnabled,
    "is_auto_ln_enabled": isAutoLnEnabled,
    "vp_status": vpStatus,
    "receipt_disclaimer": receiptDisclaimer,
    "invoice_disclaimer": invoiceDisclaimer,
    "is_balance_due": isBalanceDue,
    "otp_status": otpStatus,
    "is_archived": isArchived,
    "archived_at": "${archivedAt!.year.toString().padLeft(4, '0')}-${archivedAt!.month.toString().padLeft(2, '0')}-${archivedAt!.day.toString().padLeft(2, '0')}",
    "community_id": communityId,
    "area_id": areaId,
    "developer_id": developerId,
    "is_bill_audit_approval": isBillAuditApproval,
    "is_resident_app_enabled": isResidentAppEnabled,
    "resident_app_key": residentAppKey,
    "resident_app_header": residentAppHeader,
    "auto_update_resident": autoUpdateResident,
    "all_owners_reminders": allOwnersReminders,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "remaining_unit": remainingUnit,
    "about_page_image_url": aboutPageImageUrl,
    "background_image_url": backgroundImageUrl,
    "logo_image_url": logoImageUrl,
    "full_address": fullAddress,
    "units_area": unitsArea,
    "applicable_area": applicableArea,
    "suite_area": suiteArea,
    "balcony_area": balconyArea,
    "filled_parkings": filledParkings,
    "subdomain": subdomain,
    "contract_url": contractUrl,
    "gmap": gmap,
    "payment_gateway_enabled": paymentGatewayEnabled,
    "city": city?.toJson(),
    "association_type": associationType?.toJson(),
  };
}

class AssociationType {
  int? id;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;

  AssociationType({
    this.id,
    this.type,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory AssociationType.fromJson(Map<String, dynamic> json) => AssociationType(
    id: json["id"],
    type: json["type"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class City {
  int? id;
  String? name;
  int? stateId;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? label;
  String? value;

  City({
    this.id,
    this.name,
    this.stateId,
    this.createdAt,
    this.updatedAt,
    this.label,
    this.value,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    stateId: json["state_id"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    label: json["label"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "state_id": stateId,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "label": label,
    "value": value,
  };
}

class Unit {
  int? id;
  int? associationId;
  String? unitNumber;
  String? name;
  dynamic mollakUnitName;
  double? unitSizeSqft;
  int? unitTypeId;
  int? componentId;
  dynamic subComponentId;
  dynamic balconyArea;
  dynamic suiteArea;
  dynamic applicableArea;
  dynamic virtualAccountNumber;
  dynamic plotNo;
  int? parkingCount;
  int? actualArea;
  dynamic bedroomCount;
  dynamic bathroomCount;
  int? isOccupied;
  dynamic datePurchased;
  int? isActive;
  dynamic saleDeed;
  int? isParking;
  int? isParkingAvailable;
  int? parkings;
  String? adult;
  String? child;
  int? residentId;
  dynamic agentId;
  dynamic leaseCompanyId;
  String? unitExternalId;
  int? isMollakEnable;
  dynamic landType;
  dynamic landStatus;
  dynamic zoneCode;
  int? recoveryReminderStatus;
  dynamic recoveryAnalysisNote;
  String? status;
  int? balance;
  int? pdc;
  int? isLfpExempt;
  dynamic mollakBuildingEnglishName;
  dynamic mollakBuildingArabicName;
  String? dtcmPermit;
  dynamic dtcmPermitExpiry;
  String? titleDeed;
  String? titleDeedNumber;
  dynamic vaNumber;
  DateTime? updatedAt;
  DateTime? createdAt;
  dynamic deletedAt;
  bool? isLegalNoticeActive;
  bool? isRdcActive;
  String? titleDeedUrl;

  Unit({
    this.id,
    this.associationId,
    this.unitNumber,
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
    this.residentId,
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
    this.isLegalNoticeActive,
    this.isRdcActive,
    this.titleDeedUrl,
  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    associationId: json["association_id"],
    unitNumber: json["unit_number"],
    name: json["name"],
    mollakUnitName: json["mollak_unit_name"],
    unitSizeSqft: json["unit_size_sqft"]?.toDouble(),
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
    residentId: json["resident_id"],
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
    balance: json["balance"],
    pdc: json["pdc"],
    isLfpExempt: json["is_lfp_exempt"],
    mollakBuildingEnglishName: json["mollak_building_english_name"],
    mollakBuildingArabicName: json["mollak_building_arabic_name"],
    dtcmPermit: json["dtcm_permit"],
    dtcmPermitExpiry: json["dtcm_permit_expiry"],
    titleDeed: json["title_deed"],
    titleDeedNumber: json["title_deed_number"],
    vaNumber: json["va_number"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    deletedAt: json["deleted_at"],
    isLegalNoticeActive: json["is_legal_notice_active"],
    isRdcActive: json["is_rdc_active"],
    titleDeedUrl: json["title_deed_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "association_id": associationId,
    "unit_number": unitNumber,
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
    "resident_id": residentId,
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
    "is_legal_notice_active": isLegalNoticeActive,
    "is_rdc_active": isRdcActive,
    "title_deed_url": titleDeedUrl,
  };
}
