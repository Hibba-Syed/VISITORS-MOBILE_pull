import 'dart:ui';

import 'package:visitors/resource/constants/app_colors.dart';

class AppUtils{
  // Status colors
  static  Color getStatusColor(String? status) {
    if (status?.toLowerCase() == "active") {
      return AppColors.green;
    }
    if (status?.toLowerCase()=="approved") {
      return AppColors.primary;
    }
    if (status?.toLowerCase() == "notified") {
      return AppColors.blue;
    }

    return AppColors.red;
  }
}
