import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show MultiBlocProvider;
import 'package:google_fonts/google_fonts.dart' show GoogleFonts;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/utils/routes/app_pages.dart';

import 'resource/globals.dart';
import 'utils/routes/app_routes.dart';

class IskaanVisitorsMobile extends StatefulWidget {
  const IskaanVisitorsMobile({super.key});

  @override
  State<IskaanVisitorsMobile> createState() => _IskaanVisitorsMobileState();
}

class _IskaanVisitorsMobileState extends State<IskaanVisitorsMobile> {
  @override
  Widget build(BuildContext context) {
    Globals.setContext(context);
    return MultiBlocProvider(
        providers: [...AppPages.getAllBlocProviders(context)],
        child: GestureDetector(
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: MaterialApp(
            title: AppUtils.languageTranslate('visitorsMobile'),
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            // locale: DevicePreview.locale(context),
            // builder: DevicePreview.appBuilder,
            theme: ThemeData(
              textTheme: GoogleFonts.interTextTheme(),
              scaffoldBackgroundColor: AppColors.backgroundColor,
              colorScheme: ColorScheme.fromSeed(
                seedColor: AppColors.white,
                surface: AppColors.white,
                primary: AppColors.primary,
              ),
              useMaterial3: true,
              fontFamily: GoogleFonts.inter().fontFamily,
              iconTheme: const IconThemeData(
                color: AppColors.primary,
              ),
            ),

            onGenerateRoute: AppPages.generateRouteSettings,
            initialRoute: AppRoutes.splash,
            debugShowCheckedModeBanner: false,
          ),
        ));
  }
}
