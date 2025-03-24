import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/routes/app_pages.dart';
import 'package:visitors/view/Common%20Screens/device_decider_screen.dart' show DeviceDeciderScreen;

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
    return MultiBlocProvider(
        providers: [...AppPages.getAllBlocProviders(context)],
    child:  MaterialApp(
      title: 'Visitors Mobile',
      theme: ThemeData(
        textTheme: GoogleFonts.interTextTheme(),
        scaffoldBackgroundColor: AppColors.backgroundColor,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.white,
          surface: AppColors.white,
          primary: AppColors.primary,
        ),
        useMaterial3: true,
        fontFamily: 'Inter',
        iconTheme: const IconThemeData(
          color: AppColors.primary,
        ),
      ),
      onGenerateRoute: AppPages.generateRouteSettings,
      home:  DeviceDeciderScreen(),
      debugShowCheckedModeBanner: false,
    )
    );
  }
}
