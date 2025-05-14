
class Serviceable {
  int? id;
  int? companyId;
  int? associationId;
  int? ownerUnitId;
  String? reference;
  String? visitor;
  String? visitorCompany;
  String? mobile;
  String? email;
  dynamic startDate;
  DateTime? endDate;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? titleType;
  String? title;
  dynamic expiry;
  String? description;
  String? status;
  dynamic disapprovedReason;
  dynamic productsTotal;
  dynamic productBrand;
  dynamic productQty;
  dynamic productSize;
  dynamic productImages;
  dynamic productReferenceLink;
  dynamic deletedAt;
  String? type;
  dynamic isPaymentSuggested;
  dynamic isManPowerSuggested;
  int? views;
  int? userId;
  dynamic actionUserId;
  dynamic publishedDate;
  dynamic dueDate;
  DateTime? issuedDate;
  DateTime? finishDate;
  dynamic awardDate;
  dynamic vendorAcceptDate;
  dynamic completionDate;
  int? vendorId;
  dynamic applicantId;
  int? budgetId;
  int? jpCategoryId;
  String? slug;
  int? outOfBudget;
  int? fromReservedFund;
  dynamic contractTime;
  String? paymentsTime;
  int? amount;
  dynamic estimatedAmount;
  int? isOld;
  int? isAwarded;
  dynamic contactId;
  int? budgetExceeded;
  dynamic cancelReason;
  dynamic cancelDate;
  dynamic terminationReason;
  dynamic terminationDate;
  dynamic extendDate;
  dynamic extendReason;
  dynamic publishDays;
  dynamic invDueDays;
  dynamic isCrr;
  bool? isPrivate;
  int? isNestedEvaluation;
  bool? isVendorInvoice;
  DateTime? importedAt;
  String? fileName;
  int? applicationsCount;
  int? categoryMatch;
  bool? isViewed;
  String? excerpt;
  int? totalAmount;
  bool? isApplied;
  bool? isBookmarked;
  String? applyUrl;
  String? publicUrl;
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
  dynamic securityNumber;
  int? allSecurityPersonnel;
  int? payableAmount;
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
  String? clientIdFileUrl;
  String? passportFileUrl;
  String? titleDeedUrl;
  String? tenancyContractUrl;
  String? tradeLicenseUrl;
  bool? isMailable;
  String? fullName;
  String? profileImageUrl;

  Serviceable({
    this.id,
    this.companyId,
    this.associationId,
    this.ownerUnitId,
    this.reference,
    this.visitor,
    this.visitorCompany,
    this.mobile,
    this.email,
    this.startDate,
    this.endDate,
    this.createdAt,
    this.updatedAt,
    this.titleType,
    this.title,
    this.expiry,
    this.description,
    this.status,
    this.disapprovedReason,
    this.productsTotal,
    this.productBrand,
    this.productQty,
    this.productSize,
    this.productImages,
    this.productReferenceLink,
    this.deletedAt,
    this.type,
    this.isPaymentSuggested,
    this.isManPowerSuggested,
    this.views,
    this.userId,
    this.actionUserId,
    this.publishedDate,
    this.dueDate,
    this.issuedDate,
    this.finishDate,
    this.awardDate,
    this.vendorAcceptDate,
    this.completionDate,
    this.vendorId,
    this.applicantId,
    this.budgetId,
    this.jpCategoryId,
    this.slug,
    this.outOfBudget,
    this.fromReservedFund,
    this.contractTime,
    this.paymentsTime,
    this.amount,
    this.estimatedAmount,
    this.isOld,
    this.isAwarded,
    this.contactId,
    this.budgetExceeded,
    this.cancelReason,
    this.cancelDate,
    this.terminationReason,
    this.terminationDate,
    this.extendDate,
    this.extendReason,
    this.publishDays,
    this.invDueDays,
    this.isCrr,
    this.isPrivate,
    this.isNestedEvaluation,
    this.isVendorInvoice,
    this.importedAt,
    this.fileName,
    this.applicationsCount,
    this.categoryMatch,
    this.isViewed,
    this.excerpt,
    this.totalAmount,
    this.isApplied,
    this.isBookmarked,
    this.applyUrl,
    this.publicUrl,
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
    this.clientIdFileUrl,
    this.passportFileUrl,
    this.titleDeedUrl,
    this.tenancyContractUrl,
    this.tradeLicenseUrl,
    this.isMailable,
    this.fullName,
    this.profileImageUrl,
  });

