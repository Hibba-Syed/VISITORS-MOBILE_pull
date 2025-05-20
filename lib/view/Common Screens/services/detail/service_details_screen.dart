import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/e_service/details/service_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/Common%20Screens/services/components/services_documents_card_widget.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
import 'package:visitors/view/widgets/text%20field/text_field_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../../model/service/document_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../widgets/empty_widget.dart';

class ServiceDetailsScreen extends StatelessWidget {
  const ServiceDetailsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: const AppBarWidget(
          title: 'Service Details',
          titleColor: AppColors.black,
          iconColor: AppColors.black,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding),
          child: SingleChildScrollView(
            child: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
              builder: (context, state) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: HeadingWidget(
                            heading: AppUtils.getRequestName(
                                state.serviceDetails?.applicationType ?? ""),
                          ),
                        ),
                        StatusWidget(
                            status: state.serviceDetails?.status ?? ""),
                      ],
                    ),
                    const Gap(3),
                    HeadingWidget(
                      heading: state.serviceDetails?.reference ?? "",
                      style: AppTextStyles.style14Black600,
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
                              title: 'Contractor Name',
                              value: state.serviceDetails?.application
                                      ?.contractorName ??
                                  ""),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Contractor Phone',
                            value: state.serviceDetails?.application
                                    ?.contractorPhone ??
                                "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              title: 'Start Date',
                              value: DateTimeUtil.getFormattedDatesTime(state
                                  .serviceDetails?.application?.startDate)),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Contractor Contact Person',
                            value: state.serviceDetails?.application
                                    ?.contactPerson ??
                                "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'No. of Staff Expected',
                            value: state.serviceDetails?.application
                                    ?.noOfStaffExpected
                                    ?.toString() ??
                                "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'End Date',
                            value: DateTimeUtil.getFormattedDatesTime(
                                state.serviceDetails?.application?.endDate),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: '	Security Deposit',
                            value: state.serviceDetails?.securityDeposit
                                    ?.toString() ??
                                "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            isLast: true,
                            title: 'Temporary Electricity Required',
                            valueIcon: Icons.clear,
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    const HeadingWidget(
                      heading: 'Documents',
                    ),
                    const Gap(10),
                    Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.isDocumentLoading
                            ? LoaderWidget()
                            :
                            // state.serviceDetails?.documents?.isNotEmpty ?? true ?
                            ListView.separated(
                                shrinkWrap: true,
                                primary: false,
                                itemCount:
                                    state.serviceDetails?.documents?.length ??
                                        0,
                                itemBuilder: (context, index) {
                                  Document? document =
                                      state.serviceDetails?.documents?[index];
                                  return ServicesDocumentsCardWidget(
                                    name: document?.name,
                                    url: document?.pathUrl ?? "",
                                  );
                                },
                                separatorBuilder: (context, index) {
                                  return Divider(
                                    color: AppColors.gray,
                                  );
                                },
                              ) //: EmptyWidget(text: 'No data available',) ,
                        ),
                    const Gap(20),
                    const HeadingWidget(
                      heading: 'Applicant Details',
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
                              title: 'Requester Type',
                              value: state.serviceDetails?.clientType ?? ""),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Name',
                            value: state.serviceDetails?.clientName ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Phone',
                            value: state.serviceDetails?.clientPhone ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Email',
                            value: state.serviceDetails?.clientEmail ?? "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              title: 'Passport Number',
                              value: state.serviceDetails?.passportNumber
                                      ?.toString() ??
                                  ""),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Passport Expiry',
                            value: DateTimeUtil.getFormattedDate(
                                state.serviceDetails?.clientIdExpiry),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'ID Number',
                            value: state.serviceDetails?.clientIdNumber
                                    ?.toString() ??
                                "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            isLast: true,
                            title: 'ID Expiry',
                            value: DateTimeUtil.getFormattedDate(
                                state.serviceDetails?.clientIdExpiry),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    const Text(
                      'Activity Log',
                      style: AppTextStyles.style20primary600,
                    ),
                    const Gap(10),
                    state.isStatusLoading ? LoaderWidget() :
                        state.serviceDetails?.statusHistory?.isNotEmpty ?? true ?
                    ListView.separated(
                      shrinkWrap: true,
                      primary: false,
                      itemCount:
                          state.serviceDetails?.statusHistory?.length ?? 0,
                      itemBuilder: (context, index) {
                        StatusHistory? statusHistory = state.serviceDetails?.statusHistory?[index];
                        return ActivityLogWidget(
                          horizontalPadding: 8,
                          isLast: true,
                          status: statusHistory?.status ?? "",
                          byValue:  (statusHistory?.user?.fullName != null && statusHistory!.user!.fullName!.isNotEmpty)
                              ?  statusHistory.user?.fullName ?? ""
                              : " System",
                          description: statusHistory?.note
                              ?.replaceAll('\n\n', ' ')
                              .trim()
                              .split('.')
                              .first
                              .trim(),

                          dateTime: DateTimeUtil.getFormattedDatesTime(statusHistory?.createdAt),
                        );
                      },
                      separatorBuilder: (context, index) {
                        return Gap(10);
                      },
                    ) : EmptyWidget(text: 'No data available',),
                  ],
                );
              },
            ),
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: AppConstants.horizontalPadding,
              vertical: AppConstants.horizontalPadding),
          child: Row(
            children: [
              Expanded(
                child: CustomButton(
                    height: AppUtils.isTablet(context) ? 55 : 42,
                    fontSize: AppUtils.isTablet(context) ? 20 : 15,
                    text: 'Add Log',
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            TextEditingController noteController0 =
                                TextEditingController();
                            return CustomAlertDialogBox(
                              isCancelButtonDisable: true,
                              insetPadding: AppUtils.isTablet(context)
                                  ? EdgeInsets.symmetric(horizontal: 35)
                                  : EdgeInsets.symmetric(horizontal: 10),
                              title: 'Add Log to JB001-24-00102',
                              confirmButtonText: 'Add Log',
                              onConfirm: () async {
                                return false;
                              },
                              contentBuilder: (context, setState) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Gap(5),
                                    SvgPicture.asset(
                                      AppImages.question,
                                      height: 35,
                                      width: 35,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.primary,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      controller: noteController0,
                                      label: 'Note*',
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
              const Gap(10),
              Expanded(
                child: CustomButton(
                    buttonColor: AppColors.green,
                    height: AppUtils.isTablet(context) ? 55 : 42,
                    fontSize: AppUtils.isTablet(context) ? 20 : 15,
                    text: 'Complete',
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            TextEditingController noteController =
                                TextEditingController();
                            TextEditingController nameController =
                                TextEditingController();
                            TextEditingController idController =
                                TextEditingController();
                            return CustomAlertDialogBox(
                              insetPadding: AppUtils.isTablet(context)
                                  ? EdgeInsets.symmetric(horizontal: 35)
                                  : EdgeInsets.symmetric(horizontal: 10),
                              title: 'Complete HB2024080725',
                              disableCancelButtonBorder: true,
                              cancelButtonTextColor: AppColors.white,
                              cancelButtonColor: AppColors.green,
                              cancelButtonText: 'Complete',
                              confirmButtonText: 'Scan ID',
                              confirmButtonColor: AppColors.primary,
                              onConfirm: () async {
                                return false;
                              },
                              contentBuilder: (context, setState) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const Gap(5),
                                    SvgPicture.asset(
                                      AppImages.question,
                                      height: 35,
                                      width: 35,
                                      colorFilter: const ColorFilter.mode(
                                        AppColors.green,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      label: 'Requester Name',
                                      controller: nameController,
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      label: 'ID Number',
                                      controller: idController,
                                    ),
                                    const Gap(5),
                                    TextFieldWidget(
                                      controller: noteController,
                                      label: 'Note*',
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
