
import 'package:flutter/material.dart';

import '../../view/Screen/device_decider_screen.dart';
import 'app_routes.dart';



class AppPages {
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.dashboard,
      page: const DeviceDeciderScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => AuthCubit(),
      // ),
    ),
    PageEntity(
      route: AppRoutes.dashboard,
      page: const DeviceDeciderScreen(),
      // bloc:
      // BlocProvider(
      //   create: (context) => AuthCubit(),
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
        builder: (context) => const DeviceDeciderScreen(), settings: settings);
  }
}

class PageEntity {
  final String route;
  final Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}