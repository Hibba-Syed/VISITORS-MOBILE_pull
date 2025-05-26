import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    // print(
    //     'check in details ${checkInsModel?.name} ${checkInsModel?.visitor?.nationality}');
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Check-In Details',
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
                        countPadding: 5,
                        count: checkIns?.visitorCount ?? "",
                        imageUrl: checkIns?.visitor?.imageUrl ?? "",
                        imageBackgroundColor: AppColors.darkGrey.withAlpha(25),
                      ),
                    ),
                    const Gap(5),
                     HeadingWidget(
                      heading: '${AppUtils.getServiceableType(
                          checkIns?.serviceableType)
                          .label} ${checkIns?.purpose ?? ""} Details',
                    ),
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
                            title: 'Name',
                            value: checkIns?.name ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Phone',
                            value: checkIns?.phone ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Email',
                            value: checkIns?.email ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Unit',
                            value: checkIns?.unit?.unitNumber ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Current Visitors Count',
                            value: checkIns?.visitorCount ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Visit Purpose',
                            value: checkIns?.purpose ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Entry Card Number',
                            value: checkIns?.entryCardNumber ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Nationality',
                            value: checkIns?.visitor?.nationality ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Check-In Time',
                            value: DateTimeUtil.getFormattedDatesTime(
                                checkIns?.checkinTime),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Check-In Gate',
                            value: checkIns?.checkinGate ?? "",
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: ReadMoreWidget(
                                title: 'Description',
                                valueText: checkIns?.description ?? ""),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      'Check-In Log',
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
                            itemCount: state.checkInLogModel?.length ?? 0,
                            itemBuilder: (BuildContext context, int index) {
                              CheckInLogs? checkInLogRecord = state.checkInLogModel?[index];
                              bool isLast = (state.checkInLogModel?.length ?? 0) - 1 == index;
                              return ActivityLogWidget(
                                isLast: isLast ?  true : false,
                                status: checkInLogRecord?.status ?? "",
                                byValue: '',
                                description: checkInLogRecord?.description ?? "",
                                dateTime: DateTimeUtil.getFormattedDatesTime(checkInLogRecord?.createdAt),
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
              fontSize: AppUtils.isTablet(context) ? 20 : 15,
              height: AppUtils.isTablet(context) ? 55 : 42,
              imageHeight: AppUtils.isTablet(context) ? 25 : 18,
              image: AppImages.logoutCard,
              buttonColor: AppColors.red,
              text: 'Check Out',
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
          title: 'Checkout for ${checkIns?.name ?? ""}',
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
                      confirmButtonText: 'Checkout All',
                      title: 'Checkout for All Check-Ins',
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
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                        insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                        isCancelButtonDisable: true,
                        confirmButtonColor: AppColors.red,
                        confirmButtonText: 'Checkout',
                        title: 'Checkout For Visitors',
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
