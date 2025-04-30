
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
}
