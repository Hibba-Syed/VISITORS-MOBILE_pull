import 'package:visitors/model/addons_model.dart';

import '../device_info_model.dart';
import 'guest_model.dart';

class Application {
  int? id;
  String? name;
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
  List<AddonsModel>? addons;
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
  String? mcContactPerson;
  dynamic mcTradeLicense;
  String? mcCompanyName;
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
  // short stay
  dynamic terminationDate;
  dynamic terminationNote;
  int? numberOfPeople;
  String? peoples;
  dynamic companyName;
  dynamic tourismLicense;
  dynamic tourismLicenseExpiry;
  dynamic companyRiskInsurance;
  dynamic companyRiskInsuranceExpiry;
  dynamic reraId;
  dynamic reraIdExpiry;
  dynamic visaCopy;
  dynamic visaCopyExpiry;
  String? dtcmPermit;
  DateTime? dtcmPermitExpiry;
  String? tourismLicenseUrl;
  String? companyRiskInsuranceUrl;
  String? visaCopyUrl;
  String? reraIdUrl;
  String? dtcmPermitUrl;
  bool? isTourismLicenseExpired;
  bool? isCompanyRiskInsuranceExpired;
  bool? isVisaCopyExpired;
  bool? isReraIdExpired;
  bool? isDtcmPermitExpired;
  List<Guest>? guests;
  final List<ApplicationField>? fields;
  Application({
    this.id,
    this.name,
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
    //
    this.terminationDate,
    this.terminationNote,
    this.numberOfPeople,
    this.peoples,
    this.companyName,
    this.tourismLicense,
    this.tourismLicenseExpiry,
    this.companyRiskInsurance,
    this.companyRiskInsuranceExpiry,
    this.reraId,
    this.reraIdExpiry,
    this.visaCopy,
    this.visaCopyExpiry,
    this.dtcmPermit,
    this.dtcmPermitExpiry,
    this.tourismLicenseUrl,
    this.companyRiskInsuranceUrl,
    this.visaCopyUrl,
    this.reraIdUrl,
    this.dtcmPermitUrl,
    this.isTourismLicenseExpired,
    this.isCompanyRiskInsuranceExpired,
    this.isVisaCopyExpired,
    this.isReraIdExpired,
    this.isDtcmPermitExpired,
    this.guests,
    this.fields,
  });

