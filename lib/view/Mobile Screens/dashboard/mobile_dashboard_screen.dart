import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/styles/styles.dart';
import '../../Screen/Components/actions_item_model.dart';
import '../../widgets/button/action_button.dart';
import '../check ins/componants/check_in_container_widget.dart';
import '../services/components/services_card_widget.dart';
import '../work order/components/work_order_rfp_card_widget.dart';

class MobileDashboardScreen extends StatelessWidget {
  const MobileDashboardScreen({
    super.key,
  });

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
          // Navigator.pushNamed(context, AppRoutes.);
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
          // Navigator.pushNamed(context, AppRoutes.);
        },
      ),
      ActionsItemModel(
        title: 'Work Order / RFPs',
        count: '2',
        iconPath: AppImages.rfps,
        backgroundColor: AppColors.white,
        forGroundColor: AppColors.blue,
        onTap: () {
           Navigator.pushNamed(context, AppRoutes.workOrderRfpScreen);
        },
      ),
      ActionsItemModel(
        title: 'Guest Check-In',
        count: '',
        iconPath: AppImages.guestCheckIn,
        backgroundColor: AppColors.green,
        forGroundColor: AppColors.white,
        onTap: () {
          // Navigator.pushNamed(context, AppRoutes.);
        },
      ),
      ActionsItemModel(
        title: 'Message',
        count: '',
        iconPath: AppImages.message,
        backgroundColor: AppColors.blue,
        forGroundColor: AppColors.white,
        onTap: () {
          // Navigator.pushNamed(context, AppRoutes.);
        },
      ),
    ];
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(
            vertical: AppConstants.verticalPadding,
            horizontal: AppConstants.horizontalPadding),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome,',
                        style: AppTextStyles.style12Grey500,
                      ),
                      Text(
                        'Apricot Tower (Gate 2)',
                        style: AppTextStyles.style14Primary500,
                      ),
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
                    crossAxisCount: 2,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    mainAxisExtent: 100),
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
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ((actionsItem.iconPath)
                                        .split(".")
                                        .last ==
                                    "png")
                                ? Image.asset(
                                     actionsItem.iconPath,
                                    color: AppColors.primary,
                                    scale: 3,
                                  )
                                : SvgPicture.asset(
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
                  );
                },
              ),
              const Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Check-Ins',
                    style: AppTextStyles.style14Primary500,
                  ),
                  Spacer(),
                  ActionButton(
                    text: 'Check-Outs',
                    image: AppImages.checkout,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.red,
                  ),
                  Gap(10),
                  ActionButton(
                    verticalPadding: 6.4,
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.blue,
                  ),
                ],
              ),
              const Gap(10),
              ListView.builder(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return CheckInCardWidget(
                    boxText: 'visit',
                    name: 'John Henry',
                    image: AppImages.gates,
                    type: 'Guest',
                    date: DateFormat("MMM dd, yyyy ")
                        .format(DateTime.now()),
                    visitorCount: 'Visitor Count: 10',
                    gate: "Gate: 2",
                  );
                },
              ),
              const Row(
                children: [
                  Text(
                    'E-Services',
                    style: AppTextStyles.style14Primary500,
                  ),
                  Spacer(),
                  ActionButton(
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.blue,
                  ),
                ],
              ),
              const Gap(10),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return  ServicesCardWidget(
                    count: '1006',
                    title: 'Facility Booking',
                    reference: 'FO202401101791',
                    status: 'Active',
                    serviceType: 'Fit Out NOC',
                    name: 'Suhaan',
                    logoutOnPressed: (){},
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5));
                },
              ),
              Row(
                children: [
                  const Text(
                    'Work Orders / RFPs',
                    style: AppTextStyles.style14Primary500,
                  ),
                  const Spacer(),
                  ActionButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, AppRoutes.workOrderRfpScreen);
                    },
                    text: 'View All',
                    image: AppImages.view,
                    imageColor: AppColors.white,
                    backgroundColor: AppColors.blue,
                  ),
                ],
              ),
              const Gap(10),
              ListView.separated(
                shrinkWrap: true,
                primary: false,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return  WorkOrderDashboardCardWidget(
                    status: 'Active',
                    name: 'Work Order',
                    title: '(2 Months) Services Contract',
                    reference: 'JB001-24-00102',
                    vendorName: 'Onlinist Vendor',
                    date: 'Jan 7, 2025',
                    boxImage: AppImages.hammer,
                      logoutOnPressed: (){}

                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 5));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
