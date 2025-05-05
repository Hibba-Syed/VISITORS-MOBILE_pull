class Unit {
  int? id;
  String? unitNumber;
  bool? isLegalNoticeActive;
  bool? isRdcActive;
  String? titleDeedUrl;
  dynamic residentId;


  Unit({
    this.id,
    this.unitNumber,
    this.isLegalNoticeActive,
    this.isRdcActive,
    this.titleDeedUrl,
    this.residentId,

  });

  factory Unit.fromJson(Map<String, dynamic> json) => Unit(
    id: json["id"],
    unitNumber: json["unit_number"],
    isLegalNoticeActive: json["is_legal_notice_active"],
    isRdcActive: json["is_rdc_active"],
    titleDeedUrl: json["title_deed_url"],
    residentId: json["resident_id"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "unit_number": unitNumber,
    "is_legal_notice_active": isLegalNoticeActive,
    "is_rdc_active": isRdcActive,
    "title_deed_url": titleDeedUrl,
    "resident_id": residentId,
  };
}