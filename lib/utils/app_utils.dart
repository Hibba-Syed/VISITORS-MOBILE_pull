
import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';

class AppUtils {
  // Status colors
  static Color getStatusColor(String? status) {
    if (status?.toLowerCase() == "active") {
      return AppColors.green;
    }
    if (status?.toLowerCase() == "approved") {
      return AppColors.primary;
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
}
