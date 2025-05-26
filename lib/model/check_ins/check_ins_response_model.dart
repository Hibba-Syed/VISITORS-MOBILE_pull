// To parse this JSON data, do
//
//     final visitorCheckInsModel = visitorCheckInsModelFromJson(jsonString);

import 'dart:convert';
import 'check_in_model.dart';

CheckInsResponseModel visitorCheckInsModelFromJson(String str) => CheckInsResponseModel.fromJson(json.decode(str));

String visitorCheckInsModelToJson(CheckInsResponseModel data) => json.encode(data.toJson());

class CheckInsResponseModel {
  String? status;
  List<CheckInModel>? record;
  int? code;
  Meta? meta;
  bool? requestStatus;
  String? message;

  CheckInsResponseModel({
    this.status,
    this.record,
    this.code,
    this.meta,
    this.requestStatus,
    this.message,
  });

  factory CheckInsResponseModel.fromJson(Map<String, dynamic> json) => CheckInsResponseModel(
    status: json["status"],
    record: json["record"] == null ? [] : List<CheckInModel>.from(json["record"]!.map((x) => CheckInModel.fromJson(x))),
    code: json["code"],
    meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
    requestStatus: json["request_status"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "record": record == null ? [] : List<dynamic>.from(record!.map((x) => x.toJson())),
    "code": code,
    "meta": meta?.toJson(),
    "request_status": requestStatus,
    "message": message,
  };
}

class Meta {
  int? page;
  int? lastPage;
  int? from;
  int? to;
  int? limit;
  int? total;
  bool? hasMorePages;
  bool? isFirstPage;

  Meta({
    this.page,
    this.lastPage,
    this.from,
    this.to,
    this.limit,
    this.total,
    this.hasMorePages,
    this.isFirstPage,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
    page: json["page"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
    limit: json["limit"],
    total: json["total"],
    hasMorePages: json["has_more_pages"],
    isFirstPage: json["is_first_page"],
  );

  Map<String, dynamic> toJson() => {
    "page": page,
    "last_page": lastPage,
    "from": from,
    "to": to,
    "limit": limit,
    "total": total,
    "has_more_pages": hasMorePages,
    "is_first_page": isFirstPage,
  };
}


class Vendor {
  int? id;
  String? name;
  String? companyName;
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

  Vendor({
    this.id,
    this.name,
    this.companyName,
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

  factory Vendor.fromJson(Map<String, dynamic> json) => Vendor(
    id: json["id"],
    name: json["name"],
    companyName: json["company_name"],
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
    "name": name,
    "company_name": companyName,
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


