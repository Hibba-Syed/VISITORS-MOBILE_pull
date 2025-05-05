import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/material.dart';
import 'package:visitors/utils/preference_utils.dart';
import 'package:visitors/view/Common%20Screens/iskaan_visitors_mobile.dart' show IskaanVisitorsMobile;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPreferences();
  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const  IskaanVisitorsMobile(), // Wrap your app
    ),
  );
}
