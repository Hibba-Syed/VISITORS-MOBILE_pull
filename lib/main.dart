import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitors/eid_card_scanner.dart';
import 'package:visitors/firebase_ml_vision_view.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/view/Screen/device_decider_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  // Widget build(BuildContext context) {
  //   return MaterialApp(
  //     title: 'Iskaan Visitors',
  //     theme: ThemeData(
  //       colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
  //       useMaterial3: true,
  //     ),
  //     home: const EmiratesIDScanner(),
  //   );
  // }
  Widget build(BuildContext context) {
    // MultiBlocProvider(
    //     providers: [...AppPages.getAllBlocProviders(context)],),
    return MaterialApp(
      title: 'Visitors Mobile',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: AppColors.whiteBack,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.whiteBack,
          surface: AppColors.whiteBack,
          primary: AppColors.primary,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        iconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
      ),
      home: const DeviceDeciderScreen(),
      debugShowCheckedModeBanner: false,

    );
  }
}
