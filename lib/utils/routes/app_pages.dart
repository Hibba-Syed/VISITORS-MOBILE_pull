
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitors/view/Mobile%20Screens/work%20order/work_order_rfp_screen.dart';

import '../../bloc/main_dashboard/main_dashboard_cubit.dart';
import '../../view/Mobile Screens/check ins/check_in_screen.dart';
import '../../view/Mobile Screens/services/all_services_screen.dart';
import '../../view/Screen/device_decider_screen.dart';
import 'app_routes.dart';



class AppPages {
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.dashboard,
      page:  DeviceDeciderScreen(),
      bloc: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainDashboardCubit(),
          ),
        ],
        child: const SizedBox.shrink(),
      ),
    ),
    PageEntity(
      route: AppRoutes.workOrderRfpScreen,
      page: const WorkOrderRfpScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.allServicesScreen,
      page: const AllServicesScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => ,
      // ),
    ),
    PageEntity(
      route: AppRoutes.checkInScreen,
      page: const CheckInsScreen(),
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