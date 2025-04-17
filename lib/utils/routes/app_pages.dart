
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/detail/check_in_details_screen.dart';
import 'package:visitors/view/Common%20Screens/device_decider_screen.dart';
import 'package:visitors/view/Common%20Screens/services/detail/service_details_screen.dart';
import 'package:visitors/view/Common%20Screens/visitor%20passes/serviceable_check_ins_screen.dart';
import 'package:visitors/view/Common%20Screens/visitor%20passes/visitor_passes_screen.dart';
import 'package:visitors/view/Common%20Screens/work%20order/detail/work_order_job_details_screen.dart';
import 'package:visitors/view/Common%20Screens/work%20order/work_order_rfp_screen.dart' show WorkOrderRfpScreen;
import 'package:visitors/view/Mobile%20Screens/dashboard/mobile_dashboard_screen.dart';
import 'package:visitors/view/Mobile%20Screens/guest%20check%20in/mobile_guest_check_in_screen.dart';
import 'package:visitors/view/Tablet%20Screens/dashboard/tablet_dashboard_screen.dart';
import 'package:visitors/view/Tablet%20Screens/guest_check_in/tablet_guest_check_in_screen.dart';

import '../../view/Common Screens/scanner/document_scanner_screen.dart';
import 'app_routes.dart';



class AppPages {
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.dashboard,
      page:  DeviceDeciderScreen(),
      bloc: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DeviceDeciderCubit(),
          ),
          BlocProvider(
            create: (context) => CheckInsCubit(),
          ),
        ],
        child: const SizedBox.shrink(),
      ),
    ),
    PageEntity(
      route: AppRoutes.workOrderJobDetailsScreen,
      page: const WorkOrderJobDetailsScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.servicesDetailsScreen,
      page: const ServiceDetailsScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.mobileGuestCheckInScreen,
      page: const MobileGuestCheckInScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.checkInDetailsScreen,
      page: const CheckInDetailsScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.visitorPassesScreen,
      page: const VisitorPassesScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.serviceableCheckInsScreen,
      page: const ServiceableCheckInsScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.tabletGuestCheckInScreen,
      page: const TabletGuestCheckInScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.mobileDashboardScreen,
      page: const MobileDashboardScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.tabletDashboardScreen,
      page: const TabletDashboardScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.documentScannerScreen,
      page: const DocumentScannerScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
  ];

  static List<dynamic> getAllBlocProviders(BuildContext context) {
    List<dynamic> blocProviders = [];
    for (var element in routes) {
      if (element.bloc != null) {
        blocProviders.add(element.bloc);
      }
    }
    return blocProviders;
  }

  static MaterialPageRoute generateRouteSettings(RouteSettings settings) {
    if (settings.name != null) {
      var result = routes.where((element) => element.route == settings.name);
      if (result.isNotEmpty) {
        return MaterialPageRoute(
            builder: (context) => result.first.page, settings: settings);
      }
    }
    return MaterialPageRoute(
        builder: (context) =>  DeviceDeciderScreen(), settings: settings);
  }
}

class PageEntity {
  final String route;
  final Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}