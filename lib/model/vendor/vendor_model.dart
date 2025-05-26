class VendorModel {
  int? id;
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

  VendorModel({
    this.id,
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

  factory VendorModel.fromJson(Map<String, dynamic> json) => VendorModel(
    id: json["id"],
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