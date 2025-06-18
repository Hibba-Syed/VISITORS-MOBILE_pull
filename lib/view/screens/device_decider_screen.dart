import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/auth/auth_cubit.dart';
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/bloc/e_service/service_cubit.dart';
import 'package:visitors/bloc/message/message_cubit.dart';
import 'package:visitors/bloc/work_order/work_order_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/screens/services/all_services_screen.dart';
import 'package:visitors/view/screens/work%20order/work_order_rfp_screen.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/drawer/drawer_list_tile.dart';
import 'package:visitors/view/widgets/responsive_layout_widget.dart';

import '../../bloc/check_out/check_out_cubit.dart';
import '../../utils/app_utils.dart';
import 'check_ins/check_in_screen.dart';
import 'check_outs/check_outs_screen.dart';
import 'components/drawer_item_model.dart';
import 'dashboard/dashboard_screen.dart';
import 'directory/directory_screen.dart';
import 'messages/message_screen.dart';

class DeviceDeciderScreen extends StatelessWidget {
  DeviceDeciderScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<DeviceDeciderCubit, DeviceDeciderState, int>(
      selector: (state) => state.selectedIndex,
      builder: (context, selectedIndex) {
        return WillPopScope(
          onWillPop: () async {
            if (selectedIndex == AppConstants.dashboardIndex) {
              return await _showLogoutDialog(context);
            } else {
              context.read<DeviceDeciderCubit>().onBackButtonPressed();
              return false;
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBarWidget(
              leading: IconButton(
                icon: const Icon(Icons.menu, color: AppColors.black),
                onPressed: () => _scaffoldKey.currentState?.openDrawer(),
              ),
              title: _getTitle(selectedIndex),
            ),
            drawer: _buildDrawer(context, selectedIndex),
            body: ResponsiveLayoutWidget(
              mobile: _getMobileScreen(selectedIndex),
              tablet: _getTabletScreen(selectedIndex),
            ),
          ),
        );
      },
    );
  }

