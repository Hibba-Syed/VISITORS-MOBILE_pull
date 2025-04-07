import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/Components/actions_item_model.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/Common%20Screens/services/components/services_card_widget.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_rfp_card_widget.dart';
import 'package:visitors/view/widgets/button/visitor_passes_button.dart';
import 'package:visitors/view/widgets/container_widgets/actions_container_widget.dart';
import 'package:visitors/view/widgets/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/styles/styles.dart';
import '../../widgets/button/action_button.dart';
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
          context.read<DeviceDeciderCubit>()
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
          context.read<DeviceDeciderCubit>()
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
          context.read<DeviceDeciderCubit>()
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
          context.read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(context, AppConstants.workOrderRfpIndex);
        },
      ),
      ActionsItemModel(
        title: 'Guest Check-In',
        iconPath: AppImages.guestCheckIn,
        backgroundColor: AppColors.green,
        forGroundColor: AppColors.white,
        onTap: () {
          Navigator.pushNamed(context, AppRoutes.guestCheckInScreen);

        },
      ),
      ActionsItemModel(
        title: 'Message',
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
                    HeadingWidget(heading: 'Welcome',style: AppTextStyles.style15DarkGrey500,),
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
                  ],),
                 Row(
                   children: [
                     ActionButton(
                       verticalPadding: 9.5,
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
                     const Gap(10),
                     ActionButton(
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
                  profileImageUrl: "https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2",
                  type: 'Guest',
                  date: DateTimeUtil.getFormattedDateTime('2025-04-04T05:33:36.000000Z'),
                  phone: '34567890098',
                  gateValue: "The W Residences Reception",
                  checkOutOnPressed: (){
                     _showCheckoutDialog(context);
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
                 const Row(
                  children: [
                     Text(
                      'E-Services',
                      style: AppTextStyles.style16Primary600,
                    ),

                  ],
                             ),
                 Row(
                   children: [
                     VisitorPassesButton(
                       count: 45,
                       onPressed: (){
                         Navigator.pushNamed(context, AppRoutes.visitorPassesScreen);
                       },
                     ),
                     const Gap(10),
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
               ],
             ),
            const Gap(15),
            ListView.separated(
              padding: const EdgeInsets.only(bottom: 10),
              shrinkWrap: true,
              primary: false,
              itemCount: 3,
              itemBuilder: (context, index) {
                return  ServicesCardWidget(
                  unit: '1006',
                  title: 'Facility Booking',
                  reference: 'FO202401101791',
                  status: 'Notified',
                  serviceType: 'Fit Out NOC',
                  name: 'Suhaan',
                  checkInOnPressed: (){
                    Navigator.pushNamed(context, AppRoutes.guestCheckInScreen);
                  },
                  serviceableOnPressed: (){
                    Navigator.pushNamed(context, AppRoutes.serviceableCheckInsScreen);
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
                ActionButton(
                  onPressed: () {
                    context
                        .read<DeviceDeciderCubit>()
                        .onChangeSelectedIndex(context, AppConstants.workOrderRfpIndex);
                  },
                  text: 'View All',
                  image: AppImages.view,
                  imageColor: AppColors.white,
                  backgroundColor: AppColors.blue,
                ),
              ],
            ),
            const Gap(15),
            ListView.separated(
              shrinkWrap: true,
              primary: false,
              itemCount: 3,
              itemBuilder: (context, index) {
                return  WorkOrderRFPCardWidget(
                  typeText: 'Work Order',
                  typeAssetImage: AppImages.hammer,
                  status: 'Active',
                  title: '(2 Months) Services Contract',
                  reference: 'JB001-24-00102',
                  vendorName: 'Mohammed Faisal Al-Haddad',
                  date: '2025-04-04T05:33:36.000000Z',
                    checkInPressed: (){
                      Navigator.pushNamed(context, AppRoutes.guestCheckInScreen);
                    }
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return const Gap(10);
              },
            ),
          ],
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
              checkOutAllOnPress: () {  },
              checkOutOnPress: () {  },
              controller: _visitorsNoController,
              logDate: '2025-04-04T05:33:36.000000Z',
              logStatus: 'Check-In',
              logByValue: '',
              logDescription: '6 visitor(s) checked-in from gate ‘The W Residences',
            );
          },
        );
      },
    );
  }

}
