import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/work_order/details/work_order_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/phone_email_information_card_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/status/status_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../widgets/add_log_complete_action_design_widget.dart';

class WorkOrderJobDetailsScreen extends StatefulWidget {
  const WorkOrderJobDetailsScreen({super.key});

  @override
  State<WorkOrderJobDetailsScreen> createState() => _WorkOrderJobDetailsScreenState();
}

class _WorkOrderJobDetailsScreenState extends State<WorkOrderJobDetailsScreen> {
  final TextEditingController _noteController =
  TextEditingController();
  final GlobalKey<FormState> _actionFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBarWidget(
        title: AppUtils.languageTranslate('jobDetails'),
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: BlocBuilder<WorkOrderDetailsCubit, WorkOrderDetailsState>(
        builder: (context, state) {
          if (state.isLoading) {
            return LoaderWidget();
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
                            HeadingWidget(heading: AppUtils.languageTranslate('workOrder')),
                            StatusWidget(
                                status: state.workOrderDetailsModel?.status ?? ""),
                          ],
                        ),
                        const Gap(3),
                        HeadingWidget(
                          heading: state.workOrderDetailsModel?.reference ?? "",
                          style: AppUtils.isTablet(context)
                              ? AppTextStyles.style15Black600
                              : AppTextStyles.style14Black600,
                        ),
                        const Gap(10),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 15),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Column(
                            children: [
                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate('title'),
                                value: state.workOrderDetailsModel?.title ?? "",
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                title:  AppUtils.languageTranslate('category'),
                                value:
                                    state.workOrderDetailsModel?.category?.name ??
                                        "",
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                title:  AppUtils.languageTranslate('assets'),
                                value: state.workOrderDetailsModel?.assets
                                    ?.map((e) => e.name)
                                    .where((name) => name != null && name.isNotEmpty)
                                    .join(', '),
                              ),

                              TitleValueRowDividerDetailsContainerWidget(
                                title: AppUtils.languageTranslate('startDate'),
                                value: DateTimeUtil.getFormattedDate(
                                    state.workOrderDetailsModel?.startDate),
                              ),
                              TitleValueRowDividerDetailsContainerWidget(
                                isLast: true,
                                title: AppUtils.languageTranslate('endDate'),
                                value: DateTimeUtil.getFormattedDate(
                                    state.workOrderDetailsModel?.finishDate),
                              ),
                            ],
                          ),
                        ),
                        const Gap(20),
                         HeadingWidget(heading: AppUtils.languageTranslate('vendorDetails')),
                        const Gap(10),
                        PhoneEmailInformationCardWidget(
                          name:
                              state.workOrderDetailsModel?.newVendor?.companyName ??
                                  "",
                          phone: state.workOrderDetailsModel?.newVendor
                                  ?.contactNumber ??
                              "",
                          email: state
                                  .workOrderDetailsModel?.newVendor?.contactEmail ??
                              "",
                        ),
                        const Gap(20),
                         HeadingWidget(heading: AppUtils.languageTranslate('contactPerson')),
                        const Gap(10),
                        PhoneEmailInformationCardWidget(
                          name: state.workOrderDetailsModel?.primaryContact?.name ??
                              "",
                          phone: state.workOrderDetailsModel?.primaryContact
                                  ?.contactNumber ??
                              "",
                          email:
                              state.workOrderDetailsModel?.primaryContact?.email ??
                                  "",
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: AppConstants.horizontalPadding,
                      vertical: AppConstants.horizontalPadding),
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
                                insetPadding:
                                const EdgeInsets.symmetric(horizontal: 10),
                                title: '${AppUtils.languageTranslate('addLogTo')} ${state.workOrderDetailsModel?.reference ?? ""}',
                                secondButtonText: AppUtils.languageTranslate('addLog'),
                                secondButtonColor: AppColors.cyanBlue,
                                onSecondButtonPressed: () async {
                                  if(_actionFormKey.currentState?.validate() ?? false){
                                    final result = await context
                                        .read<WorkOrderDetailsCubit>()
                                        .addWorkOrderLog(
                                      context,
                                      data: {
                                        'job_id':
                                        '${state.workOrderDetailsModel?.id}',
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
                                  return  Form(
                                    key: _actionFormKey,
                                    child: AddLogCompleteActionDesignWidget(
                                        noteController: _noteController,

                                    ),
                                  );
                                },
                              );
                            });
                      }),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
