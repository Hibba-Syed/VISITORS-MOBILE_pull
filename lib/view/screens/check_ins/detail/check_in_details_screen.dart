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
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/stack_count_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/read_more_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../../../model/check_ins/check_in_log_model.dart';
import '../../../../model/check_ins/check_in_model.dart';

class CheckInDetailsScreen extends StatelessWidget {
   CheckInDetailsScreen({super.key});

  final TextEditingController visitorsNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CheckInModel? checkIns =
        ModalRoute.of(context)?.settings.arguments as CheckInModel?;
    return SafeArea(
      child: Scaffold(
        appBar:  AppBarWidget(
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
                        count: checkIns?.visitorCount ?? "",
                        imageUrl: checkIns?.visitor?.imageUrl ?? "",
                        imageBackgroundColor: AppColors.darkGrey.withAlpha(25),
                      ),
                    ),
                    const Gap(5),
                     HeadingWidget(
                      heading: '${AppUtils.getServiceableType(
                          checkIns?.serviceableType)
                          .label} ${AppUtils.languageTranslate('details')}',
                    ),
                    (checkIns?.serviceableType == "job" || checkIns?.serviceableType == "application" ) ?
                    Text(checkIns?.purpose ?? "",style: AppTextStyles.style16Black500,) : SizedBox.shrink(),
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
                            value: checkIns?.name ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('phone'),
                            value: checkIns?.phone ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('email'),
                            value: checkIns?.email ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('unit'),
                            value: checkIns?.unit?.unitNumber ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:  AppUtils.languageTranslate('currentVisitorsCount'),
                            value: checkIns?.visitorCount ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:  AppUtils.languageTranslate('visitPurpose'),
                            value: checkIns?.purpose ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:  AppUtils.languageTranslate('entryCardNumber'),
                            value: checkIns?.entryCardNumber ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:  AppUtils.languageTranslate('nationality'),
                            value: checkIns?.visitor?.nationality ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:  AppUtils.languageTranslate('checkInTime'),
                            value: DateTimeUtil.getFormattedDateTime(
                                checkIns?.checkinTime),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:  AppUtils.languageTranslate('checkInGate'),
                            value: checkIns?.checkinGate ?? "--",
                          ),
                          Align(
                            alignment: context.locale.languageCode == 'en' ?
                            Alignment.topLeft : Alignment.topRight,
                            child: ReadMoreWidget(
                                title:  AppUtils.languageTranslate('description'),
                                valueText: checkIns?.description ?? "--"),
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
                        if(state.isLoading){
                          return LoaderWidget();
                        }
                        return Container(
                          padding: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10)
                          ),
                          child: ListView.builder(
                            //physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            primary: false,
                            itemCount: state.checkInLogs?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              CheckInLogs? checkInLogRecord = state.checkInLogs?[index];
                              bool isLast = (state.checkInLogs?.length ?? 0) - 1 == index;
                              return ActivityLogWidget(
                                isLast: isLast ?  true : false,
                                status: checkInLogRecord?.status ?? "--",
                                byValue: '',
                                description: checkInLogRecord?.description ?? "--",
                                dateTime: DateTimeUtil.getFormattedDateTime(checkInLogRecord?.createdAt),
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
                context.read<CheckInsDetailsCubit>().getCheckInDetailsLog(id: checkIns?.id);
                _showCheckoutDialog(context,checkIns);
              }),
        ),
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
          title: 'Checkout for ${checkIns?.name ?? "--"}',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              visitorsCount: checkIns?.visitorCount ?? "",
              controller: visitorsNoController,
              checkOutAllOnPress: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                      isCancelButtonDisable: true,
                      confirmButtonColor: AppColors.red,
                      confirmButtonText: AppUtils.languageTranslate('checkoutAll'),
                      title: AppUtils.languageTranslate('checkOutForAllCheckIns'),
                      onConfirm: ()async{
                        final result = await context.read<CheckInsDetailsCubit>().checkOutVisitors(context, id: checkIns?.id, data: {
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
              checkOutOnPress: ()async{
                final enteredCount = int.tryParse(visitorsNoController.text.trim());
                final availableCount = int.tryParse(checkIns?.visitorCount ?? '') ?? 0;
                if ( (enteredCount??0) > availableCount) {
                  Fluttertoast.showToast(
                      msg: AppUtils.languageTranslate("availableCountIs $availableCount"));
                  return;
                }
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                        isCancelButtonDisable: true,
                        confirmButtonColor: AppColors.red,
                        confirmButtonText: AppUtils.languageTranslate("checkout"),
                        confirmButtonTextFontSize: AppUtils.isTablet(context) ? 15 : 13,
                        title: AppUtils.languageTranslate('checkoutForVisitors'),
                        onConfirm: ()async{
                          final result = await
                          context.read<CheckInsDetailsCubit>().checkOutVisitors(context, id: checkIns?.id, data: {
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
