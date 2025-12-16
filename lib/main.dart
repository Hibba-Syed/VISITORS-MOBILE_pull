import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/preference_utils.dart';
import 'package:visitors/iskaan_visitors_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initPreferences();

  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: AppConstants.supportedLocales,
      path: 'assets/translations',
      fallbackLocale: AppConstants.englishLocale,
      child: IskaanVisitorsMobile(),
    ),
  );
}