  factory Serviceable.fromJson(Map<String, dynamic> json) => Serviceable(
    id: json["id"],
    companyId: json["company_id"],
    associationId: json["association_id"],
    ownerUnitId: json["owner_unit_id"],
    reference: json["reference"],
    visitor: json["visitor"],
    visitorCompany: json["visitor_company"],
    mobile: json["mobile"],
    email: json["email"],
    startDate: json["start_date"],
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    titleType: json["title_type"],
    title: json["title"],
    expiry: json["expiry"],
    description: json["description"],
    status: json["status"],
    disapprovedReason: json["disapproved_reason"],
    productsTotal: json["products_total"],
    productBrand: json["product_brand"],
    productQty: json["product_qty"],
    productSize: json["product_size"],
    productImages: json["product_images"],
    productReferenceLink: json["product_reference_link"],
    deletedAt: json["deleted_at"],
    type: json["type"],
    isPaymentSuggested: json["is_payment_suggested"],
    isManPowerSuggested: json["is_man_power_suggested"],
    views: json["views"],
    userId: json["user_id"],
    actionUserId: json["action_user_id"],
    publishedDate: json["published_date"],
    dueDate: json["due_date"],
    issuedDate: json["issued_date"] == null ? null : DateTime.parse(json["issued_date"]),
    finishDate: json["finish_date"] == null ? null : DateTime.parse(json["finish_date"]),
    awardDate: json["award_date"],
    vendorAcceptDate: json["vendor_accept_date"],
    completionDate: json["completion_date"],
    vendorId: json["vendor_id"],
    applicantId: json["applicant_id"],
    budgetId: json["budget_id"],
    jpCategoryId: json["jp_category_id"],
    slug: json["slug"],
    outOfBudget: json["out_of_budget"],
    fromReservedFund: json["from_reserved_fund"],
    contractTime: json["contract_time"],
    paymentsTime: json["payments_time"],
    amount: json["amount"],
    estimatedAmount: json["estimated_amount"],
    isOld: json["is_old"],
    isAwarded: json["is_awarded"],
    contactId: json["contact_id"],
    budgetExceeded: json["budget_exceeded"],
    cancelReason: json["cancel_reason"],
    cancelDate: json["cancel_date"],
    terminationReason: json["termination_reason"],
    terminationDate: json["termination_date"],
    extendDate: json["extend_date"],
    extendReason: json["extend_reason"],
    publishDays: json["publish_days"],
    invDueDays: json["inv_due_days"],
    isCrr: json["is_crr"],
    isPrivate: json["is_private"],
    isNestedEvaluation: json["is_nested_evaluation"],
    isVendorInvoice: json["is_vendor_invoice"],
    importedAt: json["imported_at"] == null ? null : DateTime.parse(json["imported_at"]),
    fileName: json["file_name"],
    applicationsCount: json["applications_count"],
    categoryMatch: json["category_match"],
    isViewed: json["is_viewed"],
    excerpt: json["excerpt"],
    totalAmount: json["total_amount"],
    isApplied: json["is_applied"],
    isBookmarked: json["is_bookmarked"],
    applyUrl: json["apply_url"],
    publicUrl: json["public_url"],
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
    clientIdFileUrl: json["client_id_file_url"],
    passportFileUrl: json["passport_file_url"],
    titleDeedUrl: json["title_deed_url"],
    tenancyContractUrl: json["tenancy_contract_url"],
    tradeLicenseUrl: json["trade_license_url"],
    isMailable: json["is_mailable"],
    fullName: json["full_name"],
    profileImageUrl: json["profile_image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_id": companyId,
    "association_id": associationId,
    "owner_unit_id": ownerUnitId,
    "reference": reference,
    "visitor": visitor,
    "visitor_company": visitorCompany,
    "mobile": mobile,
    "email": email,
    "start_date": startDate,
    "end_date": endDate?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "title_type": titleType,
    "title": title,
    "expiry": expiry,
    "description": description,
    "status": status,
    "disapproved_reason": disapprovedReason,
    "products_total": productsTotal,
    "product_brand": productBrand,
    "product_qty": productQty,
    "product_size": productSize,
    "product_images": productImages,
    "product_reference_link": productReferenceLink,
    "deleted_at": deletedAt,
    "type": type,
    "is_payment_suggested": isPaymentSuggested,
    "is_man_power_suggested": isManPowerSuggested,
    "views": views,
    "user_id": userId,
    "action_user_id": actionUserId,
    "published_date": publishedDate,
    "due_date": dueDate,
    "issued_date": "${issuedDate!.year.toString().padLeft(4, '0')}-${issuedDate!.month.toString().padLeft(2, '0')}-${issuedDate!.day.toString().padLeft(2, '0')}",
    "finish_date": "${finishDate!.year.toString().padLeft(4, '0')}-${finishDate!.month.toString().padLeft(2, '0')}-${finishDate!.day.toString().padLeft(2, '0')}",
    "award_date": awardDate,
    "vendor_accept_date": vendorAcceptDate,
    "completion_date": completionDate,
    "vendor_id": vendorId,
    "applicant_id": applicantId,
    "budget_id": budgetId,
    "jp_category_id": jpCategoryId,
    "slug": slug,
    "out_of_budget": outOfBudget,
    "from_reserved_fund": fromReservedFund,
    "contract_time": contractTime,
    "payments_time": paymentsTime,
    "amount": amount,
    "estimated_amount": estimatedAmount,
    "is_old": isOld,
    "is_awarded": isAwarded,
    "contact_id": contactId,
    "budget_exceeded": budgetExceeded,
    "cancel_reason": cancelReason,
    "cancel_date": cancelDate,
    "termination_reason": terminationReason,
    "termination_date": terminationDate,
    "extend_date": extendDate,
    "extend_reason": extendReason,
    "publish_days": publishDays,
    "inv_due_days": invDueDays,
    "is_crr": isCrr,
    "is_private": isPrivate,
    "is_nested_evaluation": isNestedEvaluation,
    "is_vendor_invoice": isVendorInvoice,
    "imported_at": importedAt?.toIso8601String(),
    "file_name": fileName,
    "applications_count": applicationsCount,
    "category_match": categoryMatch,
    "is_viewed": isViewed,
    "excerpt": excerpt,
    "total_amount": totalAmount,
    "is_applied": isApplied,
    "is_bookmarked": isBookmarked,
    "apply_url": applyUrl,
    "public_url": publicUrl,
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
    "client_id_file_url": clientIdFileUrl,
    "passport_file_url": passportFileUrl,
    "title_deed_url": titleDeedUrl,
    "tenancy_contract_url": tenancyContractUrl,
    "trade_license_url": tradeLicenseUrl,
    "is_mailable": isMailable,
    "full_name": fullName,
    "profile_image_url": profileImageUrl,
  };
}