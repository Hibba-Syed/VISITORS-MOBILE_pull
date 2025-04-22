import 'package:device_preview/device_preview.dart' show DevicePreview;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show MultiBlocProvider;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/routes/app_pages.dart';
import 'package:visitors/view/Common%20Screens/device_decider_screen.dart';
class IskaanVisitorsMobile extends StatefulWidget {
  const IskaanVisitorsMobile({super.key});

  @override
  State<IskaanVisitorsMobile> createState() => _IskaanVisitorsMobileState();
}

class _IskaanVisitorsMobileState extends State<IskaanVisitorsMobile> {
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
        child:  GestureDetector(
          onTap: (){
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(
            title: 'Visitors Mobile',
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
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
            debugShowCheckedModeBanner: false,
          ),
        )
    );
  }
}
