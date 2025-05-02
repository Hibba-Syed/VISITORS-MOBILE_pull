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
  };
}