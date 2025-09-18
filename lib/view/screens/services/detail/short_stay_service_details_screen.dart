import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/e_service/details/service_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../../model/service/document_model.dart';
import '../../../../model/service/service_model.dart';
import '../../../../model/service/status_history_model.dart';
import '../../../widgets/empty_widget.dart';
import '../components/services_documents_card_widget.dart';

class ShortStayServiceDetailsScreen extends StatefulWidget {
  final ServiceModel? service;
  const  ShortStayServiceDetailsScreen({super.key,required this.service});

  @override
  State<ShortStayServiceDetailsScreen> createState() => _ShortStayServiceDetailsScreenState();
}

class _ShortStayServiceDetailsScreenState extends State<ShortStayServiceDetailsScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWidget(
        title: AppUtils.languageTranslate('serviceDetails'),
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: BlocBuilder<ServiceDetailsCubit, ServiceDetailsState>(
        builder: (context, state) {
          if(state.isLoading){
            return Padding(
              padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height /3),
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
                                title: AppUtils.languageTranslate('startDate'),
                                value:
                                DateTimeUtil.getFormattedDateTime(
                                    state.serviceDetails?.application?.startDate),
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate('endDate'),
                                value:  DateTimeUtil.getFormattedDateTime(
                                    state.serviceDetails?.application?.endDate),

                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                  title: AppUtils.languageTranslate('numberOfGuests'),
                                  value: state.serviceDetails?.application?.numberOfPeople?.toString()  ?? '--'
                              ),TitleValueRowDividerDetailsContainerWidget(
                                  isLast: true,
                                  title:  AppUtils.languageTranslate('description'),
                                  value: state.serviceDetails?.application?.description ?? '--'
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
                              title: AppUtils.languageTranslate(
                                  'deposit_amount'),
                              value: state.serviceDetails?.securityDeposit
                                  ?.toString() ??
                                  "--",
                              isLast: true,
                            ),
                          ),
                        ],
                        const Gap(20),
                        HeadingWidget(
                          heading:   AppUtils.languageTranslate('expectedGuests'),
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
                            children: state.serviceDetails?.application?.guests?.map((guest) =>
                                Column(
                                  children: [
                                    TitleValueRowDividerDetailsContainerWidget(
                                      title: AppUtils.languageTranslate('name'),
                                      value:guest.name ?? "--",
                                    ),
                                    TitleValueRowDividerDetailsContainerWidget(
                                      title: AppUtils.languageTranslate('phone'),
                                      value: guest.phone ?? "--",
                                    ),
                                    TitleValueRowDividerDetailsContainerWidget(
                                      isLast: true,
                                      title:  AppUtils.languageTranslate('passportOrId'),
                                       value: AppUtils.languageTranslate('Download'),
                                      url: guest.fileUrl ?? "",
                                    ),
                                  ],
                                ),
                            ).toList()  ?? [],
                          )
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
                                  title:  AppUtils.languageTranslate('requesterType'),
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
                                isLast: true,
                                title: AppUtils.languageTranslate('email'),
                                value: state.serviceDetails?.clientEmail ?? "--",
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
                        state.serviceDetails?.statusHistory?.isNotEmpty ?? true ?
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListView.builder(
                            padding: EdgeInsets.only(top: 10),
                            shrinkWrap: true,
                            primary: false,
                            itemCount:
                            state.serviceDetails?.statusHistory?.length ?? 0,
                            itemBuilder: (context, index) {
                              StatusHistory? statusHistory = state.serviceDetails?.statusHistory?[index];
                              bool isLast = (state.serviceDetails?.statusHistory?.length ?? 0) - 1 == index;
                              return ActivityLogWidget(
                                horizontalPadding: 8,
                                isLast: isLast,
                                status: (statusHistory?.status != 'Pending') ? statusHistory?.status ?? "" : "Request Received",
                                byValue:  (statusHistory?.user?.fullName != null && statusHistory!.user!.fullName!.isNotEmpty)
                                    ? ' ${statusHistory.user?.fullName ?? ""}'
                                    : " System",
                                description: statusHistory?.note
                                    ?.replaceAll('\n\n', ' ')
                                    .trim()
                                    .split('.')
                                    .first
                                    .trim(),

                                dateTime: DateTimeUtil.getFormattedDateTime(statusHistory?.createdAt),
                              );
                            },

                          ),
                        ) : EmptyWidget(text: AppUtils.languageTranslate('noDataAvailable')),
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
                            text:  AppUtils.languageTranslate('addLog'),
                            onPressed: () {
                              AppUtils.addLogServiceAction(
                                context: context,
                                state: state,
                              );
                            }),
                      ),
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
