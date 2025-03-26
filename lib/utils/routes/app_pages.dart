
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/check_in_screen.dart';
import 'package:visitors/view/Common%20Screens/device_decider_screen.dart';
import 'package:visitors/view/Common%20Screens/services/all_services_screen.dart';
import 'package:visitors/view/Common%20Screens/services/details/service_details.dart';
import 'package:visitors/view/Common%20Screens/work%20order/details/work_order_job_details_screen.dart';
import 'package:visitors/view/Common%20Screens/work%20order/work_order_rfp_screen.dart' show WorkOrderRfpScreen;
import 'package:visitors/view/Mobile%20Screens/guest%20check%20in/guest_check_in_screen.dart';

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
      page: const ServiceDetails(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.guestCheckInScreen,
      page: const GuestCheckInScreen(),
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