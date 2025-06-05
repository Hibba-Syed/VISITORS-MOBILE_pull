import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/e_service/details/service_details_cubit.dart';
import '../../../../model/service/service_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/app_constants.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/date_time.dart';
import '../../../widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import '../../../widgets/activity log/activity_log_widget.dart';
import '../../../widgets/app_bar/appbar_widget.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/container_widgets/title_value_row_divider_details_container.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/heading_widget.dart';
import '../../../widgets/loader/loader_widget.dart';
import '../../../widgets/status/status_widget.dart';
import '../../../widgets/text field/text_field_widget.dart';

class FacilityBookingServiceDetailsScreen extends StatefulWidget {
  final ServiceModel? service;
  const FacilityBookingServiceDetailsScreen({super.key, required this.service});

  @override
  State<FacilityBookingServiceDetailsScreen> createState() =>
      _FacilityBookingServiceDetailsScreenState();
}

class _FacilityBookingServiceDetailsScreenState
    extends State<FacilityBookingServiceDetailsScreen> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();

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
                if (state.isLoading) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: MediaQuery.of(context).size.height / 3),
                    child: LoaderWidget(),
                  );
                }
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
                              title: 'Facility',
                              value:
                                  state.serviceDetails?.application?.facility ??
                                      ""),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Nature of function',
                            value: state.serviceDetails?.application
                                    ?.natureOfFunction ??
                                "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              title: 'Expected Guests',
                              value: state.serviceDetails?.application
                                      ?.expectedGuests
                                      ?.toString() ??
                                  ''),
                          TitleValueRowDividerDetailsContainerWidget(
                              title: 'Booking Date',
                              value: DateTimeUtil.getFormattedDate(state
                                  .serviceDetails?.application?.bookingDate)),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: 'Start Time',
                            value:
                                state.serviceDetails?.application?.startTime ??
                                    "",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              isLast: true,
                              title: 'End Time',
                              value:
                                  state.serviceDetails?.application?.endTime ??
                                      ''),
                        ],
                      ),
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
                    state.serviceDetails?.statusHistory?.isNotEmpty ?? true
                        ? Container(
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListView.builder(
                              padding: EdgeInsets.only(top: 10),
                              shrinkWrap: true,
                              primary: false,
                              itemCount:
                                  state.serviceDetails?.statusHistory?.length ??
                                      0,
                              itemBuilder: (context, index) {
                                StatusHistory? statusHistory =
                                    state.serviceDetails?.statusHistory?[index];
                                bool isLast = (state.serviceDetails
                                                ?.statusHistory?.length ??
                                            0) -
                                        1 ==
                                    index;
                                return ActivityLogWidget(
                                  horizontalPadding: 8,
                                  isLast: isLast,
                                  status: (statusHistory?.status != 'Pending')
                                      ? statusHistory?.status ?? ""
                                      : "Request Received",
                                  byValue: (statusHistory?.user?.fullName !=
                                              null &&
                                          statusHistory!
                                              .user!.fullName!.isNotEmpty)
                                      ? ' ${statusHistory.user?.fullName ?? ""}'
                                      : " System",
                                  description: statusHistory?.note
                                      ?.replaceAll('\n\n', ' ')
                                      .trim()
                                      .split('.')
                                      .first
                                      .trim(),
                                  dateTime: DateTimeUtil.getFormattedDatesTime(
                                      statusHistory?.createdAt),
                                );
                              },
                            ),
                          )
                        : EmptyWidget(
                            text: 'No data available',
                          ),
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
                    text: 'Add Log',
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogBox(
                              isCancelButtonDisable: true,
                              insetPadding: AppUtils.isTablet(context)
                                  ? EdgeInsets.symmetric(horizontal: 35)
                                  : EdgeInsets.symmetric(horizontal: 10),
                              title:
                                  'Add Log to ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference ?? ""}',
                              confirmButtonText: 'Add Log',
                              onConfirm: () async {
                                if (_noteController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: "Please type note first.");
                                  return false;
                                }
                                // print('add^^^${noteController.text}');
                                final result = await context
                                    .read<ServiceDetailsCubit>()
                                    .addServiceLog(
                                  context,
                                  data: {
                                    'application_id':
                                        '${context.read<ServiceDetailsCubit>().state.serviceDetails?.id}',
                                    'note': _noteController.text,
                                  },
                                );
                                _noteController.clear();

                                return result;
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
                                      controller: _noteController,
                                      label: 'Note*',
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
              if (context
                      .read<ServiceDetailsCubit>()
                      .state
                      .serviceDetails?.application
                      ?.securityDeposit ==
                  null) ...[
                const Gap(10),
                Expanded(
                  child: CustomButton(
                      buttonColor: AppColors.green,
                      text: 'Complete',
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
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
                                  if (_nameController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please type name first.");
                                    return false;
                                  }
                                  if (_idController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                        msg: "Please type id first.");
                                    return false;
                                  }
                                  final result = await context
                                      .read<ServiceDetailsCubit>()
                                      .completeService(
                                    context,
                                    data: {
                                      'id':
                                          '${context.read<ServiceDetailsCubit>().state.serviceDetails?.id}',
                                      'requester_name': _nameController.text,
                                      'id_number': _idController.text,
                                      'note': _noteController.text,
                                    },
                                  );
                                  _noteController.clear();
                                  _idController.clear();
                                  _nameController.clear();

                                  return result;
                                },
                                contentBuilder: (context, setState) {
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                        controller: _nameController,
                                      ),
                                      const Gap(5),
                                      TextFieldWidget(
                                        label: 'ID Number',
                                        controller: _idController,
                                      ),
                                      const Gap(5),
                                      TextFieldWidget(
                                        controller: _noteController,
                                        label: 'Note*',
                                      ),
                                    ],
                                  );
                                },
                              );
                            });
                      }),
                )
              ],
            ],
          ),
        ),
      ),
    );
  }
}
