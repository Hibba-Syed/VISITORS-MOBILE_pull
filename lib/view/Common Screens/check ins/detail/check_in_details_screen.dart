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
  const CheckInDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    CheckInModel? checkInsModel =
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
                        count: checkInsModel?.visitorCount ?? "",
                        imageUrl: checkInsModel?.visitor?.imageUrl ?? "",
                        imageBackgroundColor: AppColors.darkGrey.withAlpha(25),
                      ),
                    ),
                    const Gap(5),
                     HeadingWidget(
                      heading: '${AppUtils.getServiceableType(
                          checkInsModel?.serviceableType)
                          .label} ${checkInsModel?.purpose ?? ""} Details',
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
                            value: checkInsModel?.name ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Phone',
                            value: checkInsModel?.phone ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Email',
                            value: checkInsModel?.email ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Unit',
                            value: checkInsModel?.unit?.unitNumber ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Current Visitors Count',
                            value: checkInsModel?.visitorCount ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Visit Purpose',
                            value: checkInsModel?.purpose ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Entry Card Number',
                            value: checkInsModel?.entryCardNumber ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Nationality',
                            value: checkInsModel?.visitor?.nationality ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Check-In Time',
                            value: DateTimeUtil.getFormattedDatesTime(
                                checkInsModel?.checkinTime),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Check-In Gate',
                            value: checkInsModel?.checkinGate ?? "",
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: ReadMoreWidget(
                                title: 'Description',
                                valueText: checkInsModel?.description ?? ""),
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
                        return ListView.separated(
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.checkInLogModel?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            CheckInLogModel? checkInLogRecord = state.checkInLogModel?[index];
                            return ActivityLogWidget(
                              isLast: true,
                              status: checkInLogRecord?.status ?? "",
                              byValue: '',
                              description: checkInLogRecord?.description ?? "",
                              dateTime: DateTimeUtil.getFormattedDateTime(checkInLogRecord?.createdAt.toString()),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return Divider(
                              color: AppColors.gray,
                            );
                          },
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
                _showCheckoutDialog(context);
              }),
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
              visitorsCount: 11,
              horizontalPadding: 0,
              checkOutAllOnPress: () {},
              checkOutOnPress: () {},
              logIsLast: true,
              logDate: "2025-04-04T05:33:36.000000Z",
              controller: visitorsNoController,
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
