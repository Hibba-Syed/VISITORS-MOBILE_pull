import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';

import '../resource/constants/strings.dart';
import '../view/Common Screens/check ins/componants/check_in_filter_bottom_sheet.dart';

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
      return AppColors.cyanBlue;
    }
    if (type?.toLowerCase() == "unit visit") {
      return AppColors.green;
    }
    if (type?.toLowerCase() == "guest") {
      return AppColors.primary;
    }

    return AppColors.red;
  }

  static String getDateRangeStringFromLabel(String label) {
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
    String format(DateTime date) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    return '${format(fromDate)} - ${format(now)}';
  }

  static TypeModel getServiceableType(String? type) {
    if (type == "job") {
      return TypeModel(label: "Work Order / RFP", value: "job");
    } else if (type == "application") {
      return TypeModel(label: "Service", value: "application");
    } else if (type == "App\\Models\\Visitor\\VisitorPass") {
      return TypeModel(label: "Visitor Pass", value: "visitor_pass");
    } else if (type == null || type.isEmpty) {
      return TypeModel(label: "Guest", value: "guest");
    } else {
      return TypeModel(label: "", value: "");
    }
  }
  static List<TypeModel> serviceTypeList = [
    TypeModel(label: 'Access device', value: 'AD'),
    TypeModel(label: 'Delivery Permit', value: 'DP'),
    TypeModel(label: 'Facility Booking', value: 'FB'),
    TypeModel(label: 'Fit Out', value: 'FO'),
    TypeModel(label: 'Move In', value: 'MI'),
    TypeModel(label: 'Move Out', value: 'MO'),
    TypeModel(label: 'Work Permit', value: 'WP'),
    TypeModel(label: 'Short Stay', value: 'SS'),
  ];

  static List<TypeModel> workOrderType = [
    TypeModel(label: 'Work Order',value: '1'),
    TypeModel(label: 'RFP',value: '0'),
  ];

 static  List<TypeModel> checkInTypeList = [
    TypeModel(label: 'Guests', value: Strings.guest),
    TypeModel(label: 'Services', value: Strings.keyServices),
    TypeModel(label: 'Work Order / RFPs', value: Strings.keyWorkOrder),
    TypeModel(label: 'Visitor Pass', value: Strings.keyVisitorPass),
  ];

  static String? getRequestName(String? applicationType) {
    String? requestName;
    if (applicationType == "AD") {
      requestName = "Access Device";
    }
    if (applicationType == "MI") {
      requestName = "Move In";
    }
    if (applicationType == "MO") {
      requestName = "Move Out";
    }
    if (applicationType == "WP") {
      requestName = "Work Permit";
    }
    if (applicationType == "FO") {
      requestName = "Fit Out";
    }
    if (applicationType == "HB") {
      requestName = "Facility Booking";
    }
    if (applicationType == "TP") {
      requestName = "Transfer of Property";

    }
    if (applicationType == "CS") {
    }
    if (applicationType == "RI") {
      requestName = "Resident Information";
    }
    if (applicationType == "DP") {
      requestName = "Delivery Permit";
    }
    if (applicationType == "SS") {
      requestName = "Short Stay";
    }
    return requestName;
  }
}
