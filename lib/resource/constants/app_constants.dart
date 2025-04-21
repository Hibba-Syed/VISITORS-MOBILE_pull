import 'package:flutter/material.dart' show Colors;
import 'package:flutter/widgets.dart';

class AppConstants {
  /// drawer indexes
  static const int dashboardIndex = 0;
  static const int checkInsIndex = 1;
  static const int eServicesIndex = 2;
  static const int workOrderRfpIndex = 3;
  static const int messagesIndex = 4;
  static const int checkOutsIndex = 5;
  static const int directoryIndex = 6;
  static const int logoutIndex = 7;
  //App Padding
  static const double horizontalPadding = 10;
  static const double verticalPadding = 10;
  /// screen size
  static const double tabletScreen = 600;
  static const double mobileScreen = 300;
  ///
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide >= 600;
  }
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide <= 370;
  }

}