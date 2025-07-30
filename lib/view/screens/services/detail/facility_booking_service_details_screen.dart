import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/e_service/details/service_details_cubit.dart';
import '../../../../model/emirates_id_model.dart';
import '../../../../model/service/service_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/app_constants.dart';
import '../../../../resource/constants/images.dart';
import '../../../../resource/styles/styles.dart';
import '../../../../service/scaner/scanner_service.dart';
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
  final GlobalKey<FormState> _completeFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBarWidget(
          title: AppUtils.languageTranslate('serviceDetails'),
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
                                state.serviceDetails?.applicationType ?? "--"),
                          ),
                        ),
                        StatusWidget(
                            status: state.serviceDetails?.status ?? "--"),
                      ],
                    ),
                    const Gap(3),
                    HeadingWidget(
                      heading: state.serviceDetails?.reference ?? "--",
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
                              title: AppUtils.languageTranslate('facility'),
                              value:
                                  state.serviceDetails?.application?.facility ??
                                      "--"),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:
                                AppUtils.languageTranslate('natureOfFunction'),
                            value: state.serviceDetails?.application
                                    ?.natureOfFunction ??
                                "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              title:
                                  AppUtils.languageTranslate('expectedGuests'),
                              value: state.serviceDetails?.application
                                      ?.expectedGuests
                                      ?.toString() ??
                                  '--'),
                          TitleValueRowDividerDetailsContainerWidget(
                              title: AppUtils.languageTranslate('bookingDate'),
                              value: DateTimeUtil.getFormattedDate(state
                                  .serviceDetails?.application?.bookingDate)),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('startTime'),
                            value:
                                state.serviceDetails?.application?.startTime ??
                                    "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              isLast: true,
                              title: AppUtils.languageTranslate('endTime'),
                              value:
                                  state.serviceDetails?.application?.endTime ??
                                      '--'),
                        ],
                      ),
                    ),
                    const Gap(20),
                    HeadingWidget(
                      heading: AppUtils.languageTranslate('applicantDetails'),
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
                              title:
                                  AppUtils.languageTranslate('requesterType'),
                              value: state.serviceDetails?.clientType ?? "--"),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('name'),
                            value: state.serviceDetails?.clientName ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('phone'),
                            value: state.serviceDetails?.clientPhone ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('email'),
                            value: state.serviceDetails?.clientEmail ?? "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              title:
                                  AppUtils.languageTranslate('passportNumber'),
                              value: state.serviceDetails?.passportNumber
                                      ?.toString() ??
                                  "--"),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('passportExpiry'),
                            value: DateTimeUtil.getFormattedDate(
                                state.serviceDetails?.clientIdExpiry),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('idNumber'),
                            value: state.serviceDetails?.clientIdNumber
                                    ?.toString() ??
                                "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            isLast: true,
                            title: AppUtils.languageTranslate('idExpiry'),
                            value: DateTimeUtil.getFormattedDate(
                                state.serviceDetails?.clientIdExpiry),
                          ),
                        ],
                      ),
                    ),
                    const Gap(20),
                    Text(
                      AppUtils.languageTranslate('activityLog'),
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
                                  dateTime: DateTimeUtil.getFormattedDateTime(
                                      statusHistory?.createdAt),
                                );
                              },
                            ),
                          )
                        : EmptyWidget(
                            text:
                                AppUtils.languageTranslate('noDataAvailable')),
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
                    text: AppUtils.languageTranslate('addLog'),
                    onPressed: () {
                      showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogBox(
                              isFirstButtonDisable: true,
                              insetPadding: AppUtils.isTablet(context)
                                  ? EdgeInsets.symmetric(horizontal: 35)
                                  : EdgeInsets.symmetric(horizontal: 10),
                              title:
                                  'Add Log to ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference ?? ""}',
                              secondButtonText:
                                  AppUtils.languageTranslate('addLog'),
                              onSecondButtonPressed: () async {
                                if (_noteController.text.isEmpty) {
                                  Fluttertoast.showToast(
                                      msg: AppUtils.languageTranslate(
                                          'pleaseTypeNoteFirst'));
                                  return false;
                                }
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
                                      label: AppUtils.languageTranslate('note'),
                                    ),
                                  ],
                                );
                              },
                            );
                          });
                    }),
              ),
              if ((context
                          .read<ServiceDetailsCubit>()
                          .state
                          .serviceDetails
                          ?.securityDeposit ==
                      null) ||
                  (context
                          .read<ServiceDetailsCubit>()
                          .state
                          .serviceDetails
                          ?.securityDeposit ==
                      0)) ...[
                const Gap(10),
                Expanded(
                  child: CustomButton(
                      buttonColor: AppColors.green,
                      text: AppUtils.languageTranslate('complete'),
                      onPressed: () {
                        showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return CustomAlertDialogBox(
                                insetPadding: AppUtils.isTablet(context)
                                    ? EdgeInsets.symmetric(horizontal: 35)
                                    : EdgeInsets.symmetric(horizontal: 10),
                                title:
                                    'Complete ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference ?? ""}',
                                disableFirstButtonBorder: true,
                                firstButtonTextColor: AppColors.white,
                                firstButtonColor: AppColors.primary,
                                firstButtonText: AppUtils.languageTranslate(
                                    'scanEmiratesId'),
                                secondButtonText:
                                    AppUtils.languageTranslate('complete'),
                                secondButtonColor: AppColors.green,
                                onFirstButtonPressed: () async {
                                  EmiratesIdModel? emiratesIdData =
                                      await ScannerService()
                                          .scanEmiratesIdAndPerformOcr();
                                  if (emiratesIdData != null) {
                                    // clearData();

                                    setState(() {
                                      _nameController.text =
                                          emiratesIdData.name ?? '';
                                      _idController.text =
                                          emiratesIdData.idNumber ?? '';
                                    });
                                  }
                                  return false;
                                },
                                onSecondButtonPressed: () async {
                                  if (_completeFormKey.currentState
                                          ?.validate() ??
                                      false) {
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
                                    if (result) {
                                      _noteController.clear();
                                      _idController.clear();
                                      _nameController.clear();
                                    }
                                    return result;
                                  }
                                  return false;
                                },
                                contentBuilder: (context, setState) {
                                  return Form(
                                    key: _completeFormKey,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          label: AppUtils.languageTranslate(
                                              'requesterName'),
                                          controller: _nameController,
                                          validator: (value) {
                                            if (value?.trim().isEmpty ?? true) {
                                              return AppUtils.languageTranslate(
                                                  'fieldIsMandatory');
                                            }
                                            return null;
                                          },
                                        ),
                                        const Gap(5),
                                        TextFieldWidget(
                                          label: AppUtils.languageTranslate(
                                              'idNumber'),
                                          controller: _idController,
                                          validator: (value) {
                                            if (value?.trim().isEmpty ?? true) {
                                              return AppUtils.languageTranslate(
                                                  'fieldIsMandatory');
                                            }
                                            return null;
                                          },
                                        ),
                                        const Gap(5),
                                        TextFieldWidget(
                                          controller: _noteController,
                                          label: AppUtils.languageTranslate(
                                              'servicesNote'),
                                        ),
                                      ],
                                    ),
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
