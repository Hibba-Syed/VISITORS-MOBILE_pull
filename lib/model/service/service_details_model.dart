import 'package:visitors/model/service/status_history_model.dart';

import 'application_model.dart';
import '../unit/unit_model.dart';
import 'document_model.dart';

class ServiceDetailsModel {
  int? id;
  String? reference;
  int? companyId;
  int? associationId;
  int? unitId;
  int? accountId;
  dynamic incomeType;
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
  String? clientIdType;
  String? clientIdNumber;
  String? clientIdFile;
  DateTime? clientIdExpiry;
  String? passportFile;
  DateTime? passportExpiry;
  String? passportNumber;
  dynamic clientCountryId;
  String? clientType;
  String? description;
  dynamic deletedAt;
  String? status;
  dynamic securityNumber;
  int? allSecurityPersonnel;
  double? payableAmount;
  int? securityDeposit;
  String? paymentStatus;
  dynamic paymentRef;
  int? documentsStatus;
  int? securityDepositRefundStatus;
  int? termsConditions;
  String? tradeLicense;
  dynamic contractNumber;
  dynamic tradeLicenseExpiry;
  String? titleDeed;
  String? titleDeedNumber;
  String? tenancyContract;
  DateTime? tenancyContractExpiry;
  dynamic notifyStatus;
  int? serviceChargeStatus;
  dynamic convenienceFee;
  dynamic convenienceFeeAccount;
  dynamic approvalNote;
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
  dynamic paymentNote;
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
  List<StatusHistory>? statusHistory;
  UnitModel? unit;
  List<Document>? documents;

  ServiceDetailsModel({
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
    this.statusHistory,
    this.unit,
    this.documents,
  });

  factory ServiceDetailsModel.fromJson(Map<String, dynamic> json) => ServiceDetailsModel(
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
    clientIdExpiry: json["client_id_expiry"] == null ? null : DateTime.parse(json["client_id_expiry"]),
    passportFile: json["passport_file"],
    passportExpiry: json["passport_expiry"] == null ? null : DateTime.parse(json["passport_expiry"]),
    passportNumber: json["passport_number"],
    clientCountryId: json["client_country_id"],
    clientType: json["client_type"],
    description: json["description"],
    deletedAt: json["deleted_at"],
    status: json["status"],
    securityNumber: json["security_number"],
    allSecurityPersonnel: json["all_security_personnel"],
    payableAmount: double.tryParse(json["payable_amount"]?.toString()??''),
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
    tenancyContractExpiry: json["tenancy_contract_expiry"] == null ? null : DateTime.parse(json["tenancy_contract_expiry"]),
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
    statusHistory: json["status_history"] == null ? [] : List<StatusHistory>.from(json["status_history"]!.map((x) => StatusHistory.fromJson(x))),
    unit: json["unit"] == null ? null : UnitModel.fromJson(json["unit"]),
    documents: json["documents"] == null ? [] : List<Document>.from(json["documents"]!.map((x) => Document.fromJson(x))),
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
    "client_id_expiry": "${clientIdExpiry!.year.toString().padLeft(4, '0')}-${clientIdExpiry!.month.toString().padLeft(2, '0')}-${clientIdExpiry!.day.toString().padLeft(2, '0')}",
    "passport_file": passportFile,
    "passport_expiry": "${passportExpiry!.year.toString().padLeft(4, '0')}-${passportExpiry!.month.toString().padLeft(2, '0')}-${passportExpiry!.day.toString().padLeft(2, '0')}",
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
    "tenancy_contract_expiry": "${tenancyContractExpiry!.year.toString().padLeft(4, '0')}-${tenancyContractExpiry!.month.toString().padLeft(2, '0')}-${tenancyContractExpiry!.day.toString().padLeft(2, '0')}",
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
    "status_history": statusHistory == null ? [] : List<dynamic>.from(statusHistory!.map((x) => x.toJson())),
    "unit": unit?.toJson(),
    "documents": documents == null ? [] : List<dynamic>.from(documents!.map((x) => x.toJson())),
  };
}