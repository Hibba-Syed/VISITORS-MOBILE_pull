import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/e_service/details/service_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/screens/guest_check_in/guest_check_in_screen.dart';
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

import '../../../../model/emirates_id_model.dart';
import '../../../../model/service/document_model.dart';
import '../../../../model/service/service_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../../service/scaner/scanner_service.dart';
import '../../../widgets/empty_widget.dart';
import '../components/add_log_action_design_widget.dart';
import '../components/complete_action_design_widget.dart';
import '../components/services_documents_card_widget.dart';

class FitOutServiceDetailsScreen extends StatefulWidget {
  final ServiceModel? service;
  const FitOutServiceDetailsScreen({super.key, this.service});

  @override
  State<FitOutServiceDetailsScreen> createState() =>
      _FitOutServiceDetailsScreenState();
}

class _FitOutServiceDetailsScreenState
    extends State<FitOutServiceDetailsScreen> {
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _idController = TextEditingController();
  final GlobalKey<FormState> _actionFormKey = GlobalKey<FormState>();

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
                              title:
                                  AppUtils.languageTranslate('contractorName'),
                              value: state.serviceDetails?.application
                                      ?.contractorName ??
                                  "--"),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:
                                AppUtils.languageTranslate('contractorPhone'),
                            value: state.serviceDetails?.application
                                    ?.contractorPhone ??
                                "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                              title: AppUtils.languageTranslate('startDate'),
                              value: DateTimeUtil.getFormattedDateTime(state
                                  .serviceDetails?.application?.startDate)),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate(
                                'contractorContactPerson'),
                            value: state.serviceDetails?.application
                                    ?.contactPerson ??
                                "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate(
                                'numberOfStaffExpected'),
                            value: state.serviceDetails?.application
                                    ?.noOfStaffExpected
                                    ?.toString() ??
                                "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title: AppUtils.languageTranslate('endDate'),
                            value: DateTimeUtil.getFormattedDateTime(
                                state.serviceDetails?.application?.endDate),
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            title:
                                AppUtils.languageTranslate('securityDeposit'),
                            value: state.serviceDetails?.securityDeposit
                                    ?.toString() ??
                                "--",
                          ),
                          TitleValueRowDividerDetailsContainerWidget(
                            isLast: true,
                            title: AppUtils.languageTranslate(
                                'temporaryElectricityRequired'),
                            valueIcon: Icons.clear,
                          ),
                        ],
                      ),
                    ),
                    if (state.serviceDetails?.documents?.isNotEmpty ??
                        true) ...[
                      const Gap(20),
                      HeadingWidget(
                        heading: AppUtils.languageTranslate('documents'),
                      ),
                      const Gap(10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 7, vertical: 10),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: state.serviceDetails?.documents?.isNotEmpty ??
                                true
                            ? ListView.separated(
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
                              )
                            : EmptyWidget(
                                text: AppUtils.languageTranslate(
                                    'noDataAvailable')),
                      ),
                    ],
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
                    buttonColor: AppColors.cyanBlue,
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
                                  '${AppUtils.languageTranslate('addLogTo')} ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference ?? ""}',
                              secondButtonText:
                                  AppUtils.languageTranslate('addLog'),
                              secondButtonColor: AppColors.cyanBlue,
                              onSecondButtonPressed: () async {
                                if (_actionFormKey.currentState?.validate() ??
                                    false) {
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
                                  if(result){
                                    _noteController.clear();
                                  }

                                  return result;
                                }
                                return false;
                              },
                              contentBuilder: (context, setState) {
                                return Form(
                                  key: _actionFormKey,
                                  child: AddLogActionDesignWidget(
                                      noteController: _noteController),
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
                  null) ||(context
                  .read<ServiceDetailsCubit>()
                  .state
                  .serviceDetails
                  ?.securityDeposit ==
                  0))...[
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
                                    '${AppUtils.languageTranslate('complete')} ${context.read<ServiceDetailsCubit>().state.serviceDetails?.reference}',
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
                                  if (_actionFormKey.currentState?.validate() ??
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
                                    key: _actionFormKey,
                                    child: CompleteActionDesignWidget(
                                        nameController: _nameController,
                                        idController: _idController,
                                        noteController: _noteController),
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
