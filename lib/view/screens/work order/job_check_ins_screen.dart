import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/all_check_out_design_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../../model/check_ins/check_in_model.dart';
import '../../../utils/routes/app_routes.dart';
import '../check_ins/componants/check_in_card_widget.dart';

class JobCheckInsScreen extends StatelessWidget {
  const JobCheckInsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppUtils.languageTranslate('jobCheckIns'),
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding),
        child: BlocBuilder<CheckInsCubit, CheckInsState>(
          builder: (context, state) {
            return Column(
              children: [
                const Gap(20),
                if(state.checkIns?.isNotEmpty??false)
                Align(
                  alignment: Alignment.bottomRight,
                  child: CustomButton(
                      buttonColor: AppColors.red,
                      text: AppUtils.languageTranslate('checkoutAll'),
                      height: AppUtils.isTablet(context) ? 43 : 42,
                      width: AppUtils.isTablet(context) ? 200 : 150,
                      borderRadius: 6,
                      image: AppImages.logoutCard,
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogBox(
                              onSecondButtonPressed: () {
                                return context
                                    .read<CheckInsCubit>()
                                    .checkOutAll(context);
                              },
                              insetPadding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              isFirstButtonDisable: true,
                              secondButtonColor: AppColors.red,
                              secondButtonText:
                                  AppUtils.languageTranslate('yes'),
                              title: AppUtils.languageTranslate(
                                  'checkOutForAllCheckIns'),
                              contentBuilder: (context, setState) {
                                return const Align(
                                  alignment: Alignment.center,
                                  child: AllCheckOutDesignWidget(),
                                );
                              },
                            );
                          },
                        );
                      }),
                ),
                const Gap(15),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      context.read<CheckInsCubit>().getCheckIns();
                    },
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 10),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.checkIns?.length ?? 0,
                      itemBuilder: (context, index) {
                        CheckInModel? checkIn = state.checkIns?[index];
                        return CheckInCardWidget(
                          phone: checkIn?.phone ?? "--",
                          isServiceable: true,
                          count: checkIn?.visitorCount ?? "",
                          reference: checkIn?.purpose ?? "--",
                          typeImage: (checkIn?.type?.toLowerCase() ==
                              'community visit' ||
                              checkIn?.type?.toLowerCase() ==
                                  'community service')
                              ? AppImages.community
                              : (checkIn?.type?.toLowerCase() ==
                              'unit visit' ||
                              checkIn?.type?.toLowerCase() ==
                                  'unit service')
                              ? AppImages.unit
                              : "",
                          typeText:
                              (checkIn?.type?.toLowerCase() == 'unit visit' ||
                                      checkIn?.type?.toLowerCase() ==
                                          'unit service')
                                  ? checkIn?.unit?.unitNumber
                                  : checkIn?.type ?? "--",
                          name: checkIn?.name ?? "--",
                          profileImageUrl: checkIn?.visitor?.imageUrl ?? "",
                          type:
                              AppUtils.getServiceableType(checkIn?.type).label,
                          createdDate: DateTimeUtil.getFormattedDateTime(
                              checkIn?.createdAt.toString()),
                          purpose: checkIn?.description ?? "--",
                          isMobile: checkIn?.isMobile,
                          checkOutOnPressed: () {
                            context
                                .read<CheckInsDetailsCubit>()
                                .getCheckInDetailsLog(id: checkIn?.id);
                            _showCheckoutDialog(context, checkIn);
                          },
                          detailsOnPressed: () {
                            context
                                .read<CheckInsDetailsCubit>()
                                .getCheckInDetailsLog(id: checkIn?.id);
                            Navigator.pushNamed(
                                context, AppRoutes.checkInDetails,
                                arguments: state.checkIns?[index]);
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const Gap(10);
                      },
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CheckInModel? checkIns) {
    final TextEditingController visitorsNoController = TextEditingController();
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
                            .read<CheckInsCubit>()
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
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        isFirstButtonDisable: true,
                        secondButtonColor: AppColors.red,
                        secondButtonText:
                            AppUtils.languageTranslate('checkout'),
                        title:
                            AppUtils.languageTranslate('checkOutForVisitors'),
                        onSecondButtonPressed: () async {
                          final result = await context
                              .read<CheckInsCubit>()
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
}
