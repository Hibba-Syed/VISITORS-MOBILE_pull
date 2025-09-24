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
import '../../../widgets/container_widgets/title_value_row_divider_details_container.dart';
import '../../../widgets/empty_widget.dart';
import '../../../widgets/heading_widget.dart';
import '../../../widgets/loader/loader_widget.dart';
import '../../../widgets/status/status_widget.dart';
import '../components/services_documents_card_widget.dart';

class FacilityBookingServiceDetailsScreen extends StatefulWidget {
  final ServiceModel? service;
  const FacilityBookingServiceDetailsScreen({super.key, required this.service});

  @override
  State<FacilityBookingServiceDetailsScreen> createState() =>
      _FacilityBookingServiceDetailsScreenState();
}

class _FacilityBookingServiceDetailsScreenState
    extends State<FacilityBookingServiceDetailsScreen> {
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
                                  title: AppUtils.languageTranslate('facility'),
                                  value: state.serviceDetails?.application
                                          ?.facility ??
                                      "--"),
                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate(
                                    'natureOfFunction'),
                                value: state.serviceDetails?.application
                                        ?.natureOfFunction ??
                                    "--",
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                  title: AppUtils.languageTranslate(
                                      'expectedGuests'),
                                  value: state.serviceDetails?.application
                                          ?.expectedGuests
                                          ?.toString() ??
                                      '--'),
                              TitleValueRowDividerDetailsContainerWidget(
                                  title:
                                      AppUtils.languageTranslate('bookingDate'),
                                  value: DateTimeUtil.getFormattedDate(state
                                      .serviceDetails
                                      ?.application
                                      ?.bookingDate)),
                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate('startTime'),
                                value: state.serviceDetails?.application
                                        ?.startTime ??
                                    "--",
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                  isLast: true,
                                  title: AppUtils.languageTranslate('endTime'),
                                  value: state.serviceDetails?.application
                                          ?.endTime ??
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
