import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/Components/actions_item_model.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/Common%20Screens/services/components/services_card_widget.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_rfp_card_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/button/visitor_passes_button.dart';
import 'package:visitors/view/widgets/container_widgets/actions_container_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/styles/styles.dart';
import '../../widgets/container_widgets/check_out_container_widget.dart';

class MobileDashboardScreen extends StatelessWidget {
  const MobileDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<ActionsItemModel> actions = [
      ActionsItemModel(
        title: 'All Check-Ins',
        count: 10,
        iconPath: AppImages.checkIn,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.green,
        onTap: () {
          context
              .read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.checkInsIndex);
        },
      ),
      ActionsItemModel(
        title: 'Guests',
        count: 10,
        iconPath: AppImages.guests,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.yellow,
        onTap: () {
          context
              .read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.checkInsIndex);
        },
      ),
      ActionsItemModel(
        title: 'E-Services',
        count: 6,
        iconPath: AppImages.eServices,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.cyanBlue,
        onTap: () {
          context
              .read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.eServicesIndex);
        },
      ),
      ActionsItemModel(
        title: 'Work Order / RFPs',
        count: 2,
        iconPath: AppImages.rfps,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.blue,
        onTap: () {
          context
              .read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.workOrderRfpIndex);
        },
      ),
      ActionsItemModel(
        title: 'Guest Check-In',
        iconPath: AppImages.guestCheckIn,
        backgroundColor: AppColors.green,
        forGroundColor: AppColors.white,
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.mobileGuestCheckInScreen);
        },
      ),
      ActionsItemModel(
        title: 'Message',
        iconPath: AppImages.message,
        backgroundColor: AppColors.blue,
        forGroundColor: AppColors.white,
        onTap: () {
          context
              .read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.messagesIndex);
        },
      ),
    ];
    return
      PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic) async {
        if (didPop) return;
          return showDialog(
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
                        const Icon(
                          Icons.logout,
                          color: AppColors.primary,
                          size: 40,
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
            );
      },
      child:
      Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
              vertical: AppConstants.verticalPadding,
              horizontal: AppConstants.horizontalPadding),
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeadingWidget(
                        heading: 'Welcome',
                        style: AppTextStyles.style15DarkGrey600,
                      ),
                      HeadingWidget(heading: 'Apricot Tower (Gate 2)'),
                    ],
                  ),
                ],
              ),
              const Gap(10),
              GridView.builder(
                padding: const EdgeInsets.only(bottom: 10),
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 100),
                itemCount: actions.length,
                itemBuilder: (BuildContext context, int index) {
                  ActionsItemModel actionsItem = actions[index];
                  return ActionsContainerWidget(
                    title: actionsItem.title,
                    count: actionsItem.count,
                    backgroundColor: actionsItem.backgroundColor,
                    forGroundColor: actionsItem.forGroundColor,
                    iconPath: actionsItem.iconPath,
                    actionOnTap: actionsItem.onTap,
                  );
                },
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Text(
                        'Check-Ins',
                        style: AppTextStyles.style16Primary600,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      CustomButton(
                        buttonColor: AppColors.red,
                          text: 'Check-Outs',
                          height: 41,
                          borderRadius: 6,
                          image: AppImages.checkout,
                          onPressed: () {
                            context.read<DeviceDeciderCubit>()
                                    .onChangeSelectedIndex(
                                        context, AppConstants.checkOutsIndex);
                          }),
                      const Gap(10),
                      CustomButton(
                          buttonColor: AppColors.blue,
                          text: 'View All',
                          height: 41.5,
                          borderRadius: 6,
                          image: AppImages.view,
                          onPressed: () {
                            context.read<CheckInsCubit>().getCheckIns();
                            context
                                .read<DeviceDeciderCubit>()
                                .onChangeSelectedIndex(
                                context, AppConstants.checkInsIndex);
                          }),
                    ],
                  ),
                ],
              ),
              const Gap(10),
              ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CheckInCardWidget(
                    count: 5,
                    typeText: 'Rose-1024',
                    name: 'MUHAMMAD AHMED MOHAMMED ',
                    profileImageUrl:
                        "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                    type: 'Guest',
                    date: DateTimeUtil.getFormattedDateTime(
                        '2025-04-04T05:33:36.000000Z'),
                    phone: '34567890098',
                    gateValue: "The W Residences Reception",
                    checkOutOnPressed: () {
                      _showCheckoutDialog(context);
                    },
                    detailsOnPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.checkInDetailsScreen);
                    },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(10);
                },
              ),
              const Gap(5),
              Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const  Row(
                    children: [
                      Text(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        'E-Services',
                        style: AppTextStyles.style16Primary600,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      VisitorPassesButton(
                        horizontalPadding: 6,
                        count: 25,
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRoutes.visitorPassesScreen);
                        },
                      ),
                      const Gap(8),
                      CustomButton(
                          buttonColor: AppColors.blue,
                          text: 'View All',
                          height: 41,
                          // width: 100,
                          borderRadius: 6,
                          image: AppImages.view,
                          onPressed: () {
                            context
                                .read<DeviceDeciderCubit>()
                                .onChangeSelectedIndex(
                                context, AppConstants.eServicesIndex);
                          }),
                    ],
                  ),
                ],
              ),
              const Gap(15),
              ListView.separated(
                padding: const EdgeInsets.only(bottom: 10),
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return ServicesCardWidget(
                    unit: '1006',
                    title: 'Facility Booking',
                    reference: 'FO202401101791',
                    status: 'Notified',
                    serviceType: 'Fit Out NOC',
                    name: 'Suhaan',
                    checkInOnPressed: () {
                      Navigator.pushNamed(context, AppRoutes.mobileGuestCheckInScreen);
                    },
                    serviceableOnPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.serviceableCheckInsScreen);
                    }, detailsOnPressed: () {
                    Navigator.pushNamed(context, AppRoutes.servicesDetailsScreen);
                  },
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(10);
                },
              ),
              const Gap(5),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Work Orders / RFPs',
                    style: AppTextStyles.style16Primary600,
                  ),
                  CustomButton(
                      buttonColor: AppColors.blue,
                      text: 'View All',
                      height: 41,
                      // width: 100,
                      borderRadius: 6,
                      image: AppImages.view,
                      onPressed: () {
                        context.read<DeviceDeciderCubit>().onChangeSelectedIndex(
                            context, AppConstants.workOrderRfpIndex);
                      }),
                ],
              ),
              const Gap(15),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return WorkOrderRFPCardWidget(
                      typeText: 'Work Order',
                      typeAssetImage: AppImages.hammer,
                      status: 'Active',
                      title: '(2 Months) Services Contract',
                      reference: 'JB001-24-00102',
                      vendorName: 'Mohammed Faisal Al-Haddad',
                      date: '2025-04-04T05:33:36.000000Z',
                      checkInPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.mobileGuestCheckInScreen);
                      },
                    detailsOnPressed: () {
                      Navigator.pushNamed(context, AppRoutes.workOrderJobDetailsScreen);
                    },);
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Gap(10);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    final TextEditingController _visitorsNoController = TextEditingController();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title: 'Checkout for Ahmed',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              checkOutAllOnPress: () {},
              checkOutOnPress: () {},
              controller: _visitorsNoController,
              logIsLast: true,
              visitorsCount: 4,
              horizontalPadding: 0,
              logDate: '2025-04-04T05:33:36.000000Z',
              logStatus: 'Check-In',
              logByValue: '',
              logDescription:
                  '6 visitor(s) checked-in from gate ‘The W Residences',
            );
          },
        );
      },
    );
  }
}
