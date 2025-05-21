class NewVendor {
  int? id;
  String? name;
  String? companyName;
  dynamic user;
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


  NewVendor({
    this.id,
    this.name,
    this.companyName,
    this.user,
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
  });

  factory NewVendor.fromJson(Map<String, dynamic> json) => NewVendor(
    id: json["id"],
    name: json["name"],
    companyName: json["company_name"],
    user: json["user"],
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
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "company_name": companyName,
    "user": user,
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
  };
}
