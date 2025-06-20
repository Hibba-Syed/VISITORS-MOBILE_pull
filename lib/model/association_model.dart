import 'package:visitors/model/oam_company_model.dart';
import 'package:visitors/model/visitor_info/visitors_purpose_model.dart';

import 'city_model.dart';

class Association {
  int? id;
  String? name;
  dynamic arabicName;
  int? companyId;
  String? email;
  String? phone;
  String? slug;
  int? cityId;
  int? isVisitorDirHidden;
  City? city;
  dynamic associationType;
  OamCompany? oamCompany;
  List<VisitorsPurpose>? visitorsPurposes;
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
  dynamic subdomain;
  String? contractUrl;
  dynamic gmap;
  int? paymentGatewayEnabled;
  //
  dynamic makanNo;
  dynamic mapLocation;
  dynamic securityContact;
  dynamic arabicAddress;
  String? address1;
  dynamic address2;
  dynamic postcode;
  dynamic area;
  dynamic landNumber;
  dynamic website;
  dynamic mapLocationUrl;
  int? unitCount;
  int? officeUnitsCount;
  int? shopUnitsCount;
  int? residentialUnitsCount;
  dynamic basement;
  dynamic parking;
  dynamic promade;
  int? ground;
  dynamic mezzanine;
  int? floorCount;
  dynamic rooftop;
  dynamic aboutPageImage;
  String? backgroundImage;
  dynamic logoImage;
  dynamic stateId;
  int? countryId;
  dynamic yearBuilt;
  dynamic fiscalMonthEnd;
  dynamic fiscalDayEnd;
  dynamic closingDate;
  dynamic description;
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
  DateTime? syncFrom;
  int? autoSyncOwners;
  dynamic receivableAccountId;
  dynamic uwAccountId;
  int? lnLedgerId;
  int? autoPpReceipts;
  int? autoProvisions;
  int? pricingId;
  String? subscriptionStatus;
  dynamic extendedUntil;
  String? contract;
  int? publicStatus;
  String? yearStart;
  int? isVisitorEnabled;
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
  dynamic archivedAt;
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

  Association({
    this.id,
    this.name,
    this.arabicName,
    this.companyId,
    this.email,
    this.phone,
    this.slug,
    this.cityId,
    this.isVisitorDirHidden,
    this.city,
    this.associationType,
    this.oamCompany,
    this.visitorsPurposes,
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
  });

  factory Association.fromJson(Map<String, dynamic> json) => Association(
    id: json["id"],
    name: json["name"],
    arabicName: json["arabic_name"],
    companyId: json["company_id"],
    email: json["email"],
    phone: json["phone"],
    slug: json["slug"],
    cityId: json["city_id"],
    isVisitorDirHidden: json["is_visitor_dir_hidden"],
    city: json["city"] == null ? null : City.fromJson(json["city"]),
    associationType: json["association_type"],
    oamCompany: json["oam_company"] == null ? null : OamCompany.fromJson(json["oam_company"]),
    visitorsPurposes: json["visitors_purposes"] == null ? [] : List<VisitorsPurpose>.from(json["visitors_purposes"]!.map((x) => VisitorsPurpose.fromJson(x))),
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
    // syncFrom: json["sync_from"] == null ? null : DateTime.parse(json["sync_from"]),
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
    archivedAt: json["archived_at"],
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

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "arabic_name": arabicName,
    "company_id": companyId,
    "email": email,
    "phone": phone,
    "slug": slug,
    "city_id": cityId,
    "is_visitor_dir_hidden": isVisitorDirHidden,
    "city": city?.toJson(),
    "association_type": associationType,
    "oam_company": oamCompany?.toJson(),
    "visitors_purposes": visitorsPurposes == null ? [] : List<dynamic>.from(visitorsPurposes!.map((x) => x.toJson())),
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
    "association_type_id": associationType,
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
   // "sync_from": syncFrom?.toIso8601String(),
    //"${syncFrom?.year.toString().padLeft(4, '0')}-${syncFrom?.month.toString().padLeft(2, '0')}-${syncFrom?.day.toString().padLeft(2, '0')}",
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
    "archived_at": archivedAt,
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

  };
}