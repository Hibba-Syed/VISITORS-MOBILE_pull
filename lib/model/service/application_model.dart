

import '../deviceInfo_model.dart';

class Application {
  int? id;
  String? contractorName;
  String? contactPerson;
  String? contractorPhone;
  int? noOfStaffExpected;
  DateTime? startDate;
  DateTime? endDate;
  int? fitoutFee;
  String? feePaymentStatus;
  dynamic paymentRef;
  int? totalPayableFee;
  int? securityDeposit;
  dynamic securityDepositDetails;
  String? securityDepositStatus;
  dynamic securityChequeDetails;
  dynamic securityChequeAttachment;
  dynamic rejectionNote;
  dynamic assetCondition;
  dynamic repairCost;
  dynamic refundSecurityAmount;
  dynamic postEventReport;
  dynamic postEventReportBy;
  dynamic contractorCoverLetter;
  dynamic nocFromOwner;
  dynamic appointmentLetter;
  dynamic tradeLicenseContractor;
  dynamic contractorInsurance;
  dynamic workDrawing;
  dynamic dubaiCivilDefenceApproval;
  dynamic dcdApprovalFireFighting;
  dynamic requiredDocsCas;
  dynamic nocStatus;
  DateTime? createdAt;
  DateTime? updatedAt;
  dynamic deletedAt;
  dynamic securityNumber;
  int? isElectricity;
  String? type;
  dynamic isDewaNocApplied;
  dynamic isFinalNocApplied;
  dynamic dewaNocFee;
  dynamic finalNocFee;
  dynamic dewaNocPaymentStatus;
  dynamic finalNocPaymentStatus;
  dynamic finalNocDocumentStatus;
  String? appointmentLetterUrl;
  String? tradeLicenseContractorUrl;
  String? securityChequeAttachmentUrl;
  String? contractorInsuranceUrl;
  String? workDrawingUrl;
  String? nocFromOwnerUrl;
  String? contractorCoverLetterUrl;
  String? dubaiCivilDefenceApprovalUrl;
  String? dcdApprovalFireFightingUrl;
  String? securityDepositStatusLbl;
  String? feePaymentStatusLbl;
  String? dewaNocPaymentStatusLbl;
  String? finalNocPaymentStatusLbl;
  List<dynamic>? addons;
  List<dynamic>? dewanoc;
  // type move out and type move in are same
  String? requestType;
  dynamic emergencyNumber;
  DateTime? moveDate;
  String? moveTimeFrom;
  String? moveTimeTo;
  dynamic refundAmount;
  dynamic nationality;
  dynamic handoverMoveout;
  dynamic noteForSecurity;
  dynamic applicantDamageNote;
  dynamic completeChecklist;
  dynamic dubaiSiliconOasisPermit;
  dynamic serviceChargeStatus;
  dynamic residentRequestId;
  dynamic mcEmiratesId;
  dynamic mcContactPerson;
  dynamic mcTradeLicense;
  dynamic mcCompanyName;
  String? mcEmiratesPathUrl;
  String? mcTradeLicensePathUrl;
  // type delivery permit
  DateTime? datetime;
  String? deliveryCompany;
  String? description;
  // type facility booking
  String? natureOfFunction;
  String? facility;
  int? expectedGuests;
  DateTime? bookingDate;
  String? startTime;
  String? endTime;
  // type work permit
  dynamic requiredDocCas;
  String? tradelicenseContractorUrl;
  // type access device
  dynamic clientOldCard;
  dynamic clientNewCardNumber;
  String? clientVehicleNumber;
  String? requesterType;
  DateTime? acrDate;
  List<DeviceInfo>? deviceInfo;
  Application({
    this.id,
    this.contractorName,
    this.contactPerson,
    this.contractorPhone,
    this.noOfStaffExpected,
    this.startDate,
    this.endDate,
    this.fitoutFee,
    this.feePaymentStatus,
    this.paymentRef,
    this.totalPayableFee,
    this.securityDeposit,
    this.securityDepositDetails,
    this.securityDepositStatus,
    this.securityChequeDetails,
    this.securityChequeAttachment,
    this.rejectionNote,
    this.assetCondition,
    this.repairCost,
    this.refundSecurityAmount,
    this.postEventReport,
    this.postEventReportBy,
    this.contractorCoverLetter,
    this.nocFromOwner,
    this.appointmentLetter,
    this.tradeLicenseContractor,
    this.contractorInsurance,
    this.workDrawing,
    this.dubaiCivilDefenceApproval,
    this.dcdApprovalFireFighting,
    this.requiredDocsCas,
    this.nocStatus,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.securityNumber,
    this.isElectricity,
    this.type,
    this.isDewaNocApplied,
    this.isFinalNocApplied,
    this.dewaNocFee,
    this.finalNocFee,
    this.dewaNocPaymentStatus,
    this.finalNocPaymentStatus,
    this.finalNocDocumentStatus,
    this.appointmentLetterUrl,
    this.tradeLicenseContractorUrl,
    this.securityChequeAttachmentUrl,
    this.contractorInsuranceUrl,
    this.workDrawingUrl,
    this.nocFromOwnerUrl,
    this.contractorCoverLetterUrl,
    this.dubaiCivilDefenceApprovalUrl,
    this.dcdApprovalFireFightingUrl,
    this.securityDepositStatusLbl,
    this.feePaymentStatusLbl,
    this.dewaNocPaymentStatusLbl,
    this.finalNocPaymentStatusLbl,
    this.addons,
    this.dewanoc,
    ///
    this.requestType,
    this.emergencyNumber,
    this.moveDate,
    this.moveTimeFrom,
    this.moveTimeTo,
    this.refundAmount,
    this.nationality,
    this.handoverMoveout,
    this.noteForSecurity,
    this.applicantDamageNote,
    this.completeChecklist,
    this.dubaiSiliconOasisPermit,
    this.serviceChargeStatus,
    this.residentRequestId,
    this.mcEmiratesId,
    this.mcContactPerson,
    this.mcTradeLicense,
    this.mcCompanyName,
    this.mcEmiratesPathUrl,
    this.mcTradeLicensePathUrl,
    //
    this.datetime,
    this.deliveryCompany,
    this.description,
    //
    this.natureOfFunction,
    this.facility,
    this.expectedGuests,
    this.bookingDate,
    this.startTime,
    this.endTime,
    //
    this.requiredDocCas,
    this.tradelicenseContractorUrl,
    //
    this.clientOldCard,
    this.clientNewCardNumber,
    this.clientVehicleNumber,
    this.requesterType,
    this.acrDate,
    this.deviceInfo,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
    id: json["id"],
    contractorName: json["contractor_name"],
    contactPerson: json["contact_person"],
    contractorPhone: json["contractor_phone"],
    noOfStaffExpected: json["no_of_staff_expected"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    fitoutFee: json["fitout_fee"],
    feePaymentStatus: json["fee_payment_status"],
    paymentRef: json["payment_ref"],
    totalPayableFee: json["total_payable_fee"],
    securityDeposit: json["security_deposit"],
    securityDepositDetails: json["security_deposit_details"],
    securityDepositStatus: json["security_deposit_status"],
    securityChequeDetails: json["security_cheque_details"],
    securityChequeAttachment: json["security_cheque_attachment"],
    rejectionNote: json["rejection_note"],
    assetCondition: json["asset_condition"],
    repairCost: json["repair_cost"],
    refundSecurityAmount: json["refund_security_amount"],
    postEventReport: json["post_event_report"],
    postEventReportBy: json["post_event_report_by"],
    contractorCoverLetter: json["contractor_cover_letter"],
    nocFromOwner: json["noc_from_owner"],
    appointmentLetter: json["appointment_letter"],
    tradeLicenseContractor: json["trade_license_contractor"],
    contractorInsurance: json["contractor_insurance"],
    workDrawing: json["work_drawing"],
    dubaiCivilDefenceApproval: json["dubai_civil_defence_approval"],
    dcdApprovalFireFighting: json["dcd_approval_fire_fighting"],
    requiredDocsCas: json["required_docs_cas"],
    nocStatus: json["noc_status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    securityNumber: json["security_number"],
    isElectricity: json["is_electricity"],
    type: json["type"],
    isDewaNocApplied: json["is_dewa_noc_applied"],
    isFinalNocApplied: json["is_final_noc_applied"],
    dewaNocFee: json["dewa_noc_fee"],
    finalNocFee: json["final_noc_fee"],
    dewaNocPaymentStatus: json["dewa_noc_payment_status"],
    finalNocPaymentStatus: json["final_noc_payment_status"],
    finalNocDocumentStatus: json["final_noc_document_status"],
    appointmentLetterUrl: json["appointment_letter_url"],
    tradeLicenseContractorUrl: json["trade_license_contractor_url"],
    securityChequeAttachmentUrl: json["security_cheque_attachment_url"],
    contractorInsuranceUrl: json["contractor_insurance_url"],
    workDrawingUrl: json["work_drawing_url"],
    nocFromOwnerUrl: json["noc_from_owner_url"],
    contractorCoverLetterUrl: json["contractor_cover_letter_url"],
    dubaiCivilDefenceApprovalUrl: json["dubai_civil_defence_approval_url"],
    dcdApprovalFireFightingUrl: json["dcd_approval_fire_fighting_url"],
    securityDepositStatusLbl: json["security_deposit_status_lbl"],
    feePaymentStatusLbl: json["fee_payment_status_lbl"],
    dewaNocPaymentStatusLbl: json["dewa_noc_payment_status_lbl"],
    finalNocPaymentStatusLbl: json["final_noc_payment_status_lbl"],
    addons: json["addons"] == null ? [] : List<dynamic>.from(json["addons"]!.map((x) => x)),
    dewanoc: json["dewanoc"] == null ? [] : List<dynamic>.from(json["dewanoc"]!.map((x) => x)),
    ///
    requestType: json["request_type"],
    emergencyNumber: json["emergency_number"],
    moveDate: json["move_date"] == null ? null : DateTime.parse(json["move_date"]),
    moveTimeFrom: json["move_time_from"],
    moveTimeTo: json["move_time_to"],
    refundAmount: json["refund_amount"],
    nationality: json["nationality"],
    handoverMoveout: json["handover_moveout"],
    noteForSecurity: json["note_for_security"],
    applicantDamageNote: json["applicant_damage_note"],
    completeChecklist: json["complete_checklist"],
    dubaiSiliconOasisPermit: json["dubai_silicon_oasis_permit"],
    serviceChargeStatus: json["service_charge_status"],
    residentRequestId: json["resident_request_id"],
    mcEmiratesId: json["mc_emirates_id"],
    mcContactPerson: json["mc_contact_person"],
    mcTradeLicense: json["mc_trade_license"],
    mcCompanyName: json["mc_company_name"],
    mcEmiratesPathUrl: json["mc_emirates_path_url"],
    mcTradeLicensePathUrl: json["mc_trade_license_path_url"],
    ///
    datetime: json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
    deliveryCompany: json["delivery_company"],
    description: json["description"],
    //
    natureOfFunction: json["nature_of_function"],
    facility: json["facility"],
    expectedGuests: json["expected_guests"],
    bookingDate: json["booking_date"] == null ? null : DateTime.parse(json["booking_date"]),
    startTime: json["start_time"],
    endTime: json["end_time"],
    //
    requiredDocCas: json["required_doc_cas"],
    tradelicenseContractorUrl: json["tradelicense_contractor_url"],
    //
    clientOldCard: json["client_old_card"],
    clientNewCardNumber: json["client_new_card_number"],
    clientVehicleNumber: json["client_vehicle_number"],
    requesterType: json["requester_type"],
    acrDate: json["acr_date"] == null ? null : DateTime.parse(json["acr_date"]),
    deviceInfo: json["device_info"] == null ? [] : List<DeviceInfo>.from(json["device_info"]!.map((x) => DeviceInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contractor_name": contractorName,
    "contact_person": contactPerson,
    "contractor_phone": contractorPhone,
    "no_of_staff_expected": noOfStaffExpected,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "fitout_fee": fitoutFee,
    "fee_payment_status": feePaymentStatus,
    "payment_ref": paymentRef,
    "total_payable_fee": totalPayableFee,
    "security_deposit": securityDeposit,
    "security_deposit_details": securityDepositDetails,
    "security_deposit_status": securityDepositStatus,
    "security_cheque_details": securityChequeDetails,
    "security_cheque_attachment": securityChequeAttachment,
    "rejection_note": rejectionNote,
    "asset_condition": assetCondition,
    "repair_cost": repairCost,
    "refund_security_amount": refundSecurityAmount,
    "post_event_report": postEventReport,
    "post_event_report_by": postEventReportBy,
    "contractor_cover_letter": contractorCoverLetter,
    "noc_from_owner": nocFromOwner,
    "appointment_letter": appointmentLetter,
    "trade_license_contractor": tradeLicenseContractor,
    "contractor_insurance": contractorInsurance,
    "work_drawing": workDrawing,
    "dubai_civil_defence_approval": dubaiCivilDefenceApproval,
    "dcd_approval_fire_fighting": dcdApprovalFireFighting,
    "required_docs_cas": requiredDocsCas,
    "noc_status": nocStatus,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "security_number": securityNumber,
    "is_electricity": isElectricity,
    "type": type,
    "is_dewa_noc_applied": isDewaNocApplied,
    "is_final_noc_applied": isFinalNocApplied,
    "dewa_noc_fee": dewaNocFee,
    "final_noc_fee": finalNocFee,
    "dewa_noc_payment_status": dewaNocPaymentStatus,
    "final_noc_payment_status": finalNocPaymentStatus,
    "final_noc_document_status": finalNocDocumentStatus,
    "appointment_letter_url": appointmentLetterUrl,
    "trade_license_contractor_url": tradeLicenseContractorUrl,
    "security_cheque_attachment_url": securityChequeAttachmentUrl,
    "contractor_insurance_url": contractorInsuranceUrl,
    "work_drawing_url": workDrawingUrl,
    "noc_from_owner_url": nocFromOwnerUrl,
    "contractor_cover_letter_url": contractorCoverLetterUrl,
    "dubai_civil_defence_approval_url": dubaiCivilDefenceApprovalUrl,
    "dcd_approval_fire_fighting_url": dcdApprovalFireFightingUrl,
    "security_deposit_status_lbl": securityDepositStatusLbl,
    "fee_payment_status_lbl": feePaymentStatusLbl,
    "dewa_noc_payment_status_lbl": dewaNocPaymentStatusLbl,
    "final_noc_payment_status_lbl": finalNocPaymentStatusLbl,
    "addons": addons == null ? [] : List<dynamic>.from(addons!.map((x) => x)),
    "dewanoc": dewanoc == null ? [] : List<dynamic>.from(dewanoc!.map((x) => x)),
    ///
    "request_type": requestType,
    "emergency_number": emergencyNumber,
    "move_date": "${moveDate!.year.toString().padLeft(4, '0')}-${moveDate!.month.toString().padLeft(2, '0')}-${moveDate!.day.toString().padLeft(2, '0')}",
    "move_time_from": moveTimeFrom,
    "move_time_to": moveTimeTo,
    "refund_amount": refundAmount,
    "nationality": nationality,
    "handover_moveout": handoverMoveout,
    "note_for_security": noteForSecurity,
    "applicant_damage_note": applicantDamageNote,
    "complete_checklist": completeChecklist,
    "dubai_silicon_oasis_permit": dubaiSiliconOasisPermit,
    "service_charge_status": serviceChargeStatus,
    "resident_request_id": residentRequestId,
    "mc_emirates_id": mcEmiratesId,
    "mc_contact_person": mcContactPerson,
    "mc_trade_license": mcTradeLicense,
    "mc_company_name": mcCompanyName,
    "mc_emirates_path_url": mcEmiratesPathUrl,
    "mc_trade_license_path_url": mcTradeLicensePathUrl,
    ///
    "datetime": "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
    "delivery_company": deliveryCompany,
    "description": description,
    //
    "nature_of_function": natureOfFunction,
    "facility": facility,
    "expected_guests": expectedGuests,
    "booking_date": "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
    "start_time": startTime,
    "end_time": endTime,
    //
    "required_doc_cas": requiredDocCas,
    "tradelicense_contractor_url": tradelicenseContractorUrl,
    //
    "client_old_card": clientOldCard,
    "client_new_card_number": clientNewCardNumber,
    "client_vehicle_number": clientVehicleNumber,
    "requester_type": requesterType,
    "acr_date": acrDate?.toIso8601String(),
    "device_info": deviceInfo == null ? [] : List<dynamic>.from(deviceInfo!.map((x) => x.toJson())),

  };
}