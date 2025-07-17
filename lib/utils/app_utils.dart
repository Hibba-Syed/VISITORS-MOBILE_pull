import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:easy_localization/easy_localization.dart';
import '../model/service/service_model.dart';
import '../resource/constants/strings.dart';
import '../resource/styles/styles.dart';
import '../view/screens/services/detail/access_device_service_details_sceen.dart';
import '../view/screens/services/detail/delivery_permit_service_details_screen.dart';
import '../view/screens/services/detail/facility_booking_service_details_screen.dart';
import '../view/screens/services/detail/fit_out_service_details_screen.dart';
import '../view/screens/services/detail/move_in_service_details_screen.dart';
import '../view/screens/services/detail/move_out_service_details_screen.dart';
import '../view/screens/services/detail/short_stay_service_details_screen.dart';
import '../view/screens/services/detail/work_permit_service_details_screen.dart';

class AppUtils {
  // Status colors
  static Color getStatusColor(String? status) {
    if (status?.toLowerCase() == "active") {
      return AppColors.green;
    }
    if (status?.toLowerCase() == "approved") {
      return AppColors.green;
    }
    if (status?.toLowerCase() == "notified") {
      return AppColors.primary;
    }
    if (status?.toLowerCase() == "waiting for payment") {
      return Colors.grey;
    }

    return AppColors.red;
  }

  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >=
        AppConstants.tabletScreen;
  }

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide <=
        AppConstants.mobileScreen;
  }


  static Color getCheckOutTypeColor(String? type) {
    if (type?.toLowerCase() == "community visit") {
      return AppColors.yellow;
    }
    if (type?.toLowerCase() == "community service") {
      return AppColors.primary;
    }
    if (type?.toLowerCase() == "unit visit") {
      return AppColors.cyanBlue;
    }
    if (type?.toLowerCase() == "guest") {
      return AppColors.green;
    }
    if (type?.toLowerCase() == "visitor_passes") {
      return AppColors.yellow;
    }

    return AppColors.red;
  }

  // static String getDateRangeStringFromLabel(String label) {
  //   final now = DateTime.now();
  //   DateTime fromDate;
  //   if (label == 'Last 30 Days') {
  //     fromDate = now.subtract(const Duration(days: 30));
  //   } else if (label == 'Last 60 Days') {
  //     fromDate = now.subtract(const Duration(days: 60));
  //   } else if (label == 'Last 90 Days') {
  //     fromDate = now.subtract(const Duration(days: 90));
  //   } else {
  //     fromDate = now;
  //   }
  //   String format(DateTime date) {
  //     return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  //   }
  //
  //   return '${format(fromDate)} - ${format(now)}';
  // }
  //
  static DateTimeRange getDateRangeStringFromLabel(String? label) {
    final now = DateTime.now();
    DateTime fromDate;
    if (label == 'Last 30 Days') {
      fromDate = now.subtract(const Duration(days: 30));
    } else if (label == 'Last 60 Days') {
      fromDate = now.subtract(const Duration(days: 60));
    } else if (label == 'Last 90 Days') {
      fromDate = now.subtract(const Duration(days: 90));
    } else {
      fromDate = now;
    }
    return DateTimeRange(start: fromDate, end: now);
  }

  static TypeModel getServiceableType(String? type) {
    if (type == "job") {
      return TypeModel(label: "Work Order / RFP", value: Strings.keyWorkOrder);
    } else if (type == "application") {
      return TypeModel(label: "Service", value: Strings.keyServices);
    } else if (type == "App\\Models\\Visitor\\VisitorPass") {
      return TypeModel(label: "Visitor Pass", value: Strings.keyVisitorPass);
    }
    else if (type == "guest") {
      return TypeModel(label: "Guests", value: Strings.keyGuest);
    }
    else if (type == null || type.isEmpty) {
      return TypeModel(label: "Guest", value: Strings.keyGuest);
    }
    else {
      return TypeModel(label: "Select", value: "");
    }
  }

  static List<TypeModel> serviceTypeList = [
    TypeModel(label: AppUtils.languageTranslate('accessDevice'), value: 'AD'),
    TypeModel(label: AppUtils.languageTranslate('deliveryPermit'), value: 'DP'),
    TypeModel(label: AppUtils.languageTranslate('facilityBooking'), value: 'HB'),
    TypeModel(label: AppUtils.languageTranslate('fitOut'), value: 'FO'),
    TypeModel(label: AppUtils.languageTranslate('moveIn'), value: 'MI'),
    TypeModel(label: AppUtils.languageTranslate('moveOut'), value: 'MO'),
    TypeModel(label: AppUtils.languageTranslate('workPermit'), value: 'WP'),
    TypeModel(label: AppUtils.languageTranslate('shortStay'), value: 'SS'),
  ];

  static List<TypeModel> workOrderType = [
    TypeModel(label: AppUtils.languageTranslate('workOrder'), value: '1'),
    TypeModel(label: AppUtils.languageTranslate('rfp'), value: '0'),
  ];

  static List<TypeModel> checkInTypeList = [
    TypeModel(label: AppUtils.languageTranslate('guests'), value: Strings.keyGuest),
    TypeModel(label: AppUtils.languageTranslate('services'), value: Strings.keyServices),
    TypeModel(label: AppUtils.languageTranslate('workOrdersRFPs'), value: Strings.keyWorkOrder),
    TypeModel(label: AppUtils.languageTranslate('visitorPass'), value: Strings.keyVisitorPass),
  ];

  static Widget getRouteName(ServiceModel? service) {
    String? type = service?.applicationTitle?.toLowerCase();

    switch (type) {
      case "ad":
        return AccessDeviceServiceDetailsScreen(service: service);
      case "hb":
        return FacilityBookingServiceDetailsScreen(service: service);
      case "dp":
        return DeliveryPermitServiceDetailsScreen(service: service);
      case "fo":
        return FitOutServiceDetailsScreen(service: service);
      case "mi":
        return MoveInServiceDetailsScreen(service: service);
      case "mo":
        return MoveOutServiceDetailsScreen(service: service);
      case "wp":
        return WorkPermitServiceDetailsScreen(service: service);
      case "ss":
        return ShortStayServiceDetailsScreen(service: service);
      default:
        return const Scaffold(
          body: Center(
              child: Text(
            "No service details available",
            style: AppTextStyles.style13DarkGrey600,
          )),
        );
    }
  }

  static String? getRequestName(String? applicationType) {
    String? requestName;
    if (applicationType == "AD") {
      requestName = AppUtils.languageTranslate('accessDevice');
    }
    if (applicationType == "MI") {
      requestName = AppUtils.languageTranslate('moveIn');
    }
    if (applicationType == "MO") {
      requestName = AppUtils.languageTranslate('moveOut');
    }
    if (applicationType == "WP") {
      requestName = AppUtils.languageTranslate('workPermit');
    }
    if (applicationType == "FO") {
      requestName = AppUtils.languageTranslate('fitOut');
    }
    if (applicationType == "HB") {
      requestName = AppUtils.languageTranslate('facilityBooking');
    }
    // if (applicationType == "TP") {
    //   requestName = "Transfer of Property";
    // }
    // if (applicationType == "CS") {}
    // if (applicationType == "RI") {
    //   requestName = "Resident Information";
    // }
    if (applicationType == "DP") {
      requestName = AppUtils.languageTranslate('deliveryPermit');
    }
    if (applicationType == "SS") {
      requestName = AppUtils.languageTranslate('shortStay');
    }
    return requestName;
  }

  static String? getNationalityName(String code) {
    return AppConstants.nationalityMap[code.toUpperCase()] ?? '';
  }

  static String languageTranslate(String key) {
    return tr(key);
  }
}

class TypeModel {
  final String label;
  final String value;

  TypeModel({required this.label, required this.value});
}

class RangeOption {
  final String label;
  final String value;

  RangeOption(this.label, this.value);
}
