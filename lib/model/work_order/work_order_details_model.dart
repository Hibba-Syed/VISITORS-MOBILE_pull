import 'package:visitors/model/work_order/primary_contact_model.dart';

import '../new_vendor_model.dart';
import 'asset_model.dart';
import 'category_model.dart';

class WorkOrderDetailsModel {
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

  WorkOrderDetailsModel({
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

  factory WorkOrderDetailsModel.fromJson(Map<String, dynamic> json) => WorkOrderDetailsModel(
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