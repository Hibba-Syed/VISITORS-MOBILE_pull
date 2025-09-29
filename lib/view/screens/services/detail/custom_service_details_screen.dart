import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../../bloc/e_service/details/service_details_cubit.dart';
import '../../../../model/service/document_model.dart';
import '../../../../model/service/service_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../../resource/constants/app_colors.dart';
import '../../../../resource/constants/app_constants.dart';
import '../../../../resource/styles/styles.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/date_time.dart';
import '../../../widgets/activity log/activity_log_widget.dart';
import '../../../widgets/app_bar/appbar_widget.dart';
import '../../../widgets/button/custom_button.dart';
import '../../../widgets/container_widgets/title_value_column_divider_details_container.dart';
import '../../../widgets/container_widgets/title_value_row_divider_details_container.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/heading_widget.dart';
import '../../../widgets/loader/loader_widget.dart';
import '../../../widgets/status/status_widget.dart';
import '../components/services_documents_card_widget.dart';

class CustomServiceDetailsScreen extends StatefulWidget {
  final ServiceModel? service;
  const CustomServiceDetailsScreen({super.key, required this.service});

  @override
  State<CustomServiceDetailsScreen> createState() =>
      _CustomServiceDetailsScreenState();
}

class _CustomServiceDetailsScreenState
    extends State<CustomServiceDetailsScreen> {
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
          final List<Document>? filteredDocuments =
              state.serviceDetails?.documents?.where((item) {
            if (item.label == "Sent For Approval File" ||
                item.label == "Approve File") {
              return false;
            } else {
              return true;
            }
          }).toList();
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: HeadingWidget(
                                heading:
                                    state.serviceDetails?.application?.name ??
                                        "--",
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
                        if (state.serviceDetails?.application?.fields
                                ?.isNotEmpty ??
                            false)
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: state
                                .serviceDetails!.application!.fields!.length,
                            itemBuilder: (context, index) {
                              bool isLast = index ==
                                  (state.serviceDetails!.application!.fields!
                                          .length -
                                      1);
                              final field = state
                                  .serviceDetails!.application!.fields![index];

                              String? displayValue;

                              switch (field.type) {
                                case "text":
                                case "number":
                                case "textarea":
                                case "dropdown":
                                case "radio":
                                case "rating":
                                  displayValue =
                                      field.value?.toString() ?? '--';
                                  break;

                                case "boolean":
                                  displayValue =
                                      (field.value == true) ? "Yes" : "No";
                                  break;

                                case "date":
                                  displayValue = DateTimeUtil.getFormattedDate(
                                      field.value);
                                  break;

                                case "datetime":
                                  displayValue =
                                      DateTimeUtil.getFormattedDateTime(
                                          field.value);
                                  break;

                                case "time":
                                  displayValue = DateTimeUtil.getFormattedTime(
                                      field.value);
                                  break;

                                case "file":
                                  displayValue = field.value?.toString() ?? '';
                                  // You could render a clickable link/button here if needed
                                  break;

                                case "multiselect":
                                case "checkbox":
                                  if (field.values != null &&
                                      field.values!.isNotEmpty) {
                                    displayValue = field.values!
                                        .map((v) => v.value?.toString() ?? '')
                                        .where((v) => v.isNotEmpty)
                                        .join(', ');
                                  }
                                  break;

                                default:
                                  displayValue =
                                      field.value?.toString() ?? '--';
                              }

                              return TitleValueColumnDividerDetailsContainerWidget(
                                title: field.label ?? '--',
                                url: field.type == 'file'
                                    ? (displayValue?.isNotEmpty ?? false)
                                        ? displayValue
                                        : null
                                    : null,
                                value: (field.type == 'file' &&
                                        (displayValue?.isEmpty ?? true))
                                    ? '--'
                                    : field.type != 'file'
                                        ? displayValue ?? '--'
                                        : null,
                                valueWidget: (field.type == 'rating' &&
                                        (int.tryParse(displayValue ?? '') !=
                                            null))
                                    ? Row(
                                        children: List.generate(
                                          int.tryParse(displayValue ?? '') ?? 0,
                                          (index) {
                                            return Icon(
                                              Icons.star,
                                              size: 16,
                                              color: AppColors.darkGrey,
                                            );
                                          },
                                        ),
                                      )
                                    : null,
                                isLast: isLast,
                              );
                            },
                          ),
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
                          child: filteredDocuments?.isNotEmpty ?? true
                              ? ListView.separated(
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: filteredDocuments?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    Document? document =
                                        filteredDocuments?[index];
                                    if (document?.label ==
                                            "Sent For Approval File" ||
                                        document?.label == "Approve File") {
                                      return SizedBox.shrink();
                                    }
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
                                    'noDataAvailable')),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalPadding,
                      vertical: AppConstants.verticalPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                            text: AppUtils.languageTranslate('addLog'),
                            buttonColor: AppColors.cyanBlue,
                            onPressed: () {
                              AppUtils.addLogServiceAction(
                                context: context,
                                state: state,
                              );
                            }),
                      ),
                      if ((state.serviceDetails?.securityDeposit == null) ||
                          (state.serviceDetails?.securityDeposit == 0)) ...[
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
                              }),
                        )
                      ],
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
