import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/view/Common%20Screens/Components/actions_item_model.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/Common%20Screens/services/components/services_card_widget.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_rfp_card_widget.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/styles/styles.dart';
import '../../widgets/button/action_button.dart';

class TabletDashboardScreen extends StatelessWidget {
   const TabletDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ActionsItemModel> actions = [
      ActionsItemModel(
        title: 'All Check-Ins',
        count: '10',
        iconPath: AppImages.checkIn,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.green,
        onTap: () {
          context.read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.checkInsIndex);
        },
      ),
      ActionsItemModel(
        title: 'Guests',
        count: '10',
        iconPath: AppImages.guests,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.yellow,
        onTap: () {
          // Navigator.pushNamed(context, AppRoutes.);
        },
      ),
      ActionsItemModel(
        title: 'E-Services',
        count: '5',
        iconPath: AppImages.eServices,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.cyanBlue,
        onTap: () {
          context.read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.eServicesIndex);
        },
      ),
      ActionsItemModel(
        title: 'Work Order / RFPs',
        count: '2',
        iconPath: AppImages.rfps,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.blue,
        onTap: () {
          context.read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.workOrderRfpIndex);
        },
      ),
    ];
    final List<ActionsItemModel> tabletActions = [
      ActionsItemModel(
        title: 'Guest Check-In',
        count: '',
        iconPath: AppImages.guestCheckIn,
        backgroundColor: AppColors.green,
        forGroundColor: AppColors.white,
        onTap: () {
          context.read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.checkInsIndex);
        },
      ),
      ActionsItemModel(
        title: 'Message',
        count: '',
        iconPath: AppImages.message,
        backgroundColor: AppColors.blue,
        forGroundColor: AppColors.white,
        onTap: () {
          context.read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.messagesIndex);
        },
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppConstants.verticalPadding, horizontal: AppConstants.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Welcome,',style: AppTextStyles.style13Grey500,),
                      Text('Apricot Tower (Gate 2)',style: AppTextStyles.style16Primary600,),
                    ],
                  ),
                  ActionButton(
                    text: 'VMS Guide',
                    imageColor: AppColors.white,
                    image: AppImages.guide,
                  ),
                ],
              ),
              const Gap(10),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 100
                ),
                itemCount: actions.length,
                itemBuilder: (BuildContext context, int index) {
                  ActionsItemModel actionsItem = actions[index];
                  return InkWell(
                    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                    onTap: actionsItem.onTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: actionsItem.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Expanded(
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ((actionsItem.iconPath)
                                  .split(".")
                                  .last == "png") ? Image.asset(
                                actionsItem.iconPath,
                                color: AppColors.primary,
                                scale: 3,
                              ) : SvgPicture.asset(
                                actionsItem.iconPath,
                                height: 30,
                                width: 30,
                                fit: BoxFit.fill,
                              ),
                              const Gap(5),
                              if (actionsItem.count
                                  .toString()
                                  .isNotEmpty) ...[
                                Text(
                                  actionsItem.count,
                                  style: TextStyle(
                                      fontFamily: 'Inter',
                                      fontSize: 14,
                                      color: actionsItem.forGroundColor,
                                      fontWeight: FontWeight.w600
                                  ),
                                  //AppTextStyles.style14white600,
                                ),
                              ],
                              Text( actionsItem.title,
                                style: TextStyle(
                                    fontFamily: 'Inter',
                                    fontSize: 14,
                                    color: actionsItem.forGroundColor,
                                    fontWeight: FontWeight.w500
                                ),
                                //AppTextStyles.style14white500
                              ),
                            ]),
                      ),
                    ),
                  );
                },
              ),
              const Gap(10),
              GridView.builder(
                primary: false,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 100
                ),
                itemCount: tabletActions.length,
                itemBuilder: (BuildContext context, int index) {
                  ActionsItemModel tabletActionsItem = tabletActions[index];
                  return InkWell(
                    overlayColor: const WidgetStatePropertyAll(Colors.transparent),
                    onTap: tabletActionsItem.onTap,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: tabletActionsItem.backgroundColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ((tabletActionsItem.iconPath)
                                .split(".")
                                .last == "png") ? Image.asset(
                              tabletActionsItem.iconPath,
                              color: AppColors.primary,
                              scale: 3,
                            ) : SvgPicture.asset(
                              tabletActionsItem.iconPath,
                              height: 30,
                              width: 30,
                              fit: BoxFit.fill,
                            ),
                            const Gap(5),
                            Text( tabletActionsItem.title,
                              style: TextStyle(
                                  fontFamily: 'Inter',
                                  fontSize: 14,
                                  color: tabletActionsItem.forGroundColor,
                                  fontWeight: FontWeight.w500
                              ),
                              //AppTextStyles.style14white500
                            ),
                          ]),
                    ),
                  );
                },
              ),
              const Gap(10),
               Row(
                children: [
                 const Text('Check-Ins', style: AppTextStyles.style16Primary600,),
                 const Spacer(),
                  ActionButton(
                    text: 'Check-Outs',
                    image: AppImages.checkout,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.red,
                    onPressed: (){
                      context
                          .read<DeviceDeciderCubit>()
                          .onChangeSelectedIndex(context, AppConstants.checkOutsIndex);
                    },
                  ),
                  const Gap(20),
                  ActionButton(
                    verticalPadding: 6.4,
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.blue,
                    onPressed: (){
                      context
                          .read<DeviceDeciderCubit>()
                          .onChangeSelectedIndex(context, AppConstants.checkInsIndex);
                    },
                  ),
                ],
              ),
              const Gap(5),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: ( context,  index) {
                  return CheckInCardWidget(
                    name: 'John Henry',
                    type: 'Guest',
                    date: DateFormat("MMM dd, yyyy ")
                        .format(DateTime.now()),
                    phone: 'Visitor Count: 10',
                  );
                },
              ),
              const Gap(10),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('E-services', style: AppTextStyles.style16Primary600,),
                  ActionButton(
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.blue,
                    onPressed: (){
                      context
                          .read<DeviceDeciderCubit>()
                          .onChangeSelectedIndex(context, AppConstants.eServicesIndex);
                    },
                  ),

                ],
              ),
              const Gap(10),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: ( context,  index) {
                  return ServicesCardWidget(
                    unit: '1006',
                    title: 'Facility Booking',
                    reference: 'FO202401101791',
                    serviceType: 'Fit Out NOC',
                    name: 'Suhaan',
                    logoutOnPressed: (){},

                  );
                },
              ),
              const Gap(10),
               Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 const  Text('Work Orders / RFPs', style: AppTextStyles.style16Primary600,),
                  ActionButton(
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.blue,
                    onPressed: (){
                      context
                          .read<DeviceDeciderCubit>()
                          .onChangeSelectedIndex(context, AppConstants.workOrderRfpIndex);
                    },
                  ),
                ],
              ),
              const Gap(10),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: ( context,  index) {
                  return const WorkOrderRFPCardWidget(
                    title: '(2 Months) Services Contract',
                    reference: 'JB001-24-00102',
                    vendorName: 'Onlinist Vendor',
                    date: 'Jan 7, 2025',
                  );
                },

              ),
            ],
          ),
        ),
      ),
    );
  }
}