import 'package:flutter/material.dart';

import '../../resource/constants/app_colors.dart';
import '../../resource/styles/styles.dart';
import '../Mobile Screens/dashboard/mobile_dashboard_screen.dart';
import '../Tablet Screens/Dashbord/tablet_dashboard_screen.dart';
import '../widgets/drawer.dart';
import '../widgets/responsive_layout_Widget.dart';
class DeviceDeciderScreen extends StatelessWidget {
  const DeviceDeciderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
          centerTitle: true,
          title: const Text('Dashboard', style: AppTextStyles.style20Black500)),
      drawer:  const Drawer(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          child: CustomDrawer()
      ),
      body: const ResponsiveLayoutWidget(
        mobile: MobileDashboardScreen(),
        tablet: TabletDashboardScreen(),
      )
    );
  }

}