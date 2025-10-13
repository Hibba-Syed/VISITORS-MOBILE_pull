import 'dart:ui';

import 'package:visitors/model/range_model.dart';

import '../../utils/app_utils.dart';
import '../../view/screens/guest_check_in/guest_check_in_screen.dart';

class AppConstants {

  static const int notesMaxLength = 900;

  static const int dashboardIndex = 0;
  static const int checkInsIndex = 1;
  static const int eServicesIndex = 2;
  static const int workOrderRfpIndex = 3;
  static const int messagesIndex = 4;
  static const int checkOutsIndex = 5;
  static const int directoryIndex = 6;
  static const int logoutIndex = 7;

  static const double horizontalPadding = 10;
  static const double verticalPadding = 10;

  static const double tabletScreen = 600;
  static const double mobileScreen = 360;

  final List<RangeModel> rangeList = [
    RangeModel(
        label: AppUtils.languageTranslate('last30Days'), value: "Last 30 Days"),
    RangeModel(
        label: AppUtils.languageTranslate('last60Days'), value: "Last 60 Days"),
    RangeModel(
        label: AppUtils.languageTranslate('last90Days'), value: "Last 90 Days"),
  ];

  static const Map<String, String> nationalityMap = {
    "AFG": "Afghanistan",
    "ALB": "Albania",
    "DZA": "Algeria",
    "AND": "Andorra",
    "ARE": "United Arab Emirates",
    "ARG": "Argentina",
    "ARM": "Armenia",
    "AUS": "Australia",
    "AUT": "Austria",
    "AZE": "Azerbaijan",
    "BGD": "Bangladesh",
    "BEL": "Belgium",
    "BHR": "Bahrain",
    "BRA": "Brazil",
    "CAN": "Canada",
    "CHN": "China",
    "DEU": "Germany",
    "EGY": "Egypt",
    "FRA": "France",
    "GBR": "United Kingdom",
    "IND": "India",
    "IRN": "Iran",
    "IRQ": "Iraq",
    "ITA": "Italy",
    "JPN": "Japan",
    "JOR": "Jordan",
    "KWT": "Kuwait",
    "LBN": "Lebanon",
    "LKA": "Sri Lanka",
    "MAR": "Morocco",
    "MYS": "Malaysia",
    "NPL": "Nepal",
    "OMN": "Oman",
    "PAK": "Pakistan",
    "PHL": "Philippines",
    "QAT": "Qatar",
    "SAU": "Saudi Arabia",
    "SDN": "Sudan",
    "SYR": "Syria",
    "THA": "Thailand",
    "TUR": "Turkey",
    "USA": "United States",
    "YEM": "Yemen",
  };
  List<TypeItemModel> documentTypes = [
    TypeItemModel(
      value: 'Emirates ID',
      label: AppUtils.languageTranslate('emiratesId'),
    ),
    TypeItemModel(
      value: 'Photo ID',
      label: AppUtils.languageTranslate('photoId'),
    ),
    TypeItemModel(
      value: 'Travel Document',
      label: AppUtils.languageTranslate('travelDocument'),
    ),
  ];

  static Locale arabicLocale = const Locale('ar', 'AE');
  static Locale englishLocale = const Locale('en', 'US');
  static Locale nepaliLocale = const Locale('ne', 'NP');

  static final List<Locale> supportedLocales = [
    englishLocale,
    arabicLocale,
    nepaliLocale
  ];
}
