import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/message/message_cubit.dart';
import 'package:visitors/model/check_ins/check_in_model.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/utils/routes/app_routes.dart';
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
import '../../../bloc/main_dashboard/main_dashboard_cubit.dart';
import '../../../bloc/visitor_passes/visitor_pass_cubit.dart';
import '../../../bloc/work_order/details/work_order_details_cubit.dart';
import '../../../bloc/work_order/work_order_cubit.dart';
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
import '../check_ins/componants/check_in_card_widget.dart';
import '../components/actions_item_model.dart';
import '../services/components/services_card_widget.dart';
import '../work order/components/work_order_rfp_card_widget.dart';

class DashboardScreen extends StatelessWidget {
  DashboardScreen({
    super.key,
  });

  final TextEditingController visitorsNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (didPop) return;
        await _showExitDialog(context);
      },
      child: Scaffold(
        body: width >= AppConstants.tabletScreen
            ? tabletDashboardScreen(context)
            : mobileDashboardScreen(context),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColors.primary,
          shape: const CircleBorder(),
          onPressed: () {
            context.read<MessageCubit>().getMessages();
            context
                .read<MainDashboardCubit>()
                .onChangeSelectedIndex(AppConstants.messagesIndex);
          },
          child: SvgPicture.asset(
            AppImages.chat,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            fit: BoxFit.scaleDown,
          ),
        ),
      ),
    );
  }

  Future<bool> _showExitDialog(BuildContext context) async {
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
                Text(AppUtils.languageTranslate('areYouSureYouWantToExit?'),
                    style: AppTextStyles.style16DarkGrey600),
                const Gap(20),
                Row(
                  children: [
                    Expanded(
                        child: CustomButton(
                            text: AppUtils.languageTranslate('cancel'),
                            onPressed: () => Navigator.pop(context, false))),
                    const Gap(10),
                    Expanded(
                      child: CustomButton(
                        text: AppUtils.languageTranslate('yesExit'),
                        invert: true,
                        onPressed: () {
                          exit(0);
                        },
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ) ??
        false;
  }

  void showCheckoutDialog(BuildContext context, CheckInModel? checkIns) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title:
              '${AppUtils.languageTranslate('checkoutFor')} ${checkIns?.name ?? ""}',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              visitorsCount: //int.tryParse(checkIns?.visitorCount ?? ''),
                  checkIns?.visitorCount ?? "",
              controller: visitorsNoController,
              checkOutAllOnPress: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                      isFirstButtonDisable: true,
                      secondButtonColor: AppColors.red,
                      secondButtonText: AppUtils.languageTranslate('yes'),
                      title:
                          AppUtils.languageTranslate('checkOutForAllCheckIns'),
                      onSecondButtonPressed: () async {
                        final result = await context
                            .read<DashboardCubit>()
                            .checkOutVisitors(context, id: checkIns?.id, data: {
                          "checkout_count": visitorsNoController.text.isNotEmpty
                              ? {"checkout_count": visitorsNoController.text}
                              : {}
                        });
                        visitorsNoController.clear();
                        return result;
                      },
                    );
                  },
                );
              },
              checkOutOnPress: () async {
                final enteredCount =
                    int.tryParse(visitorsNoController.text.trim());
                final availableCount =
                    int.tryParse(checkIns?.visitorCount ?? '') ?? 0;
                if ((enteredCount ?? 0) > availableCount) {
                  Fluttertoast.showToast(
                      msg: AppUtils.languageTranslate(
                          'availableCountIs $availableCount'));
                  return;
                }
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        isFirstButtonDisable: true,
                        secondButtonColor: AppColors.red,
                        secondButtonText: AppUtils.languageTranslate('yes'),
                        title:
                            AppUtils.languageTranslate('checkoutForVisitors'),
                        onSecondButtonPressed: () async {
                          final result = await context
                              .read<DashboardCubit>()
                              .checkOutVisitors(context,
                                  id: checkIns?.id,
                                  data: {
                                "checkout_count": visitorsNoController.text
                              });
                          visitorsNoController.clear();
                          return result;
                        });
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  //mobile view
  Widget mobileDashboardScreen(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: BlocBuilder<DashboardCubit, DashboardState>(
          builder: (context, state) {
            final List<ActionsItemModel> actions = [
              ActionsItemModel(
                title: AppUtils.languageTranslate("allCheckIns"),
                count: state.countModel?.total ?? 0,
                iconPath: AppImages.checkIn,
                backgroundColor: AppColors.white,
                forGroundColor: AppColors.green,
                onTap: () {
                  onViewAllDashboardPressed(
                      context, AppConstants.checkInsIndex);
                },
              ),
              ActionsItemModel(
                title: AppUtils.languageTranslate("guests"),
                count: state.countModel?.guests ?? 0,
                iconPath: AppImages.guests,
                backgroundColor: AppColors.white,
                forGroundColor: AppColors.yellow,
                onTap: () {
                  final type = AppUtils.getServiceableType(Strings.keyGuest);
                  context
                      .read<CheckInsCubit>()
                      .onChangeSelectedVisitorType(type);
                  context.read<CheckInsCubit>().getCheckIns();
                  context
                      .read<MainDashboardCubit>()
                      .onChangeSelectedIndex(AppConstants.checkInsIndex);
                },
              ),
              ActionsItemModel(
                title: AppUtils.languageTranslate("eServices"),
                count: state.countModel?.service ?? 0,
                iconPath: AppImages.eServices,
                backgroundColor: AppColors.white,
                forGroundColor: AppColors.cyanBlue,
                onTap: () {
                  context.read<CheckInsCubit>().onChangeSelectedVisitorType(
                      AppUtils.getServiceableType(Strings.keyServices));
                  context.read<CheckInsCubit>().getCheckIns();
                  context
                      .read<MainDashboardCubit>()
                      .onChangeSelectedIndex(AppConstants.checkInsIndex);
                },
              ),
              ActionsItemModel(
                title: AppUtils.languageTranslate("workOrderRFPs"),
                count: state.countModel?.jobs ?? 0,
                iconPath: AppImages.rfps,
                backgroundColor: AppColors.white,
                forGroundColor: AppColors.primary,
                onTap: () {
                  context.read<CheckInsCubit>().onChangeSelectedVisitorType(
                      AppUtils.getServiceableType(Strings.keyWorkOrder));
                  context.read<CheckInsCubit>().getCheckIns();
                  context
                      .read<MainDashboardCubit>()
                      .onChangeSelectedIndex(AppConstants.checkInsIndex);
                },
              ),
            ];
            return RefreshIndicator(
              onRefresh: () async {
                await context.read<DashboardCubit>().refreshData(context);
              },
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                    vertical: AppConstants.verticalPadding,
                    horizontal: AppConstants.horizontalPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeadingWidget(
                      heading: AppUtils.languageTranslate("welcome"),
                      style: AppTextStyles.style15DarkGrey600,
                    ),
                    HeadingWidget(
                        heading:
                            "${state.profileRecord?.association?.name ?? ''} (${state.profileRecord?.gate ?? ''})"),
                    const Gap(10),
                    GridView.builder(
                      padding: const EdgeInsets.only(bottom: 10),
                      primary: false,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                          foregroundColor: actionsItem.forGroundColor,
                          iconPath: actionsItem.iconPath,
                          actionOnTap: actionsItem.onTap,
                        );
                      },
                    ),
                    CustomButton(
                        imageHeight: 25,
                        fontSize: 17,
                        height: 70,
                        text: AppUtils.languageTranslate("guestCheckIn"),
                        buttonColor: AppColors.green,
                        textColor: AppColors.white,
                        image: AppImages.guestCheckIn,
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.guestCheckIn)
                              .then(
                            (value) {
                              if (value == true) {
                                context
                                    .read<DashboardCubit>()
                                    .refreshData(context);
                              }
                            },
                          );
                        }),
                    const Gap(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            AppUtils.languageTranslate("checkIns"),
                            style: AppTextStyles.style19Primary600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Row(
                          children: [
                            CustomButton(
                                buttonColor: AppColors.red,
                                fontWeight: FontWeight.w500,
                                text: AppUtils.languageTranslate("checkOuts"),
                                fontSize: 14,
                                height: 41,
                                borderRadius: 6,
                                image: AppImages.checkout,
                                onPressed: () {
                                  onViewAllDashboardPressed(
                                      context, AppConstants.checkOutsIndex);
                                }),
                            const Gap(10),
                            CustomButton(
                                buttonColor: AppColors.primary,
                                text: AppUtils.languageTranslate("viewAll"),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 41.5,
                                borderRadius: 6,
                                image: AppImages.view,
                                onPressed: () {
                                  onViewAllDashboardPressed(
                                      context, AppConstants.checkInsIndex);
                                }),
                          ],
                        ),
                      ],
                    ),
                    const Gap(10),
                    state.checkInsModel?.isEmpty ?? true
                        ? SizedBox(
                            height: 100,
                            child: EmptyWidget(
                              text:
                                  AppUtils.languageTranslate('noDataAvailable'),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.checkInsModel?.length ?? 0,
                            itemBuilder: (context, index) {
                              CheckInModel? checkIns =
                                  state.checkInsModel?[index];
                              return CheckInCardWidget(
                                phone: checkIns?.phone ?? "--",
                                count: checkIns?.visitorCount ?? "",
                                typeImage: (checkIns?.type?.toLowerCase() ==
                                            'community visit' ||
                                        checkIns?.type?.toLowerCase() ==
                                            'community service')
                                    ? AppImages.community
                                    : "",
                                typeText: (checkIns?.type?.toLowerCase() ==
                                            'unit visit' ||
                                        checkIns?.type?.toLowerCase() ==
                                            'unit service')
                                    ? checkIns?.unit?.unitNumber
                                    : checkIns?.type ?? "--",
                                name: checkIns?.name ?? "--",
                                profileImageUrl:
                                    checkIns?.visitor?.imageUrl ?? "",
                                type: AppUtils.getServiceableType(
                                        checkIns?.serviceableType)
                                    .label,
                                createdDate: DateTimeUtil.getFormattedDateTime(
                                    checkIns?.visitor?.createdAt),
                                isMobile: checkIns?.isMobile,
                                checkOutOnPressed: () {
                                  context
                                      .read<CheckInsDetailsCubit>()
                                      .getCheckInDetailsLog(id: checkIns?.id);
                                  showCheckoutDialog(context, checkIns);
                                },
                                detailsOnPressed: () {
                                  context
                                      .read<CheckInsDetailsCubit>()
                                      .getCheckInDetailsLog(id: checkIns?.id);
                                  Navigator.pushNamed(
                                      context, AppRoutes.checkInDetails,
                                      arguments: state.checkInsModel?[index]);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Gap(10);
                            },
                          ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            AppUtils.languageTranslate("eServices"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.style19Primary600,
                          ),
                        ),
                        Row(
                          children: [
                            SizedBox(
                              height: 40,
                              width: 145,
                              child: VisitorPassesButton(
                                verticalPadding: 4,
                                horizontalPadding: 9,
                                count: state.visitorPassesCount?.count ?? 0,
                                onPressed: () {
                                  onViewVisitorPasses(context);
                                },
                              ),
                            ),
                            const Gap(6),
                            CustomButton(
                                buttonColor: AppColors.primary,
                                text: AppUtils.languageTranslate("viewAll"),
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                height: 41,
                                borderRadius: 6,
                                image: AppImages.view,
                                onPressed: () {
                                  onViewAllDashboardPressed(
                                      context, AppConstants.eServicesIndex);
                                }),
                          ],
                        ),
                      ],
                    ),
                    const Gap(15),
                    state.serviceModel?.isEmpty ?? true
                        ? SizedBox(
                            height: 100,
                            child: EmptyWidget(
                              text:
                                  AppUtils.languageTranslate('noDataAvailable'),
                            ),
                          )
                        : ListView.separated(
                            padding: const EdgeInsets.only(bottom: 10),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.serviceModel?.length ?? 0,
                            itemBuilder: (context, index) {
                              ServiceModel? service =
                                  state.serviceModel?[index];
                              return ServicesCardWidget(
                                isActiveCheckins:
                                    (service?.activeCheckIns?.isNotEmpty ??
                                            true)
                                        ? true
                                        : false,
                                unit: service?.unit?.unitNumber ?? "--",
                                title: service?.applicationType ?? "--",
                                reference: service?.reference ?? "--",
                                status: service?.status ?? "--",
                                serviceType: service?.applicationType ?? "--",
                                name: service?.clientName ?? "--",
                                checkInOnPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.guestCheckIn,
                                    arguments: {"service": service},
                                  ).then(
                                    (value) {
                                      if (value == true) {
                                        context
                                            .read<DashboardCubit>()
                                            .refreshData(context);
                                      }
                                    },
                                  );
                                },
                                serviceableCheckInOnPressed: () {
                                  context
                                      .read<CheckInsCubit>()
                                      .onChangeSelectedVisitorType(
                                          AppUtils.getServiceableType(
                                              Strings.keyServices));
                                  context
                                      .read<CheckInsCubit>()
                                      .onChangeSelectedServiceableId(
                                          service?.id);
                                  context.read<CheckInsCubit>().getCheckIns();
                                  Navigator.pushNamed(
                                      context, AppRoutes.serviceableCheckIns);
                                },
                                detailsOnPressed: () {
                                  context
                                      .read<ServiceDetailsCubit>()
                                      .getServiceDetails(
                                          serviceId: service?.id);
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            AppUtils.getRouteName(service),
                                      ));
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Gap(10);
                            },
                          ),
                    const Gap(5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          AppUtils.languageTranslate("workOrderRFPs"),
                          style: AppTextStyles.style19Primary600,
                        ),
                        CustomButton(
                            buttonColor: AppColors.primary,
                            fontSize: 14,
                            text: AppUtils.languageTranslate("viewAll"),
                            height: 41,
                            fontWeight: FontWeight.w500,
                            borderRadius: 6,
                            image: AppImages.view,
                            onPressed: () {
                              onViewAllDashboardPressed(
                                  context, AppConstants.workOrderRfpIndex);
                            }),
                      ],
                    ),
                    const Gap(15),
                    state.workOrderModel?.isEmpty ?? true
                        ? SizedBox(
                            height: 100,
                            child: EmptyWidget(
                              text:
                                  AppUtils.languageTranslate('noDataAvailable'),
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.workOrderModel?.length ?? 0,
                            itemBuilder: (context, index) {
                              WorkOrderModel? workOrder =
                                  state.workOrderModel?[index];
                              return WorkOrderRFPCardWidget(
                                isAwarded: workOrder?.isAwarded,
                                isActiveCheckins:
                                    (workOrder?.activeCheckIns?.isNotEmpty ??
                                            true)
                                        ? true
                                        : false,
                                typeAssetImage: AppImages.hammer,
                                status: workOrder?.status ?? "",
                                title: workOrder?.title ?? "",
                                reference: workOrder?.reference ?? "",
                                vendorName:
                                    workOrder?.newVendor?.companyName ?? "",
                                createdDate: DateTimeUtil.getFormattedDate(
                                    workOrder?.startDate),
                                updatedDate: DateTimeUtil.getFormattedDate(
                                    workOrder?.finishDate),
                                checkInPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    AppRoutes.guestCheckIn,
                                    arguments: {
                                      "work_order": workOrder,
                                    },
                                  ).then(
                                    (value) {
                                      if (value == true) {
                                        context
                                            .read<DashboardCubit>()
                                            .refreshData(context);
                                      }
                                    },
                                  );
                                },
                                detailsOnPressed: () {
                                  context
                                      .read<WorkOrderDetailsCubit>()
                                      .getWorkOrderDetails(
                                          workOrderId: workOrder?.id);
                                  Navigator.pushNamed(
                                      context, AppRoutes.workOrderJobDetails);
                                },
                                jobCheckInOnPressed: () {
                                  context
                                      .read<CheckInsCubit>()
                                      .onChangeSelectedVisitorType(
                                          AppUtils.getServiceableType(
                                              Strings.keyWorkOrder));
                                  context
                                      .read<CheckInsCubit>()
                                      .onChangeSelectedServiceableId(
                                          workOrder?.id);
                                  context.read<CheckInsCubit>().getCheckIns();
                                  Navigator.pushNamed(
                                      context, AppRoutes.jobCheckIns);
                                },
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return const Gap(10);
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

//tab view
  Widget tabletDashboardScreen(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
        builder: (context, state) {
      final List<ActionsItemModel> actions = [
        ActionsItemModel(
          title: AppUtils.languageTranslate("allCheckIns"),
          count: state.countModel?.total ?? 0,
          iconPath: AppImages.checkIn,
          backgroundColor: AppColors.white,
          forGroundColor: AppColors.green,
          onTap: () {
            onViewAllDashboardPressed(context, AppConstants.checkInsIndex);
          },
        ),
        ActionsItemModel(
          title: AppUtils.languageTranslate("guests"),
          count: state.countModel?.guests ?? 0,
          iconPath: AppImages.guests,
          backgroundColor: AppColors.white,
          forGroundColor: AppColors.yellow,
          onTap: () {
            context.read<CheckInsCubit>().onChangeSelectedVisitorType(
                AppUtils.getServiceableType(Strings.keyGuest));
            context.read<CheckInsCubit>().getCheckIns();
            context
                .read<MainDashboardCubit>()
                .onChangeSelectedIndex(AppConstants.checkInsIndex);
          },
        ),
        ActionsItemModel(
          title: AppUtils.languageTranslate("eServices"),
          count: state.countModel?.service ?? 0,
          iconPath: AppImages.eServices,
          backgroundColor: AppColors.white,
          forGroundColor: AppColors.cyanBlue,
          onTap: () {
            context.read<CheckInsCubit>().onChangeSelectedVisitorType(
                AppUtils.getServiceableType(Strings.keyServices));
            context.read<CheckInsCubit>().getCheckIns();
            context
                .read<MainDashboardCubit>()
                .onChangeSelectedIndex(AppConstants.checkInsIndex);
          },
        ),
        ActionsItemModel(
          title: AppUtils.languageTranslate("workOrderRFPs"),
          count: state.countModel?.jobs ?? 0,
          iconPath: AppImages.rfps,
          backgroundColor: AppColors.white,
          forGroundColor: AppColors.primary,
          onTap: () {
            context.read<CheckInsCubit>().onChangeSelectedVisitorType(
                AppUtils.getServiceableType(Strings.keyWorkOrder));
            context.read<CheckInsCubit>().getCheckIns();
            context
                .read<MainDashboardCubit>()
                .onChangeSelectedIndex(AppConstants.checkInsIndex);
          },
        ),
      ];
      return Scaffold(
        body: RefreshIndicator(
          onRefresh: () async {
            await context.read<DashboardCubit>().refreshData(context);
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
                vertical: AppConstants.verticalPadding,
                horizontal: AppConstants.horizontalPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeadingWidget(
                  heading: AppUtils.languageTranslate("welcome"),
                  style: AppUtils.isTablet(context)
                      ? AppTextStyles.style16DarkGrey600
                      : AppTextStyles.style15DarkGrey600,
                ),
                HeadingWidget(
                    heading:
                        "${state.profileRecord?.association?.name ?? ''} (${state.profileRecord?.gate ?? ''})"),
                const Gap(10),
                GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
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
                      foregroundColor: actionsItem.forGroundColor,
                      iconPath: actionsItem.iconPath,
                      actionOnTap: actionsItem.onTap,
                    );
                  },
                ),
                const Gap(10),
                CustomButton(
                    imageHeight: 30,
                    fontSize: 20,
                    height: 80,
                    text: AppUtils.languageTranslate("guestCheckIn"),
                    buttonColor: AppColors.green,
                    textColor: AppColors.white,
                    image: AppImages.guestCheckIn,
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.guestCheckIn).then(
                        (value) {
                          if (value == true) {
                            context.read<DashboardCubit>().refreshData(context);
                          }
                        },
                      );
                    }),
                const Gap(10),
                Row(
                  children: [
                    Text(
                      AppUtils.languageTranslate("checkIns"),
                      style: AppTextStyles.style19Primary600,
                    ),
                    const Gap(20),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: CustomButton(
                                buttonColor: AppColors.red,
                                text: AppUtils.languageTranslate("checkOuts"),
                                height: 42,
                                borderRadius: 6,
                                imageHeight: 22,
                                image: AppImages.checkout,
                                onPressed: () {
                                  onViewAllDashboardPressed(
                                      context, AppConstants.checkOutsIndex);
                                }),
                          ),
                          const Gap(10),
                          Expanded(
                            child: CustomButton(
                                buttonColor: AppColors.primary,
                                text: AppUtils.languageTranslate("viewAll"),
                                height: 42,
                                borderRadius: 6,
                                imageHeight: 22,
                                image: AppImages.view,
                                onPressed: () {
                                  onViewAllDashboardPressed(
                                      context, AppConstants.checkInsIndex);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                state.checkInsModel?.isEmpty ?? true
                    ? SizedBox(
                        height: 100,
                        child: EmptyWidget(
                          text: AppUtils.languageTranslate('noDataAvailable'),
                        ),
                      )
                    : ListView.separated(
                        padding: const EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.checkInsModel?.length ?? 0,
                        itemBuilder: (context, index) {
                          CheckInModel? checkIns = state.checkInsModel?[index];
                          return CheckInCardWidget(
                            count: checkIns?.visitorCount ?? "",
                            typeImage: (checkIns?.type?.toLowerCase() ==
                                        'community visit' ||
                                    checkIns?.type?.toLowerCase() ==
                                        'community service')
                                ? AppImages.community
                                : "",
                            typeText: (checkIns?.type?.toLowerCase() ==
                                        'unit visit' ||
                                    checkIns?.type?.toLowerCase() ==
                                        'unit service')
                                ? checkIns?.unit?.unitNumber
                                : checkIns?.type ?? "",
                            name: checkIns?.name ?? "",
                            profileImageUrl: checkIns?.visitor?.imageUrl ?? "",
                            type: AppUtils.getServiceableType(
                                    checkIns?.serviceableType)
                                .label,
                            createdDate: DateTimeUtil.getFormattedDateTime(
                                checkIns?.visitor?.createdAt),
                            isMobile: checkIns?.isMobile,
                            phone: checkIns?.phone ?? "",
                            checkOutOnPressed: () {
                              context
                                  .read<CheckInsDetailsCubit>()
                                  .getCheckInDetailsLog(id: checkIns?.id);
                              showCheckoutDialog(context, checkIns);
                            },
                            detailsOnPressed: () {
                              context
                                  .read<CheckInsDetailsCubit>()
                                  .getCheckInDetailsLog(id: checkIns?.id);
                              Navigator.pushNamed(
                                  context, AppRoutes.checkInDetails,
                                  arguments: state.checkInsModel?[index]);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(10);
                        },
                      ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppUtils.languageTranslate("eServices"),
                      style: AppTextStyles.style19Primary600,
                    ),
                    const Gap(20),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: VisitorPassesButton(
                              horizontalPadding: 35,
                              verticalPadding: 10,
                              count: state.visitorPassesCount?.count ?? 0,
                              onPressed: () {
                                onViewVisitorPasses(context);
                              },
                            ),
                          ),
                          const Gap(10),
                          Expanded(
                            child: CustomButton(
                                buttonColor: AppColors.primary,
                                text: AppUtils.languageTranslate("viewAll"),
                                height: 42,
                                borderRadius: 6,
                                imageHeight: 22,
                                image: AppImages.view,
                                onPressed: () {
                                  onViewAllDashboardPressed(
                                      context, AppConstants.eServicesIndex);
                                }),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const Gap(10),
                state.serviceModel?.isEmpty ?? true
                    ? SizedBox(
                        height: 100,
                        child: EmptyWidget(
                          text: AppUtils.languageTranslate('noDataAvailable'),
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
                                context,
                                AppRoutes.guestCheckIn,
                                arguments: {"service": service},
                              ).then(
                                (value) {
                                  if (value == true) {
                                    context
                                        .read<DashboardCubit>()
                                        .refreshData(context);
                                  }
                                },
                              );
                            },
                            serviceableCheckInOnPressed: () {
                              context
                                  .read<CheckInsCubit>()
                                  .onChangeSelectedVisitorType(
                                      AppUtils.getServiceableType(
                                          Strings.keyServices));
                              context
                                  .read<CheckInsCubit>()
                                  .onChangeSelectedServiceableId(service?.id);
                              context.read<CheckInsCubit>().getCheckIns();
                              Navigator.pushNamed(
                                  context, AppRoutes.serviceableCheckIns);
                            },
                            detailsOnPressed: () {
                              context
                                  .read<ServiceDetailsCubit>()
                                  .getServiceDetails(serviceId: service?.id);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AppUtils.getRouteName(service),
                                  ));
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(10);
                        },
                      ),
                const Gap(10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppUtils.languageTranslate("workOrderRFPs"),
                      style: AppTextStyles.style19Primary600,
                    ),
                    const Gap(20),
                    CustomButton(
                        buttonColor: AppColors.primary,
                        text: AppUtils.languageTranslate("viewAll"),
                        height: 42,
                        width: 230,
                        imageHeight: 22,
                        borderRadius: 6,
                        image: AppImages.view,
                        onPressed: () {
                          onViewAllDashboardPressed(
                              context, AppConstants.workOrderRfpIndex);
                        }),
                  ],
                ),
                const Gap(10),
                state.workOrderModel?.isEmpty ?? true
                    ? SizedBox(
                        height: 100,
                        child: EmptyWidget(
                          text: AppUtils.languageTranslate('noDataAvailable'),
                        ),
                      )
                    : ListView.separated(
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.workOrderModel?.length ?? 0,
                        itemBuilder: (context, index) {
                          WorkOrderModel? workOrder =
                              state.workOrderModel?[index];
                          return WorkOrderRFPCardWidget(
                            isAwarded: workOrder?.isAwarded,
                            isActiveCheckins:
                                (workOrder?.activeCheckIns?.isNotEmpty ?? true)
                                    ? true
                                    : false,
                            typeAssetImage: AppImages.hammer,
                            status: workOrder?.status ?? "--",
                            title: workOrder?.title ?? "--",
                            reference: workOrder?.reference ?? "--",
                            vendorName:
                                workOrder?.newVendor?.companyName ?? "--",
                            createdDate: DateTimeUtil.getFormattedDate(
                                workOrder?.startDate),
                            updatedDate: DateTimeUtil.getFormattedDate(
                                workOrder?.finishDate),
                            checkInPressed: () {
                              Navigator.pushNamed(
                                context,
                                AppRoutes.guestCheckIn,
                                arguments: {
                                  "work_order": workOrder,
                                },
                              ).then(
                                (value) {
                                  if (value == true) {
                                    context
                                        .read<DashboardCubit>()
                                        .refreshData(context);
                                  }
                                },
                              );
                            },
                            detailsOnPressed: () {
                              context
                                  .read<WorkOrderDetailsCubit>()
                                  .getWorkOrderDetails(
                                      workOrderId: workOrder?.id);
                              Navigator.pushNamed(
                                  context, AppRoutes.workOrderJobDetails);
                            },
                            jobCheckInOnPressed: () {
                              context
                                  .read<CheckInsCubit>()
                                  .onChangeSelectedVisitorType(
                                      AppUtils.getServiceableType(
                                          Strings.keyWorkOrder));
                              context
                                  .read<CheckInsCubit>()
                                  .onChangeSelectedServiceableId(workOrder?.id);
                              context.read<CheckInsCubit>().getCheckIns();
                              Navigator.pushNamed(
                                  context, AppRoutes.jobCheckIns);
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
        ),
      );
    });
  }

  void onViewVisitorPasses(BuildContext context) {
    context.read<VisitorPassCubit>().resetFilterData();
    context.read<VisitorPassCubit>().getVisitorPasses();
    Navigator.pushNamed(context, AppRoutes.visitorPasses);
  }

  void onViewAllDashboardPressed(BuildContext context, int targetIndex) {
    final cubit = context.read<MainDashboardCubit>();
    if (targetIndex == AppConstants.checkInsIndex) {
      context.read<CheckInsCubit>().resetFilterData();
      context.read<CheckInsCubit>().getCheckIns();
      cubit.onChangeSelectedIndex(AppConstants.checkInsIndex);
    } else if (targetIndex == AppConstants.eServicesIndex) {
      context.read<ServiceCubit>().resetFilterData();
      context.read<ServiceCubit>().getServices();
      cubit.onChangeSelectedIndex(AppConstants.eServicesIndex);
    } else if (targetIndex == AppConstants.workOrderRfpIndex) {
      context.read<WorkOrderCubit>().resetFilterData();
      context.read<WorkOrderCubit>().getWorkOrder();
      cubit.onChangeSelectedIndex(AppConstants.workOrderRfpIndex);
    } else if (targetIndex == AppConstants.checkOutsIndex) {
      context.read<CheckOutCubit>().onChangeSelectedRange('Last 30 Days');
      context.read<CheckOutCubit>().onChangeDateRange(
          AppUtils.getDateRangeStringFromLabel('Last 30 Days'));
      context.read<CheckOutCubit>().getCheckOuts();
      cubit.onChangeSelectedIndex(AppConstants.checkOutsIndex);
    } else {}
  }
}
