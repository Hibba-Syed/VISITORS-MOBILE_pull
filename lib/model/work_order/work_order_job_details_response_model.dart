// To parse this JSON data, do
//
//     final workOrderJobDetailsResponseModel = workOrderJobDetailsResponseModelFromJson(jsonString);

import 'dart:convert';

WorkOrderJobDetailsResponseModel workOrderJobDetailsResponseModelFromJson(String str) => WorkOrderJobDetailsResponseModel.fromJson(json.decode(str));

String workOrderJobDetailsResponseModelToJson(WorkOrderJobDetailsResponseModel data) => json.encode(data.toJson());

class WorkOrderJobDetailsResponseModel {
  String? status;
  Record? record;
  int? code;
  dynamic meta;
  bool? requestStatus;
  String? message;

  WorkOrderJobDetailsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory WorkOrderJobDetailsResponseModel.fromJson(Map<String, dynamic> json) => WorkOrderJobDetailsResponseModel(
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
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  String? type;
  int? companyId;
  int? associationId;
  dynamic isPaymentSuggested;
  dynamic isManPowerSuggested;
  String? reference;
  int? views;
  int? userId;
  dynamic actionUserId;
  dynamic publishedDate;
  dynamic dueDate;
  DateTime? startDate;
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
  String? contractTime;
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
  int? invDueDays;
  int? isCrr;
  bool? isPrivate;
  int? isNestedEvaluation;
  bool? isVendorInvoice;
  dynamic importedAt;
  dynamic fileName;
  int? categoryMatch;
  bool? isViewed;
  String? excerpt;
  int? totalAmount;
  bool? isApplied;
  bool? isBookmarked;
  String? applyUrl;
  String? publicUrl;
  NewVendor? newVendor;
  Category? category;
  List<Asset>? assets;
  PrimaryContact? primaryContact;

  Record({
    this.id,
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
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.type,
    this.companyId,
    this.associationId,
    this.isPaymentSuggested,
    this.isManPowerSuggested,
    this.reference,
    this.views,
    this.userId,
    this.actionUserId,
    this.publishedDate,
    this.dueDate,
    this.startDate,
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
    this.categoryMatch,
    this.isViewed,
    this.excerpt,
    this.totalAmount,
    this.isApplied,
    this.isBookmarked,
    this.applyUrl,
    this.publicUrl,
    this.newVendor,
    this.category,
    this.assets,
    this.primaryContact,
  });

  factory Record.fromJson(Map<String, dynamic> json) => Record(
    id: json["id"],
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    type: json["type"],
    companyId: json["company_id"],
    associationId: json["association_id"],
    isPaymentSuggested: json["is_payment_suggested"],
    isManPowerSuggested: json["is_man_power_suggested"],
    reference: json["reference"],
    views: json["views"],
    userId: json["user_id"],
    actionUserId: json["action_user_id"],
    publishedDate: json["published_date"],
    dueDate: json["due_date"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
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
    importedAt: json["imported_at"],
    fileName: json["file_name"],
    categoryMatch: json["category_match"],
    isViewed: json["is_viewed"],
    excerpt: json["excerpt"],
    totalAmount: json["total_amount"],
    isApplied: json["is_applied"],
    isBookmarked: json["is_bookmarked"],
    applyUrl: json["apply_url"],
    publicUrl: json["public_url"],
    newVendor: json["new_vendor"] == null ? null : NewVendor.fromJson(json["new_vendor"]),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    assets: json["assets"] == null ? [] : List<Asset>.from(json["assets"]!.map((x) => Asset.fromJson(x))),
    primaryContact: json["primary_contact"] == null ? null : PrimaryContact.fromJson(json["primary_contact"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
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
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "type": type,
    "company_id": companyId,
    "association_id": associationId,
    "is_payment_suggested": isPaymentSuggested,
    "is_man_power_suggested": isManPowerSuggested,
    "reference": reference,
    "views": views,
    "user_id": userId,
    "action_user_id": actionUserId,
    "published_date": publishedDate,
    "due_date": dueDate,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
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
    "imported_at": importedAt,
    "file_name": fileName,
    "category_match": categoryMatch,
    "is_viewed": isViewed,
    "excerpt": excerpt,
    "total_amount": totalAmount,
    "is_applied": isApplied,
    "is_bookmarked": isBookmarked,
    "apply_url": applyUrl,
    "public_url": publicUrl,
    "new_vendor": newVendor?.toJson(),
    "category": category?.toJson(),
    "assets": assets == null ? [] : List<dynamic>.from(assets!.map((x) => x.toJson())),
    "primary_contact": primaryContact?.toJson(),
  };
}

class Asset {
  int? id;
  String? name;
  dynamic fullLocation;
  String? warrantyAttachmentUrl;
  String? fullName;
  Pivot? pivot;

  Asset({
    this.id,
    this.name,
    this.fullLocation,
    this.warrantyAttachmentUrl,
    this.fullName,
    this.pivot,
  });

  factory Asset.fromJson(Map<String, dynamic> json) => Asset(
    id: json["id"],
    name: json["name"],
    fullLocation: json["full_location"],
    warrantyAttachmentUrl: json["warranty_attachment_url"],
    fullName: json["full_name"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "full_location": fullLocation,
    "warranty_attachment_url": warrantyAttachmentUrl,
    "full_name": fullName,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  int? jpJobId;
  int? jpAssetId;

  Pivot({
    this.jpJobId,
    this.jpAssetId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    jpJobId: json["jp_job_id"],
    jpAssetId: json["jp_asset_id"],
  );

  Map<String, dynamic> toJson() => {
    "jp_job_id": jpJobId,
    "jp_asset_id": jpAssetId,
  };
}

class Category {
  int? id;
  String? name;
  String? pictureUrl;

  Category({
    this.id,
    this.name,
    this.pictureUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    pictureUrl: json["picture_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "picture_url": pictureUrl,
  };
}

class NewVendor {
  int? id;
  String? companyName;
  String? contactNumber;
  String? contactEmail;
  double? rating;
  String? logoUrl;
  String? jpgLogoUrl;
  String? faviconUrl;
  String? backgroundImageUrl;
  String? trnCertificateUrl;
  String? licenseCopyUrl;
  bool? hasPendingCreditNotes;
  int? paymentGatewayEnabled;
  bool? smsGatewayEnabled;
  dynamic subdomain;
  String? fullAddress;
  int? isBilled;
  List<dynamic>? offDays;
  dynamic user;

  NewVendor({
    this.id,
    this.companyName,
    this.contactNumber,
    this.contactEmail,
    this.rating,
    this.logoUrl,
    this.jpgLogoUrl,
    this.faviconUrl,
    this.backgroundImageUrl,
    this.trnCertificateUrl,
    this.licenseCopyUrl,
    this.hasPendingCreditNotes,
    this.paymentGatewayEnabled,
    this.smsGatewayEnabled,
    this.subdomain,
    this.fullAddress,
    this.isBilled,
    this.offDays,
    this.user,
  });

  factory NewVendor.fromJson(Map<String, dynamic> json) => NewVendor(
    id: json["id"],
    companyName: json["company_name"],
    contactNumber: json["contact_number"],
    contactEmail: json["contact_email"],
    rating: json["rating"]?.toDouble(),
    logoUrl: json["logo_url"],
    jpgLogoUrl: json["jpg_logo_url"],
    faviconUrl: json["favicon_url"],
    backgroundImageUrl: json["background_image_url"],
    trnCertificateUrl: json["trn_certificate_url"],
    licenseCopyUrl: json["license_copy_url"],
    hasPendingCreditNotes: json["has_pending_credit_notes"],
    paymentGatewayEnabled: json["payment_gateway_enabled"],
    smsGatewayEnabled: json["sms_gateway_enabled"],
    subdomain: json["subdomain"],
    fullAddress: json["full_address"],
    isBilled: json["is_billed"],
    offDays: json["off_days"] == null ? [] : List<dynamic>.from(json["off_days"]!.map((x) => x)),
    user: json["user"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "company_name": companyName,
    "contact_number": contactNumber,
    "contact_email": contactEmail,
    "rating": rating,
    "logo_url": logoUrl,
    "jpg_logo_url": jpgLogoUrl,
    "favicon_url": faviconUrl,
    "background_image_url": backgroundImageUrl,
    "trn_certificate_url": trnCertificateUrl,
    "license_copy_url": licenseCopyUrl,
    "has_pending_credit_notes": hasPendingCreditNotes,
    "payment_gateway_enabled": paymentGatewayEnabled,
    "sms_gateway_enabled": smsGatewayEnabled,
    "subdomain": subdomain,
    "full_address": fullAddress,
    "is_billed": isBilled,
    "off_days": offDays == null ? [] : List<dynamic>.from(offDays!.map((x) => x)),
    "user": user,
  };
}

class PrimaryContact {
  int? id;
  int? jpJobId;
  String? name;
  String? email;
  String? contactNumber;
  int? isPrimary;

  PrimaryContact({
    this.id,
    this.jpJobId,
    this.name,
    this.email,
    this.contactNumber,
    this.isPrimary,
  });

  factory PrimaryContact.fromJson(Map<String, dynamic> json) => PrimaryContact(
    id: json["id"],
    jpJobId: json["jp_job_id"],
    name: json["name"],
    email: json["email"],
    contactNumber: json["contact_number"],
    isPrimary: json["is_primary"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "jp_job_id": jpJobId,
    "name": name,
    "email": email,
    "contact_number": contactNumber,
    "is_primary": isPrimary,
  };
}
