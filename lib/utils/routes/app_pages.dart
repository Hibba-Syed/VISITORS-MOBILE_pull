
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/dashboard/dashboard_cubit.dart';
import 'package:visitors/bloc/main_dashboard/main_dashboard_cubit.dart';
import 'package:visitors/view/screens/guest_check_in/guest_check_in_screen.dart';
import '../../bloc/auth/auth_cubit.dart';
import '../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../bloc/check_out/check_out_cubit.dart';
import '../../bloc/directory/directory_cubit.dart';
import '../../bloc/e_service/details/service_details_cubit.dart';
import '../../bloc/e_service/service_cubit.dart';
import '../../bloc/guest_check_in/guest_check_in_cubit.dart';
import '../../bloc/message/message_cubit.dart';
import '../../bloc/visitor_passes/visitor_pass_cubit.dart';
import '../../bloc/work_order/details/work_order_details_cubit.dart';
import '../../bloc/work_order/work_order_cubit.dart';
import '../../view/screens/auth/biometric_auth_screen.dart';
import '../../view/screens/auth/loading_screen.dart';
import '../../view/screens/auth/login_screen.dart';
import '../../view/screens/check_ins/detail/check_in_details_screen.dart';
import '../../view/screens/dashboard/dashboard_screen.dart';
import '../../view/screens/main_dashboard_screen.dart';
import '../../view/screens/services/detail/fit_out_service_details_screen.dart';
import '../../view/screens/splash_screen.dart';
import '../../view/screens/services/serviceable_check_ins_screen.dart';
import '../../view/screens/visitor passes/visitor_passes_screen.dart';
import '../../view/screens/work order/detail/work_order_job_details_screen.dart';
import '../../view/screens/work order/job_check_ins_screen.dart';
import '../../view/screens/work order/work_order_rfp_screen.dart';
import 'app_routes.dart';

class AppPages {
  static List<PageEntity> routes = [
    PageEntity(
      route: AppRoutes.splash,
      page: const SplashScreen(),
    ),
    PageEntity(
      route: AppRoutes.login,
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
      route: AppRoutes.loading,
      page: const LoadingScreen(),
    ),
    PageEntity(
      route: AppRoutes.mainDashboard,
      page:  MainDashboardScreen(),
      bloc: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => MainDashboardCubit(),
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
          ), BlocProvider(
            create: (context) => GuestCheckInCubit(),
          ),
        ],
        child: const SizedBox.shrink(),
      ),
    ),
    PageEntity(
      route: AppRoutes.workOrderJobDetails,
      page: const WorkOrderJobDetailsScreen(),
      bloc: BlocProvider(
          create: (context) => WorkOrderDetailsCubit(),
      )
    ),
    PageEntity(
      route: AppRoutes.servicesDetails,
      page:  FitOutServiceDetailsScreen(),
        bloc: BlocProvider(
          create: (context) => ServiceDetailsCubit(),
        )
    ),
    PageEntity(
      route: AppRoutes.checkInDetails,
      page:  CheckInDetailsScreen(),
      bloc: BlocProvider(
        create: (context) => CheckInsDetailsCubit(),
      ),
    ),
    PageEntity(
      route: AppRoutes.workOrder,
      page: const WorkOrderRfpScreen(),
      bloc: BlocProvider(
        create: (context) => WorkOrderCubit(),
      ),
    ),
    PageEntity(
      route: AppRoutes.visitorPasses,
      page: const VisitorPassesScreen(),
      bloc: BlocProvider(
        create: (context) => VisitorPassCubit(),
      ),

    ),
    PageEntity(
      route: AppRoutes.serviceableCheckIns,
      page: const ServiceableCheckInsScreen(),
    ),
    PageEntity(
      route: AppRoutes.guestCheckIn,
      page: const GuestCheckInScreen(),
    ),
    PageEntity(
      route: AppRoutes.dashboard,
      page:  DashboardScreen(),
    ),
    PageEntity(
      route: AppRoutes.jobCheckIns,
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