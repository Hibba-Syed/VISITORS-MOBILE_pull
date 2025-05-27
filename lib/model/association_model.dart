import 'package:visitors/model/oam_company_model.dart';
import 'package:visitors/model/visitors_purpose_model.dart';

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
  };
}