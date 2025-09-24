import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:visitors/bloc/e_service/details/service_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
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

import '../../../../model/service/service_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../widgets/empty_widget.dart';

class MoveInServiceDetailsScreen extends StatefulWidget {
  final ServiceModel? service;
  const MoveInServiceDetailsScreen({super.key, required this.service});

  @override
  State<MoveInServiceDetailsScreen> createState() =>
      _MoveInServiceDetailsScreenState();
}

class _MoveInServiceDetailsScreenState
    extends State<MoveInServiceDetailsScreen> {
  final TextEditingController _noteController = TextEditingController();
  final GlobalKey<FormState> _noteFormKey = GlobalKey<FormState>();
  XFile? selectedImage;
  String? filePath;
  bool isPaymentReceived = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWidget(
        title: AppUtils.languageTranslate('serviceDetails'),
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return Padding(
              padding: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height / 3),
              child: LoaderWidget(),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: AppConstants.horizontalPadding),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Gap(20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: HeadingWidget(
                                heading: AppUtils.getRequestName(
                                    state.serviceDetails?.applicationType ??
                                        "--"),
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
                                  title: AppUtils.languageTranslate(
                                      'requestedDate'),
                                  value: DateTimeUtil.getFormattedDate(state
                                      .serviceDetails?.application?.moveDate)),
                              TitleValueRowDividerDetailsContainerWidget(
                                title:
                                    AppUtils.languageTranslate('requestedTime'),
                                value:
                                    '${state.serviceDetails?.application?.moveTimeFrom} - ${state.serviceDetails?.application?.moveTimeTo}',
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                  isLast: true,
                                  title: AppUtils.languageTranslate(
                                      'emergencyNumber'),
                                  value: state.serviceDetails?.application
                                          ?.emergencyNumber ??
                                      '--'),
                            ],
                          ),
                        ),
                        if (state.serviceDetails?.securityDeposit != null) ...[
                          const Gap(20),
                          HeadingWidget(
                            heading: AppUtils.languageTranslate(
                                'security_deposit_details'),
                          ),
                          const Gap(10),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 15, horizontal: 10),
                            decoration: BoxDecoration(
                              color: AppColors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: TitleValueRowDividerDetailsContainerWidget(
                              title:
                                  AppUtils.languageTranslate('deposit_amount'),
                              value: state.serviceDetails?.securityDeposit
                                      ?.toString() ??
                                  "--",
                              isLast: true,
                            ),
                          ),
                        ],
                        if ((state.serviceDetails?.application?.mcCompanyName
                                    ?.isNotEmpty ??
                                false) ||
                            (state.serviceDetails
                                    ?.application?.mcContactPerson?.isNotEmpty ??
                                false) ||
                            (state.serviceDetails?.application
                                    ?.mcTradeLicensePathUrl?.isNotEmpty ??
                                false) ||
                            (state.serviceDetails?.application
                                    ?.mcEmiratesPathUrl?.isNotEmpty ??
                                false)) ...[
                          const Gap(20),
                          HeadingWidget(
                            heading: AppUtils.languageTranslate(
                                'movingCompanyDetails'),
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
                                      AppUtils.languageTranslate('companyName'),
                                  value: state.serviceDetails?.application
                                          ?.mcCompanyName ??
                                      "--",
                                ),
                                TitleValueRowDividerDetailsContainerWidget(
                                  title: AppUtils.languageTranslate(
                                      'contactPerson'),
                                  value: state.serviceDetails?.application
                                          ?.mcContactPerson ??
                                      "--",
                                ),
                                TitleValueRowDividerDetailsContainerWidget(
                                  title: AppUtils.languageTranslate(
                                      'companyTradeLicense'),
                                  url: state.serviceDetails?.application
                                          ?.mcTradeLicensePathUrl ??
                                      "--",
                                ),
                                TitleValueRowDividerDetailsContainerWidget(
                                  title: AppUtils.languageTranslate(
                                      'contactPersonEmiratesId'),
                                  url: state.serviceDetails?.application
                                          ?.mcEmiratesPathUrl ??
                                      "--",
                                  isLast: true,
                                ),
                              ],
                            ),
                          ),
                        ],
                        const Gap(20),
                        HeadingWidget(
                          heading:
                              AppUtils.languageTranslate('applicantDetails'),
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
                                  title: AppUtils.languageTranslate(
                                      'requesterType'),
                                  value:
                                      state.serviceDetails?.clientType ?? "--"),
                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate('name'),
                                value: state.serviceDetails?.clientName ?? "--",
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate('phone'),
                                value:
                                    state.serviceDetails?.clientPhone ?? "--",
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                isLast: true,
                                title: AppUtils.languageTranslate('email'),
                                value:
                                    state.serviceDetails?.clientEmail ?? "--",
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                  title: AppUtils.languageTranslate(
                                      'passportNumber'),
                                  value: state.serviceDetails?.passportNumber
                                          ?.toString() ??
                                      "--"),
                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate(
                                    'passportExpiry'),
                                value: DateTimeUtil.getFormattedDate(
                                    state.serviceDetails?.passportExpiry),
                                textColor: ((state.serviceDetails
                                                ?.passportExpiry !=
                                            null) &&
                                        (state.serviceDetails!.passportExpiry!
                                            .isBefore(DateTime.now())))
                                    ? AppColors.red
                                    : null,
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
                                valueColor: AppColors.red,
                                value: DateTimeUtil.getFormattedDate(
                                    state.serviceDetails?.clientIdExpiry),
                                textColor: ((state.serviceDetails
                                                ?.clientIdExpiry !=
                                            null) &&
                                        (state.serviceDetails!.clientIdExpiry!
                                            .isBefore(DateTime.now())))
                                    ? AppColors.red
                                    : null,
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
                                  itemCount: state.serviceDetails?.statusHistory
                                          ?.length ??
                                      0,
                                  itemBuilder: (context, index) {
                                    StatusHistory? statusHistory = state
                                        .serviceDetails?.statusHistory?[index];
                                    bool isLast = (state.serviceDetails
                                                    ?.statusHistory?.length ??
                                                0) -
                                            1 ==
                                        index;
                                    return ActivityLogWidget(
                                      horizontalPadding: 8,
                                      isLast: isLast,
                                      status:
                                          (statusHistory?.status != 'Pending')
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
                                      dateTime:
                                          DateTimeUtil.getFormattedDateTime(
                                              statusHistory?.createdAt),
                                    );
                                  },
                                ),
                              )
                            : EmptyWidget(
                                text: AppUtils.languageTranslate(
                                    'noDataAvailable'),
                              ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalPadding,
                      vertical: AppConstants.horizontalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            buttonColor: AppColors.cyanBlue,
                            text: AppUtils.languageTranslate('addLog'),
                            onPressed: () {
                              AppUtils.addLogServiceAction(
                                context: context,
                                state: state,
                              );
                            }),
                      ),
                      if (((state.serviceDetails?.securityDeposit == null) ||
                              state.serviceDetails?.securityDeposit == 0) &&
                          state.serviceDetails?.status?.toLowerCase() ==
                              'approved') ...[
                        const Gap(10),
                        Expanded(
                            child: CustomButton(
                                buttonColor: AppColors.green,
                                text: AppUtils.languageTranslate('complete'),
                                onPressed: () {
                                  AppUtils.completeServiceAction(
                                    context: context,
                                    state: state,
                                  );
                                })),
                      ],
                      if (state.serviceDetails?.status?.toLowerCase() !=
                          'approved') ...[
                        const Gap(10),
                        Expanded(
                          child: CustomButton(
                              buttonColor: AppColors.yellow,
                              text: AppUtils.languageTranslate('clearPayment'),
                              onPressed: () {
                                _noteController.clear();
                                selectedImage = null;
                                isPaymentReceived = false;
                                showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return CustomAlertDialogBox(
                                        insetPadding: AppUtils.isTablet(context)
                                            ? EdgeInsets.symmetric(
                                                horizontal: 35)
                                            : EdgeInsets.symmetric(
                                                horizontal: 10),
                                        isFirstButtonDisable: true,
                                        title:
                                            '${AppUtils.languageTranslate('clearPaymentFor')} ${state.serviceDetails?.reference}',
                                        disableFirstButtonBorder: true,
                                        secondButtonText:
                                            AppUtils.languageTranslate(
                                                'clearPayment'),
                                        secondButtonColor: AppColors.yellow,
                                        onSecondButtonPressed: () async {
                                          if (_noteFormKey.currentState
                                                  ?.validate() ??
                                              false) {
                                            if (selectedImage?.path.isEmpty ??
                                                true) {
                                              Fluttertoast.showToast(
                                                  msg: AppUtils.languageTranslate(
                                                      'pleaseUploadTheChequeFile'));
                                              return false;
                                            }
                                            if (isPaymentReceived == false) {
                                              Fluttertoast.showToast(
                                                  msg: AppUtils.languageTranslate(
                                                      'pleaseSelectCheckboxFirst'));
                                              return false;
                                            }
                                            final result = await context
                                                .read<ServiceDetailsCubit>()
                                                .clearPayment(
                                              context,
                                              id: state.serviceDetails?.id,
                                              filePath: selectedImage?.path,
                                              data: {
                                                'payment_received':
                                                    isPaymentReceived,
                                                'note': _noteController.text,
                                              },
                                            );
                                            if (result) {
                                              _noteController.clear();
                                              selectedImage = null;
                                              isPaymentReceived = false;
                                            }

                                            return result;
                                          }
                                          return false;
                                        },
                                        contentBuilder: (context, setState) {
                                          return Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Gap(5),
                                              Align(
                                                alignment: Alignment.center,
                                                child: SvgPicture.asset(
                                                  AppImages.question,
                                                  height: 35,
                                                  width: 35,
                                                  colorFilter:
                                                      const ColorFilter.mode(
                                                    AppColors.yellow,
                                                    BlendMode.srcIn,
                                                  ),
                                                ),
                                              ),
                                              const Gap(5),
                                              Form(
                                                key: _noteFormKey,
                                                child: TextFieldWidget(
                                                  controller: _noteController,
                                                  label: AppUtils
                                                      .languageTranslate(
                                                          'note'),
                                                  maxLength: 1000,
                                                  validator: (value) {
                                                    if (value?.trim().isEmpty ??
                                                        true) {
                                                      return AppUtils
                                                          .languageTranslate(
                                                              'fieldIsMandatory');
                                                    }
                                                    return null;
                                                  },
                                                ),
                                              ),
                                              const Gap(5),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                        AppUtils
                                                            .languageTranslate(
                                                                'chequeFile'),
                                                        style: AppTextStyles
                                                            .style14DarkGrey600),
                                                  ),
                                                  InkWell(
                                                    overlayColor:
                                                        const WidgetStatePropertyAll(
                                                            Colors.transparent),
                                                    onTap: () async {
                                                      await FilePicker.platform
                                                          .pickFiles(
                                                              allowMultiple:
                                                                  false)
                                                          .then(
                                                              (FilePickerResult?
                                                                  result) {
                                                        if (result != null &&
                                                            result.files
                                                                .isNotEmpty) {
                                                          selectedImage = result
                                                              .files
                                                              .first
                                                              .xFile;

                                                          setState(() {});
                                                        }
                                                        return null;
                                                      });
                                                    },
                                                    child: Container(
                                                      alignment:
                                                          Alignment.center,
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(7),
                                                        color:
                                                            AppColors.cyanBlue,
                                                        border: Border.all(
                                                            color: AppColors
                                                                .outLineGray,
                                                            width: 0.5),
                                                      ),
                                                      child: const Icon(
                                                        Icons.add,
                                                        color: AppColors.white,
                                                        size: 25,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Gap(10),
                                              if (selectedImage
                                                      ?.name.isNotEmpty ??
                                                  false)
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                        selectedImage?.name ??
                                                            "",
                                                        style: AppTextStyles
                                                            .style14darkGrey400,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        maxLines: 1,
                                                      ),
                                                    ),
                                                    IconButton(
                                                      onPressed: () {
                                                        setState(() {
                                                          selectedImage = null;
                                                        });
                                                      },
                                                      icon: Icon(
                                                        Icons.close,
                                                        size: 18,
                                                        color:
                                                            AppColors.darkGrey,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              const Gap(10),
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                      padding: EdgeInsets.zero,
                                                      height: 20,
                                                      width: 20,
                                                      child: Checkbox(
                                                          fillColor:
                                                              WidgetStateProperty.all(
                                                                  AppColors
                                                                      .cyanBlue),
                                                          side: BorderSide(
                                                              color: Colors
                                                                  .transparent,
                                                              width: 1),
                                                          value:
                                                              isPaymentReceived,
                                                          onChanged: (value) {
                                                            setState(() {
                                                              isPaymentReceived =
                                                                  value ??
                                                                      false;
                                                            });
                                                          })),
                                                  Text(
                                                    AppUtils.languageTranslate(
                                                        'paymentReceived'),
                                                    style: AppTextStyles
                                                        .style14DarkGrey600,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    });
                              }),
                        )
                      ]
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
