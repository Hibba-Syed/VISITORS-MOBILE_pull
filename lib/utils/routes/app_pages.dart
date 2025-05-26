
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/dashboard/dashboard_cubit.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/view/Common%20Screens/auth/biometric_auth_screen.dart';
import 'package:visitors/view/Common%20Screens/auth/login_screen.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/detail/check_in_details_screen.dart';
import 'package:visitors/view/Common%20Screens/device_decider_screen.dart';
import 'package:visitors/view/Common%20Screens/services/detail/service_details_screen.dart';
import 'package:visitors/view/Common%20Screens/visitor%20passes/serviceable_check_ins_screen.dart';
import 'package:visitors/view/Common%20Screens/visitor%20passes/visitor_passes_screen.dart';
import 'package:visitors/view/Common%20Screens/work%20order/detail/work_order_job_details_screen.dart';
import 'package:visitors/view/Common%20Screens/work%20order/job_check_ins_screen.dart';
import 'package:visitors/view/Mobile%20Screens/dashboard/mobile_dashboard_screen.dart';
import 'package:visitors/view/Mobile%20Screens/guest%20check%20in/mobile_guest_check_in_screen.dart';
import 'package:visitors/view/Tablet%20Screens/dashboard/tablet_dashboard_screen.dart';
import 'package:visitors/view/Tablet%20Screens/guest_check_in/tablet_guest_check_in_screen.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../bloc/check_out/check_out_cubit.dart';
import '../../bloc/directory/directory_cubit.dart';
import '../../bloc/e_service/details/service_details_cubit.dart';
import '../../bloc/e_service/service_cubit.dart';
import '../../bloc/message/message_cubit.dart';
import '../../bloc/visitor_passes/visitor_pass_cubit.dart';
import '../../bloc/work_order/details/work_order_details_cubit.dart';
import '../../bloc/work_order/work_order_cubit.dart';
import '../../view/Common Screens/auth/loading_screen.dart';
import '../../view/Common Screens/splash_screen.dart';
import '../../view/Common Screens/work order/work_order_rfp_screen.dart';
import 'app_routes.dart';

class AppPages {
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.splash,
      page: const SplashScreen(),
    ),
    PageEntity(
      route: AppRoutes.loginScreen,
      page: const LoginScreen(),
      bloc: BlocProvider(
        create: (context) => AuthCubit(),
      ),
    ),
    PageEntity(
      route: AppRoutes.biometricAuth,
      page: const BiometricAuthScreen(),
    ),
    PageEntity(
      route: AppRoutes.loadingScreen,
      page: const LoadingScreen(),
    ),
    PageEntity(
      route: AppRoutes.deviceDeciderScreen,
      page:  DeviceDeciderScreen(),
      bloc: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DeviceDeciderCubit(),
          ),
          BlocProvider(
            create: (context) => DashboardCubit(),
          ),
          BlocProvider(
            create: (context) => CheckInsCubit(),
          ),
          BlocProvider(
            create: (context) => CheckOutCubit(),
          ),
          BlocProvider(
            create: (context) => MessageCubit(),
          ),
          BlocProvider(
            create: (context) => ServiceCubit(),
          ),
          BlocProvider(
            create: (context) => DirectoryCubit(),
          ),
        ],
        child: const SizedBox.shrink(),
      ),
    ),
    PageEntity(
      route: AppRoutes.workOrderJobDetailsScreen,
      page: const WorkOrderJobDetailsScreen(),
      bloc: BlocProvider(
          create: (context) => WorkOrderDetailsCubit(),
      )
    ),
    PageEntity(
      route: AppRoutes.servicesDetailsScreen,
      page: const ServiceDetailsScreen(),
        bloc: BlocProvider(
          create: (context) => ServiceDetailsCubit(),
        )
    ),
    PageEntity(
      route: AppRoutes.mobileGuestCheckInScreen,
      page: const MobileGuestCheckInScreen(),
    ),
    PageEntity(
      route: AppRoutes.checkInDetailsScreen,
      page:  CheckInDetailsScreen(),
      bloc: BlocProvider(
        create: (context) => CheckInsDetailsCubit(),
      ),
    ),
    PageEntity(
      route: AppRoutes.workOrderScreen,
      page: const WorkOrderRfpScreen(),
      bloc: BlocProvider(
        create: (context) => WorkOrderCubit(),
      ),
    ),
    PageEntity(
      route: AppRoutes.visitorPassesScreen,
      page: const VisitorPassesScreen(),
      bloc: BlocProvider(
        create: (context) => VisitorPassCubit(),
      ),

    ),
    PageEntity(
      route: AppRoutes.serviceableCheckInsScreen,
      page: const ServiceableCheckInsScreen(),
    ),
    PageEntity(
      route: AppRoutes.tabletGuestCheckInScreen,
      page: const TabletGuestCheckInScreen(),
    ),
    PageEntity(
      route: AppRoutes.mobileDashboardScreen,
      page:  MobileDashboardScreen(),
    ),
    PageEntity(
      route: AppRoutes.tabletDashboardScreen,
      page: const TabletDashboardScreen(),
    ),
    PageEntity(
      route: AppRoutes.jobCheckInsScreen,
      page: const JobCheckInsScreen(),
    ),
    // PageEntity(
    //   route: AppRoutes.emiratesIDScanner,
    //   page: const EmiratesIDScanner(),
    // ),
    // PageEntity(
    //   route: AppRoutes.documentScannerScreen,
    //   page: const DocumentScannerScreen(),
    // ),
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
        builder: (context) =>  LoginScreen(), settings: settings);
  }
}

class PageEntity {
  final String route;
  final Widget page;
  dynamic bloc;

  PageEntity({required this.route, required this.page, this.bloc});
}