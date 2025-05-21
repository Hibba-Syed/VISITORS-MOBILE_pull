import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/bloc/visitor_pass/visitor_pass_cubit.dart';
import 'package:visitors/model/check_ins/check_in_model.dart';
import 'package:visitors/utils/app_utils.dart';
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
import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../../bloc/check_out/check_out_cubit.dart';
import '../../../bloc/dashboard/dashboard_cubit.dart';
import '../../../bloc/e_service/details/service_details_cubit.dart';
import '../../../bloc/e_service/service_cubit.dart';
import '../../../bloc/work_order/details/work_order_details_cubit.dart';
import '../../../model/service/service_model.dart';
import '../../../model/work_order/work_order_model.dart';
import '../../../resource/constants/app_colors.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/images.dart';
import '../../../resource/constants/strings.dart';
import '../../../resource/styles/styles.dart';
import '../../../utils/date_time.dart';
import '../../widgets/container_widgets/check_out_container_widget.dart';
import '../../widgets/empty_widget.dart';

class MobileDashboardScreen extends StatelessWidget {
  const MobileDashboardScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
          final List<ActionsItemModel> actions = [
            ActionsItemModel(
              title: 'All Check-Ins',
              count: state.countModel?.total ?? 0,
              iconPath: AppImages.checkIn,
              backgroundColor: AppColors.white,
              forGroundColor: AppColors.green,
              onTap: () {
                context
                    .read<DeviceDeciderCubit>()
                    .onChangeSelectedIndex(AppConstants.checkInsIndex);
              },
            ),
            ActionsItemModel(
              title: 'Guests',
              count: state.countModel?.guests ?? 0,
              iconPath: AppImages.guests,
              backgroundColor: AppColors.white,
              forGroundColor: AppColors.yellow,
              onTap: () {
                context
                    .read<DeviceDeciderCubit>()
                    .onChangeSelectedIndex(AppConstants.checkInsIndex);
              },
            ),
            ActionsItemModel(
              title: 'E-Services',
              count: state.countModel?.service ?? 0,
              iconPath: AppImages.eServices,
              backgroundColor: AppColors.white,
              forGroundColor: AppColors.cyanBlue,
              onTap: () {
                context.read<DeviceDeciderCubit>().onChangeSelectedIndex(
                    AppConstants.eServicesIndex);
              },
            ),
            ActionsItemModel(
              title: 'Work Order / RFPs',
              count: state.countModel?.jobs ?? 0,
              iconPath: AppImages.rfps,
              backgroundColor: AppColors.white,
              forGroundColor: AppColors.primary,
              onTap: () {
                context.read<DeviceDeciderCubit>().onChangeSelectedIndex(
                    AppConstants.workOrderRfpIndex);
              },
            ),
          ];
          return RefreshIndicator(
            onRefresh: ()async{

            },
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(
                  vertical: AppConstants.verticalPadding,
                  horizontal: AppConstants.horizontalPadding),
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeadingWidget(
                            heading: 'Welcome',
                            style: AppTextStyles.style15DarkGrey600,
                          ),
                          HeadingWidget(
                              heading:
                                  "${state.profileRecord?.association?.name ?? ''} (${state.profileRecord?.gate ?? ''})"),
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
                  CustomButton(
                      imageHeight: 25,
                      fontSize: 17,
                      height: 70,
                      text: 'Guest Check-In',
                      buttonColor: AppColors.green,
                      textColor: AppColors.white,
                      image: AppImages.guestCheckIn,
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutes.mobileGuestCheckInScreen);
                      }),
                  const Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Text(
                            'Check-Ins',
                            style: AppTextStyles.style19Primary600,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CustomButton(
                              buttonColor: AppColors.red,
                              fontWeight: FontWeight.w500,
                              text: 'Check-Outs',
                              fontSize: 14,
                              height: 41,
                              borderRadius: 6,
                              image: AppImages.checkout,
                              onPressed: () {
                                context.read<CheckOutCubit>().getCheckOut();
                                context
                                    .read<DeviceDeciderCubit>()
                                    .onChangeSelectedIndex(
                                        AppConstants.checkOutsIndex);
                              }),
                          const Gap(10),
                          CustomButton(
                              buttonColor: AppColors.primary,
                              text: 'View All',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 41.5,
                              borderRadius: 6,
                              image: AppImages.view,
                              onPressed: () {
                                context
                                    .read<DeviceDeciderCubit>()
                                    .onChangeSelectedIndex(
                                    AppConstants.checkInsIndex);
                              }),
                        ],
                      ),
                    ],
                  ),
                  const Gap(10),
                  state.checkInsModel?.isEmpty ?? true
                      ? SizedBox(
                          height: 100,
                          child: const EmptyWidget(
                            text: 'No data available',
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.checkInsModel?.length ?? 0,
                          itemBuilder: (context, index) {
                            CheckInModel? checkInsRecord =
                                state.checkInsModel?[index];
                            return CheckInCardWidget(
                              count: checkInsRecord?.visitorCount ?? "",
                              typeImage: (checkInsRecord?.type?.toLowerCase() ==
                                          'community visit' ||
                                      checkInsRecord?.type?.toLowerCase() ==
                                          'community service')
                                  ? AppImages.community
                                  : "",
                              typeText: (checkInsRecord?.type?.toLowerCase() ==
                                          'unit visit' ||
                                      checkInsRecord?.type?.toLowerCase() ==
                                          'unit service')
                                  ? checkInsRecord?.unit?.unitNumber
                                  : checkInsRecord?.type ?? "",
                              name: checkInsRecord?.name ?? "",
                              profileImageUrl:
                                  checkInsRecord?.visitor?.imageUrl ?? "",
                              type:AppUtils.getServiceableType(
                                  checkInsRecord?.serviceableType)
                                  .label,
                              date: DateTimeUtil.getFormattedDatesTime(
                                  checkInsRecord?.visitor?.createdAt),
                              checkOutOnPressed: () {
                                _showCheckoutDialog(context);
                              },
                              detailsOnPressed: () {
                                context
                                    .read<CheckInsDetailsCubit>()
                                    .getCheckInDetails(id: checkInsRecord?.id);
                                Navigator.pushNamed(
                                    context, AppRoutes.checkInDetailsScreen,
                                    arguments: state.checkInsModel?[index]);
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
                      Flexible(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Text(
                                'E-Services',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.style19Primary600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          VisitorPassesButton(
                            horizontalPadding: 6,
                            count: 25,
                            onPressed: () {
                              context.read<VisitorPassCubit>().getVisitorPass();
                              Navigator.pushNamed(
                                  context, AppRoutes.visitorPassesScreen);
                            },
                          ),
                          const Gap(6),
                          CustomButton(
                              buttonColor: AppColors.primary,
                              text: 'View All',
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                              height: 41,
                              borderRadius: 6,
                              image: AppImages.view,
                              onPressed: () {
                                context.read<ServiceCubit>().getServices();
                                context
                                    .read<DeviceDeciderCubit>()
                                    .onChangeSelectedIndex(
                                         AppConstants.eServicesIndex);
                              }),
                        ],
                      ),
                    ],
                  ),
                  const Gap(15),
                  state.serviceModel?.isEmpty ?? true
                      ? SizedBox(
                          height: 100,
                          child: const EmptyWidget(
                            text: 'No data available',
                          ),
                        )
                      : ListView.separated(
                          padding: const EdgeInsets.only(bottom: 10),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.serviceModel?.length ?? 0,
                          itemBuilder: (context, index) {
                            ServiceModel? service = state.serviceModel?[index];
                            return ServicesCardWidget(
                              isActiveCheckins:
                                  (service?.activeCheckIns?.isNotEmpty ?? true)
                                      ? true
                                      : false,
                              unit: service?.unit?.unitNumber ?? "",
                              title: service?.applicationType ?? "",
                              reference: service?.reference ?? "",
                              status: service?.status ?? "",
                              serviceType: service?.applicationType ?? "",
                              name: service?.clientName ?? "",
                              checkInOnPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.mobileGuestCheckInScreen);
                              },
                              serviceableCheckInOnPressed: () {
                                context
                                    .read<CheckInsCubit>()
                                    .onChangeSelectedType(
                                        AppUtils.getServiceableType(
                                            Strings.keyServices));
                                context.read<CheckInsCubit>().onChangeSelectedServiceableId(service?.id);
                                context.read<CheckInsCubit>().getCheckIns();
                                Navigator.pushNamed(
                                    context, AppRoutes.serviceableCheckInsScreen);
                              },
                              detailsOnPressed: () {
                                context
                                    .read<ServiceDetailsCubit>()
                                    .getServiceDetails(serviceId: service?.id);
                                Navigator.pushNamed(
                                    context, AppRoutes.servicesDetailsScreen);
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
                        style: AppTextStyles.style19Primary600,
                      ),
                      CustomButton(
                          buttonColor: AppColors.primary,
                          fontSize: 14,
                          text: 'View All',
                          height: 41,
                          fontWeight: FontWeight.w500,
                          borderRadius: 6,
                          image: AppImages.view,
                          onPressed: () {
                            context
                                .read<DeviceDeciderCubit>()
                                .onChangeSelectedIndex(
                                AppConstants.workOrderRfpIndex);
                          }),
                    ],
                  ),
                  const Gap(15),
                  state.workOrderModel?.isEmpty ?? true
                      ? SizedBox(
                          height: 100,
                          child: const EmptyWidget(
                            text: 'No data available',
                          ),
                        )
                      : ListView.separated(
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.workOrderModel?.length ?? 0,
                          itemBuilder: (context, index) {
                            WorkOrderModel? workOrder =
                                state.workOrderModel?[index];
                            // print('wdate: ${workOrderModel?.createdAt}');
                            return WorkOrderRFPCardWidget(
                              isAwarded: workOrder?.isAwarded,
                              isActiveCheckins:
                                  (workOrder?.activeCheckIns?.isNotEmpty ??
                                          true)
                                      ? true
                                      : false,
                              typeText: 'Work Order',
                              typeAssetImage: AppImages.hammer,
                              status: workOrder?.status ?? "",
                              title: workOrder?.title ?? "",
                              reference: workOrder?.reference ?? "",
                              vendorName:
                                  workOrder?.newVendor?.companyName ?? "",
                              date: workOrder?.startDate?.toString(),
                              //DateTimeUtil.getFormattedDatesTime(workOrderModel?.startDate),
                              checkInPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.mobileGuestCheckInScreen);
                              },
                              detailsOnPressed: () {
                                context.read<WorkOrderDetailsCubit>().getWorkOrderDetails(workOrderId: workOrder?.id);
                                Navigator.pushNamed(
                                    context, AppRoutes.workOrderJobDetailsScreen);
                              },

                              jobCheckInOnPressed: () {
                                context
                                    .read<CheckInsCubit>()
                                    .onChangeSelectedType(
                                    AppUtils.getServiceableType(
                                        Strings.keyWorkOrder));
                                context.read<CheckInsCubit>().onChangeSelectedServiceableId(workOrder?.id);
                                context.read<CheckInsCubit>().getCheckIns();
                                Navigator.pushNamed(
                                    context, AppRoutes.jobCheckInsScreen);
                              },
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
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        shape: const CircleBorder(),
        onPressed: () {
          context
              .read<DeviceDeciderCubit>()
              .onChangeSelectedIndex(AppConstants.messagesIndex);
        },
        child: Icon(
          CupertinoIcons.chat_bubble_2,
          color: AppColors.white,
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context) {
    final TextEditingController visitorsNoController = TextEditingController();
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
              controller: visitorsNoController,
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
