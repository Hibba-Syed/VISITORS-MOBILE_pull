import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:visitors/utils/preference_utils.dart';
import 'package:visitors/view/screens/iskaan_visitors_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initPreferences();

  Locale arabicLocal = const Locale('ar', 'AE');
  Locale englishLocal = const Locale('en', 'US');

  runApp(
    EasyLocalization(
      saveLocale: true,
      supportedLocales: [
        englishLocal,
        arabicLocal
      ],
      path: 'assets/translations',
      fallbackLocale: englishLocal,
      child:  IskaanVisitorsMobile(),
    ),
  );
}
