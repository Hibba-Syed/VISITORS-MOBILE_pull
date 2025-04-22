import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/check_in_screen.dart';
import 'package:visitors/view/Common%20Screens/check%20outs/check_outs_screen.dart';
import 'package:visitors/view/Common%20Screens/directory/directory_screen.dart';
import 'package:visitors/view/Common%20Screens/messages/message_screen.dart';
import 'package:visitors/view/Common%20Screens/services/all_services_screen.dart' show AllServicesScreen;
import 'package:visitors/view/Common%20Screens/work%20order/work_order_rfp_screen.dart' show WorkOrderRfpScreen;
import 'package:visitors/view/Tablet%20Screens/dashboard/tablet_dashboard_screen.dart';

import '../../resource/constants/app_colors.dart';
import '../../resource/constants/app_constants.dart';
import '../../resource/constants/images.dart';
import '../../resource/styles/styles.dart';
import '../Mobile Screens/dashboard/mobile_dashboard_screen.dart';
import '../widgets/app_bar/appbar_widget.dart';
import '../widgets/button/custom_button.dart';
import '../widgets/drawer/drawer_list_tile.dart';
import '../widgets/responsive_layout_Widget.dart';
import 'Components/drawer_item_model.dart';

class DeviceDeciderScreen extends StatelessWidget {
  DeviceDeciderScreen({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<DrawerItemModel> _drawerItems = [
    DrawerItemModel(
      index: AppConstants.dashboardIndex,
      title: 'Dashboard',
      iconPath: AppImages.dashboard,
      onTap: () {},
    ),
    DrawerItemModel(
      index: AppConstants.checkInsIndex,
      title: 'Check-Ins',
      iconPath: AppImages.menuCheckin,
      onTap: () {},
    ),
    DrawerItemModel(
      index: AppConstants.eServicesIndex,
      title: 'E-Services',
      iconPath: AppImages.menuEservices,
      onTap: () {},
    ),
    DrawerItemModel(
      index: AppConstants.workOrderRfpIndex,
      title: 'Work Order / RFPs',
      iconPath: AppImages.menuRFPs,
      onTap: () {},
    ),
    DrawerItemModel(
      index: AppConstants.messagesIndex,
      title: 'Messages',
      iconPath: AppImages.menuMsg,
      onTap: () {},
    ),
    DrawerItemModel(
      index: AppConstants.checkOutsIndex,
      title: 'Check-Outs',
      iconPath: AppImages.menuCheckout,
      onTap: () {},
    ),
    DrawerItemModel(
      index: AppConstants.directoryIndex,
      title: 'Directory',
      iconPath: AppImages.directory,
      onTap: () {},
    ),
    DrawerItemModel(
      index: AppConstants.logoutIndex,
      title: 'Logout',
      iconPath: AppImages.logout,
      onTap: ()  {
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DeviceDeciderCubit, DeviceDeciderState>(
      builder: (context, state) {
       return WillPopScope(
          onWillPop: () async {
          //  print('PopScope triggered!');
            if (state.selectedIndex == AppConstants.dashboardIndex) {
              bool shouldExit = await showDialog<bool>(
                barrierDismissible: false,
                context: context,
                builder: (ctx) {
                  return  AlertDialog(
                    content: SizedBox(
                      width: MediaQuery.of(context)
                          .size
                          .width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgPicture.asset(
                            AppImages.logout,
                            height: 35,
                            width: 35,
                            colorFilter: const ColorFilter.mode(
                              AppColors.primary,
                              BlendMode.srcIn,
                            ),
                          ),
                          const Gap(16.0),
                          const Text(
                            'Are you sure you want to logout?',
                            style: AppTextStyles
                                .style16DarkGrey600,
                          ),
                          const Gap(20.0),
                          Row(
                            children: [
                              Flexible(
                                child: CustomButton(
                                  text: 'Cancel',
                                  onPressed: () {
                                    Navigator.pop(
                                        context);
                                  },
                                ),
                              ),
                              const Gap(10.0),
                              Flexible(
                                child: CustomButton(
                                  text: 'Logout',
                                  invert: true,
                                  onPressed: () {
                                    Navigator.pop(
                                        context);
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ) ?? false;
              if (shouldExit) {
                Navigator.pop(context);
              }
              return false;
            } else {
              context.read<DeviceDeciderCubit>().onBackButtonPressed();
              return false;
            }
          },
          child: Scaffold(
            key: _scaffoldKey,
            appBar: AppBarWidget(
              leading: IconButton(
                onPressed: () {
                  _scaffoldKey.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: AppColors.black,
                ),
              ),
              title: _getTitle(state),
            ),
            drawer: Drawer(
              backgroundColor: AppColors.white,
              child: ListView(
                children: [
                  DrawerHeader(
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: AssetImage(
                          AppImages.background,
                        ),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          AppImages.appLogo,
                          width: 200,
                          height: 80,
                        ),
                        const Gap(10.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(6.0),
                          ),
                          child: const Text(
                            'VMS APPLICATION',
                            style: AppTextStyles.style10White500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20.0,
                      vertical: 16.0,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          itemCount: (_drawerItems.length),
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DrawerItemModel item = _drawerItems[index];
                            return DrawerListTile(
                                title: item.title,
                                iconPath: item.iconPath,
                                onTap: () {
                                  if (item.index == AppConstants.logoutIndex) {
                                    showDialog(
                                      barrierDismissible: false,
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          content: SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                SvgPicture.asset(
                                                  AppImages.logout,
                                                  height: 35,
                                                  width: 35,
                                                  colorFilter: const ColorFilter.mode(
                                                    AppColors.primary,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                                const Gap(16.0),
                                                const Text(
                                                  'Are you sure you want to logout?',
                                                  style: AppTextStyles
                                                      .style16DarkGrey600,
                                                ),
                                                const Gap(20.0),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: CustomButton(
                                                        text: 'Cancel',
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                    const Gap(10.0),
                                                    Flexible(
                                                      child: CustomButton(
                                                        text: 'Logout',
                                                        invert: true,
                                                        onPressed: () {
                                                           Navigator.pop(context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  } else {
                                    context
                                        .read<DeviceDeciderCubit>()
                                        .onChangeSelectedIndex(
                                        context, item.index);
                                    Navigator.of(context).pop();
                                  }
                                },
                                isSelected: item.index == state.selectedIndex);

                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            body: ResponsiveLayoutWidget(
              mobile: _getMobileScreen(state),
              tablet: _getTabletScreen(state),
            ),
          ),
        );
      },
    );
  }

  String _getTitle(DeviceDeciderState state) {
    if (state.selectedIndex == AppConstants.dashboardIndex) {
      return 'Dashboard';
    } else if (state.selectedIndex == AppConstants.checkInsIndex) {
      return 'Check-Ins';
    } else if (state.selectedIndex == AppConstants.eServicesIndex) {
      return 'All E-Services Requests';
    } else if (state.selectedIndex == AppConstants.workOrderRfpIndex) {
      return 'Work Order / RFPs';
    } else if (state.selectedIndex == AppConstants.messagesIndex) {
      return 'Messages';
    } else if (state.selectedIndex == AppConstants.checkOutsIndex) {
      return 'Check-Outs';
    } else if (state.selectedIndex == AppConstants.directoryIndex) {
      return 'Directory';
    }
    return '';
  }

  Widget _getMobileScreen(DeviceDeciderState state) {
    if (state.selectedIndex == AppConstants.dashboardIndex) {
      return  const MobileDashboardScreen();
    }
    else if (state.selectedIndex == AppConstants.checkInsIndex) {
      return const CheckInsScreen();
    }
    else if (state.selectedIndex == AppConstants.eServicesIndex) {
      return const AllServicesScreen();
    }
    else if (state.selectedIndex == AppConstants.workOrderRfpIndex) {
      return const WorkOrderRfpScreen();
    }
    else if (state.selectedIndex == AppConstants.messagesIndex) {
      return const MessageScreen();
    }else if (state.selectedIndex == AppConstants.checkOutsIndex) {
      return const CheckOutsScreen() ;
    }
    else if (state.selectedIndex == AppConstants.directoryIndex) {
      return const DirectoryScreen();
    }
    return const SizedBox.shrink();
  }

  Widget _getTabletScreen(DeviceDeciderState state) {
    // print('_getTabletScreen${state.selectedIndex}');
    if (state.selectedIndex == AppConstants.dashboardIndex) {
      return  const TabletDashboardScreen();
    }
    else if (state.selectedIndex == AppConstants.checkInsIndex) {
      return const CheckInsScreen();
     }
    else if (state.selectedIndex == AppConstants.eServicesIndex) {
      return const AllServicesScreen();
    }
    else if (state.selectedIndex == AppConstants.workOrderRfpIndex) {
      return const WorkOrderRfpScreen();
    }
    else if (state.selectedIndex == AppConstants.messagesIndex) {
      return const MessageScreen();
    }
    else if (state.selectedIndex == AppConstants.checkOutsIndex) {
      return const CheckOutsScreen() ;
    }
    else if (state.selectedIndex == AppConstants.directoryIndex) {
      return const DirectoryScreen();
    }
    return const SizedBox.shrink();
  }
}
