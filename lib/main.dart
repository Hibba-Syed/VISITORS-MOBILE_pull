import 'package:flutter/material.dart';
import 'package:visitors/utils/preference_utils.dart';
import 'package:visitors/view/screens/iskaan_visitors_mobile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initPreferences();
  runApp(
    IskaanVisitorsMobile(),
  );
}
