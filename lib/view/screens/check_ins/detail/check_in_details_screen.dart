import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/validation_util.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/stack_count_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/mobile_web_icon_widget.dart';
import 'package:visitors/view/widgets/read_more_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../../../model/log_model.dart';
import '../../../../model/check_ins/check_in_model.dart';

class CheckInDetailsScreen extends StatelessWidget {
  CheckInDetailsScreen({super.key});

  final TextEditingController visitorsNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CheckInModel? checkIn =
        ModalRoute.of(context)?.settings.arguments as CheckInModel?;
    return Scaffold(
      appBar: AppBarWidget(
        title: AppUtils.languageTranslate('checkInDetails'),
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: BlocBuilder<CheckInsCubit, CheckInsState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(20),
                  Align(
                    alignment: Alignment.center,
                    child: StackCountContainerWidget(
                      count: checkIn?.visitorCount ?? "",
                      imageUrl: checkIn?.visitor?.imageUrl ?? "",
                      imageBackgroundColor: AppColors.darkGrey.withAlpha(25),
                    ),
                  ),
                  const Gap(5),
                  HeadingWidget(
                    heading:
                        '${AppUtils.getServiceableType(checkIn?.serviceableType).label} ${AppUtils.languageTranslate('details')}',
                  ),
                  (checkIn?.serviceableType == "job" ||
                          checkIn?.serviceableType == "application")
                      ? Text(
                          checkIn?.purpose ?? "",
                          style: AppTextStyles.style16Black500,
                        )
                      : SizedBox.shrink(),
                  const Gap(10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('name'),
                          value: checkIn?.name ?? "--",
                        ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('phone'),
                          value: checkIn?.phone ?? "--",
                        ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('email'),
                          value: checkIn?.email ?? "--",
                        ),
                        if (checkIn?.unit?.unitNumber?.isNotEmpty ?? false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('unit'),
                            value: checkIn?.unit?.unitNumber ?? "--",
                          ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate(
                              'currentVisitorsCount'),
                          value: checkIn?.visitorCount ?? "--",
                        ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('visitPurpose'),
                          value: ValidationUtil.isValid(checkIn?.purpose)
                              ? checkIn?.purpose
                              : "--",
                        ),
                        if (checkIn?.vendor?.name?.isNotEmpty ?? false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('vendorName'),
                            value: checkIn?.vendor?.name ?? "--",
                          ),
                        if (checkIn?.visitor?.idNumber?.isNotEmpty ?? false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title:
                                AppUtils.languageTranslate('emiratesIdNumber'),
                            value: checkIn?.visitor?.idNumber ?? "--",
                          ),
                        if (checkIn?.visitor?.idIssueDate != null)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate(
                                'emiratesIdIssueDate'),
                            value: DateTimeUtil.getFormattedDate(
                                checkIn?.visitor?.idIssueDate),
                          ),
                        if (checkIn?.visitor?.idExpiryDate != null)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate(
                                'emiratesIdExpiryDate'),
                            value: DateTimeUtil.getFormattedDate(
                                checkIn?.visitor?.idExpiryDate),
                          ),
                        if (checkIn?.visitor?.photoIdNumber?.isNotEmpty ??
                            false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('photoIdNumber'),
                            value: checkIn?.visitor?.photoIdNumber ?? "--",
                          ),
                        if (checkIn?.visitor?.photoIdIssueDate?.isNotEmpty ??
                            false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title:
                                AppUtils.languageTranslate('photoIdIssueDate'),
                            value: DateTimeUtil.getFormattedDate(
                                checkIn?.visitor?.photoIdIssueDate),
                          ),
                        if (checkIn?.visitor?.photoIdExpiryDate?.isNotEmpty ??
                            false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title:
                                AppUtils.languageTranslate('photoIdExpiryDate'),
                            value: DateTimeUtil.getFormattedDate(
                                checkIn?.visitor?.photoIdExpiryDate),
                          ),
                        if (checkIn?.visitor?.passportNumber?.isNotEmpty ??
                            false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate(
                                'travelDocumentNumber'),
                            value: checkIn?.visitor?.passportNumber ?? "--",
                          ),
                        if (checkIn?.visitor?.passportIssueDate?.isNotEmpty ??
                            false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate(
                                'travelDocumentIssueDate'),
                            value: DateTimeUtil.getFormattedDate(
                                checkIn?.visitor?.passportIssueDate),
                          ),
                        if (checkIn?.visitor?.passportExpiryDate?.isNotEmpty ??
                            false)
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate(
                                'travelDocumentExpiryDate'),
                            value: DateTimeUtil.getFormattedDate(
                                checkIn?.visitor?.passportExpiryDate),
                          ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('entryCardNumber'),
                          value: checkIn?.entryCardNumber ?? "--",
                        ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('nationality'),
                          value: checkIn?.visitor?.nationality ?? "--",
                        ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('checkInTime'),
                          value: DateTimeUtil.getFormattedDateTime(
                              checkIn?.checkinTime),
                        ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('checkInGate'),
                          value: checkIn?.checkinGate ?? "--",
                        ),
                        TitleValueRowDividerDetailsContainerWidget(
                          title: AppUtils.languageTranslate('medium'),
                          valueWidget: Align(
                            alignment: Alignment.centerLeft,
                            child: MobileWebIconWidget(
                              isMobile: checkIn?.isMobile ?? false,
                              isDecorationEnabled: false,
                              iconColor: AppColors.darkGrey,
                            ),
                          ),
                        ),
                        Align(
                          alignment: context.locale.languageCode == 'en'
                              ? Alignment.topLeft
                              : Alignment.topRight,
                          child: ReadMoreWidget(
                            title: AppUtils.languageTranslate('description'),
                            valueText: checkIn?.description ?? "--",
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Gap(20),
                  Text(
                    AppUtils.languageTranslate('checkInLog'),
                    style: AppTextStyles.style20primary600,
                  ),
                  const Gap(10),
                  BlocBuilder<CheckInsDetailsCubit, CheckInsDetailsState>(
                    builder: (context, state) {
                      if (state.isLoading) {
                        return LoaderWidget();
                      }
                      return Container(
                        padding: EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: ListView.builder(
                          //physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.checkInLogs?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            LogModel? checkInLogRecord =
                                state.checkInLogs?[index];
                            bool isLast =
                                (state.checkInLogs?.length ?? 0) - 1 == index;
                            return ActivityLogWidget(
                              isLast: isLast ? true : false,
                              status: checkInLogRecord?.status ?? "--",
                              byValue: '',
                              description:
                                  checkInLogRecord?.description ?? "--",
                              dateTime: DateTimeUtil.getFormattedDateTime(
                                  checkInLogRecord?.createdAt),
                            );
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.horizontalPadding,
            vertical: AppConstants.horizontalPadding),
        child: CustomButton(
            image: AppImages.logoutCard,
            buttonColor: AppColors.red,
            text: AppUtils.languageTranslate('checkout'),
            onPressed: () {
              context
                  .read<CheckInsDetailsCubit>()
                  .getCheckInDetailsLog(id: checkIn?.id);
              _showCheckoutDialog(context, checkIn);
            }),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CheckInModel? checkIns) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title:
              '${AppUtils.languageTranslate('checkoutFor')} ${checkIns?.name ?? "--"}',
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
                            .read<CheckInsDetailsCubit>()
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
                          "availableCountIs $availableCount"));
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
                        secondButtonText: AppUtils.languageTranslate("yes"),
                        secondButtonTextFontSize:
                            AppUtils.isTablet(context) ? 15 : 13,
                        title:
                            AppUtils.languageTranslate('checkoutForVisitors'),
                        onSecondButtonPressed: () async {
                          final result = await context
                              .read<CheckInsDetailsCubit>()
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