  factory Application.fromJson(Map<String, dynamic> json) => Application(
        id: json["id"],
        name: json["name"],
        contractorName: json["contractor_name"],
        contactPerson: json["contact_person"],
        contractorPhone: json["contractor_phone"],
        noOfStaffExpected: json["no_of_staff_expected"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
        addons: json["addons"] == null
            ? []
            : List<AddonsModel>.from(json["addons"]!.map((x) => AddonsModel.fromJson(x))),
        dewanoc: json["dewanoc"] == null
            ? []
            : List<dynamic>.from(json["dewanoc"]!.map((x) => x)),
        terminationDate: json["termination_date"],
        terminationNote: json["termination_note"],
        numberOfPeople: json["number_of_people"],
        peoples: json["peoples"],
        description: json["description"],
        companyName: json["company_name"],
        tourismLicense: json["tourism_license"],
        tourismLicenseExpiry: json["tourism_license_expiry"],
        companyRiskInsurance: json["company_risk_insurance"],
        companyRiskInsuranceExpiry: json["company_risk_insurance_expiry"],
        reraId: json["rera_id"],
        reraIdExpiry: json["rera_id_expiry"],
        visaCopy: json["visa_copy"],
        visaCopyExpiry: json["visa_copy_expiry"],
        dtcmPermit: json["dtcm_permit"],
        dtcmPermitExpiry: json["dtcm_permit_expiry"] == null
            ? null
            : DateTime.parse(json["dtcm_permit_expiry"]),
        tourismLicenseUrl: json["tourism_license_url"],
        companyRiskInsuranceUrl: json["company_risk_insurance_url"],
        visaCopyUrl: json["visa_copy_url"],
        reraIdUrl: json["rera_id_url"],
        dtcmPermitUrl: json["dtcm_permit_url"],
        isTourismLicenseExpired: json["is_tourism_license_expired"],
        isCompanyRiskInsuranceExpired:
            json["is_company_risk_insurance_expired"],
        isVisaCopyExpired: json["is_visa_copy_expired"],
        isReraIdExpired: json["is_rera_id_expired"],
        isDtcmPermitExpired: json["is_dtcm_permit_expired"],
        guests: json["guests"] == null
            ? []
            : List<Guest>.from(json["guests"]!.map((x) => Guest.fromJson(x))),

        ///
        requestType: json["request_type"],
        emergencyNumber: json["emergency_number"],
        moveDate: json["move_date"] == null
            ? null
            : DateTime.parse(json["move_date"]),
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
        datetime:
            json["datetime"] == null ? null : DateTime.parse(json["datetime"]),
        deliveryCompany: json["delivery_company"],
        //
        natureOfFunction: json["nature_of_function"],
        facility: json["facility"],
        expectedGuests: json["expected_guests"],
        bookingDate: json["booking_date"] == null
            ? null
            : DateTime.parse(json["booking_date"]),
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
        acrDate:
            json["acr_date"] == null ? null : DateTime.parse(json["acr_date"]),
        deviceInfo: json["device_info"] == null
            ? []
            : List<DeviceInfo>.from(
                json["device_info"]!.map((x) => DeviceInfo.fromJson(x))),
        fields: json["fields"] == null
            ? []
            : List<ApplicationField>.from(
                json["fields"].map((x) => ApplicationField.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "contractor_name": contractorName,
        "contact_person": contactPerson,
        "contractor_phone": contractorPhone,
        "no_of_staff_expected": noOfStaffExpected,
        "start_date":
            "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
        "end_date":
            "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
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
        "addons":
            addons == null ? [] : List<AddonsModel>.from(addons!.map((x) => x)),
        "dewanoc":
            dewanoc == null ? [] : List<dynamic>.from(dewanoc!.map((x) => x)),

        ///
        "request_type": requestType,
        "emergency_number": emergencyNumber,
        "move_date":
            "${moveDate!.year.toString().padLeft(4, '0')}-${moveDate!.month.toString().padLeft(2, '0')}-${moveDate!.day.toString().padLeft(2, '0')}",
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
        "datetime":
            "${datetime!.year.toString().padLeft(4, '0')}-${datetime!.month.toString().padLeft(2, '0')}-${datetime!.day.toString().padLeft(2, '0')}",
        "delivery_company": deliveryCompany,
        "description": description,
        //
        "nature_of_function": natureOfFunction,
        "facility": facility,
        "expected_guests": expectedGuests,
        "booking_date":
            "${bookingDate!.year.toString().padLeft(4, '0')}-${bookingDate!.month.toString().padLeft(2, '0')}-${bookingDate!.day.toString().padLeft(2, '0')}",
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
        "device_info": deviceInfo == null
            ? []
            : List<dynamic>.from(deviceInfo!.map((x) => x.toJson())),
        //
        "termination_date": terminationDate,
        "termination_note": terminationNote,
        "number_of_people": numberOfPeople,
        "peoples": peoples,
        "company_name": companyName,
        "tourism_license": tourismLicense,
        "tourism_license_expiry": tourismLicenseExpiry,
        "company_risk_insurance": companyRiskInsurance,
        "company_risk_insurance_expiry": companyRiskInsuranceExpiry,
        "rera_id": reraId,
        "rera_id_expiry": reraIdExpiry,
        "visa_copy": visaCopy,
        "visa_copy_expiry": visaCopyExpiry,
        "dtcm_permit": dtcmPermit,
        "dtcm_permit_expiry":
            "${dtcmPermitExpiry!.year.toString().padLeft(4, '0')}-${dtcmPermitExpiry!.month.toString().padLeft(2, '0')}-${dtcmPermitExpiry!.day.toString().padLeft(2, '0')}",
        "tourism_license_url": tourismLicenseUrl,
        "company_risk_insurance_url": companyRiskInsuranceUrl,
        "visa_copy_url": visaCopyUrl,
        "rera_id_url": reraIdUrl,
        "dtcm_permit_url": dtcmPermitUrl,
        "is_tourism_license_expired": isTourismLicenseExpired,
        "is_company_risk_insurance_expired": isCompanyRiskInsuranceExpired,
        "is_visa_copy_expired": isVisaCopyExpired,
        "is_rera_id_expired": isReraIdExpired,
        "is_dtcm_permit_expired": isDtcmPermitExpired,
        "guests": guests == null
            ? []
            : List<dynamic>.from(guests!.map((x) => x.toJson())),
        "fields": fields == null
            ? []
            : List<dynamic>.from(fields!.map((x) => x.toJson())),
      };
}

class ApplicationField {
  final int? id;
  final int? applicationCustomServiceId;
  final int? parentId;
  final String? type; // text, number, boolean, dropdown, etc.
  final String? label;
  final bool? isRequired;
  final int? order;
  final dynamic value; // can be String, int, bool, double, DateTime, etc.
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<ApplicationFieldValue>? values;

  ApplicationField({
    this.id,
    this.applicationCustomServiceId,
    this.parentId,
    this.type,
    this.label,
    this.isRequired,
    this.order,
    this.value,
    this.createdAt,
    this.updatedAt,
    this.values,
  });

  factory ApplicationField.fromJson(Map<String, dynamic> json) =>
      ApplicationField(
        id: json["id"],
        applicationCustomServiceId: json["application_custom_service_id"],
        parentId: json["parent_id"],
        type: json["type"],
        label: json["label"],
        isRequired: json["is_required"],
        order: json["order"],
        value: json["value"], // dynamic – leave as is
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
        values: json["values"] == null
            ? []
            : List<ApplicationFieldValue>.from(
                json["values"].map((x) => ApplicationFieldValue.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "application_custom_service_id": applicationCustomServiceId,
        "parent_id": parentId,
        "type": type,
        "label": label,
        "is_required": isRequired,
        "order": order,
        "value": value,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "values": values == null
            ? []
            : List<dynamic>.from(values!.map((x) => x.toJson())),
      };
}

class ApplicationFieldValue {
  final int? id;
  final int? applicationCustomServiceId;
  final int? parentId;
  final String? type;
  final String? label;
  final bool? isRequired;
  final int? order;
  final dynamic value;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  ApplicationFieldValue({
    this.id,
    this.applicationCustomServiceId,
    this.parentId,
    this.type,
    this.label,
    this.isRequired,
    this.order,
    this.value,
    this.createdAt,
    this.updatedAt,
  });

  factory ApplicationFieldValue.fromJson(Map<String, dynamic> json) =>
      ApplicationFieldValue(
        id: json["id"],
        applicationCustomServiceId: json["application_custom_service_id"],
        parentId: json["parent_id"],
        type: json["type"],
        label: json["label"],
        isRequired: json["is_required"],
        order: json["order"],
        value: json["value"],
        createdAt: json["created_at"] != null
            ? DateTime.tryParse(json["created_at"])
            : null,
        updatedAt: json["updated_at"] != null
            ? DateTime.tryParse(json["updated_at"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "application_custom_service_id": applicationCustomServiceId,
        "parent_id": parentId,
        "type": type,
        "label": label,
        "is_required": isRequired,
        "order": order,
        "value": value,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