  Future<bool> _showLogoutDialog(BuildContext context) async {
    return await showDialog<bool>(
          barrierDismissible: false,
          context: context,
          builder: (ctx) => AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(AppImages.logout,
                    height: 35,
                    width: 35,
                    colorFilter: const ColorFilter.mode(
                        AppColors.primary, BlendMode.srcIn)),
                const Gap(16),
                const Text('Are you sure you want to logout?',
                    style: AppTextStyles.style16DarkGrey600),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            text: 'Cancel',
                            onPressed: () => Navigator.pop(context, false))),
                    const Gap(10),
                    Expanded(
                        child: CustomButton(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            text: 'Logout',
                            invert: true,
                            onPressed: () {
                              Navigator.pop(context, true);
                              context.read<AuthCubit>().logout(context);
                            })),
                  ],
                )
              ],
            ),
          ),
        ) ??
        false;
  }

  Widget _buildDrawer(BuildContext context, int selectedIndex) {
    final items = drawerItems;
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.7,
      backgroundColor: AppColors.white,
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.drawerBackground),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AppImages.appLogo, height: 80),
                const Gap(10),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text('VMS APPLICATION',
                      style: AppTextStyles.style13white500),
                )
              ],
            ),
          ),
          ...items.map((item) => DrawerListTile(
                title: item.title,
                iconPath: item.iconPath,
                isSelected: item.index == selectedIndex,
                onTap: () {
                  Navigator.of(context).pop();
                  if (item.index == AppConstants.logoutIndex) {
                    _showLogoutDialog(context);
                  } else {
                    context
                        .read<DeviceDeciderCubit>()
                        .onChangeSelectedIndex(item.index);

                    // Optionally trigger specific cubits
                    switch (item.index) {
                      case AppConstants.checkInsIndex:
                        context.read<CheckInsCubit>().resetFilterData();
                        context.read<CheckInsCubit>().getCheckIns();
                        break;
                      case AppConstants.eServicesIndex:
                        context.read<ServiceCubit>().resetFilterData();
                        context.read<ServiceCubit>().getServices();
                        break;
                      case AppConstants.workOrderRfpIndex:
                        context.read<WorkOrderCubit>().resetFilterData();
                        context.read<WorkOrderCubit>().getWorkOrder();
                        break;
                      case AppConstants.messagesIndex:
                        context.read<MessageCubit>().getMessages();
                        break;
                      case AppConstants.checkOutsIndex:
                        context.read<CheckOutCubit>().onChangeDateRange(
                            AppUtils.getDateRangeStringFromLabel(
                                'Last 30 Days'));
                        context.read<CheckOutCubit>().getCheckOut();
                        // print('filter checkout ${AppUtils.getDateRangeStringFromLabel(
                        //         'Last 30 Days')}');
                        break;
                    }
                  }
                },
              ))
        ],
      ),
    );
  }

  String _getTitle(int index) {
    switch (index) {
      case AppConstants.dashboardIndex:
        return 'Dashboard';
      case AppConstants.checkInsIndex:
        return 'Check-Ins';
      case AppConstants.eServicesIndex:
        return 'All E-Services Requests';
      case AppConstants.workOrderRfpIndex:
        return 'Work Order / RFPs';
      case AppConstants.messagesIndex:
        return 'Messages';
      case AppConstants.checkOutsIndex:
        return 'Check-Outs';
      case AppConstants.directoryIndex:
        return 'Directory';
      default:
        return '';
    }
  }

  Widget _getMobileScreen(int index) {
    switch (index) {
      case AppConstants.dashboardIndex:
        return DashboardScreen();
      case AppConstants.checkInsIndex:
        return const CheckInsScreen();
      case AppConstants.eServicesIndex:
        return const AllServicesScreen();
      case AppConstants.workOrderRfpIndex:
        return const WorkOrderRfpScreen();
      case AppConstants.messagesIndex:
        return const MessageScreen();
      case AppConstants.checkOutsIndex:
        return const CheckOutsScreen();
      case AppConstants.directoryIndex:
        return const DirectoryScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  Widget _getTabletScreen(int index) {
    switch (index) {
      case AppConstants.dashboardIndex:
        return DashboardScreen();
      case AppConstants.checkInsIndex:
        return const CheckInsScreen();
      case AppConstants.eServicesIndex:
        return const AllServicesScreen();
      case AppConstants.workOrderRfpIndex:
        return const WorkOrderRfpScreen();
      case AppConstants.messagesIndex:
        return const MessageScreen();
      case AppConstants.checkOutsIndex:
        return const CheckOutsScreen();
      case AppConstants.directoryIndex:
        return const DirectoryScreen();
      default:
        return const SizedBox.shrink();
    }
  }

  static final List<DrawerItemModel> drawerItems = [
    DrawerItemModel(
        index: AppConstants.dashboardIndex,
        title: 'Dashboard',
        iconPath: AppImages.dashboard),
    DrawerItemModel(
        index: AppConstants.checkInsIndex,
        title: 'Check-Ins',
        iconPath: AppImages.menuCheckIn),
    DrawerItemModel(
        index: AppConstants.eServicesIndex,
        title: 'E-Services',
        iconPath: AppImages.menuEservices),
    DrawerItemModel(
        index: AppConstants.workOrderRfpIndex,
        title: 'Work Order / RFPs',
        iconPath: AppImages.menuRFPs),
    DrawerItemModel(
        index: AppConstants.messagesIndex,
        title: 'Messages',
        iconPath: AppImages.menuMsg),
    DrawerItemModel(
        index: AppConstants.checkOutsIndex,
        title: 'Check-Outs',
        iconPath: AppImages.menuCheckout),
    DrawerItemModel(
        index: AppConstants.directoryIndex,
        title: 'Directory',
        iconPath: AppImages.directory),
    DrawerItemModel(
        index: AppConstants.logoutIndex,
        title: 'Logout',
        iconPath: AppImages.logout),
  ];
}
