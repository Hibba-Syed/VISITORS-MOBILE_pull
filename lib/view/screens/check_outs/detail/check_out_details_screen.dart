import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/check_out/details/check_out_details_cubit.dart';
import 'package:visitors/model/check_out/check_out_model.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/activity%20log/activity_log_widget.dart';
import 'package:visitors/view/widgets/app_bar/appbar_widget.dart';
import 'package:visitors/view/widgets/container_widgets/stack_count_container_widget.dart';
import 'package:visitors/view/widgets/container_widgets/title_value_row_divider_details_container.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/read_more_widget.dart';
import 'package:visitors/utils/app_utils.dart';
import '../../../../model/log_model.dart';
import '../../../../utils/validation_util.dart';
import '../../../widgets/mobile_web_icon_widget.dart';

class CheckOutDetailsScreen extends StatelessWidget {
  CheckOutDetailsScreen({super.key});

  final TextEditingController visitorsNoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    CheckOutModel? checkout =
        ModalRoute.of(context)?.settings.arguments as CheckOutModel?;
    return Scaffold(
      appBar: AppBarWidget(
        title: AppUtils.languageTranslate('checkoutDetails'),
        titleColor: AppColors.black,
        iconColor: AppColors.black,
      ),
      body: Padding(
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
                  count: checkout?.visitorCount ?? "",
                  imageUrl: checkout?.visitor?.imageUrl ?? "",
                  imageBackgroundColor: AppColors.darkGrey.withAlpha(25),
                ),
              ),
              const Gap(5),
              HeadingWidget(
                heading:
                    '${AppUtils.getServiceableType(checkout?.serviceableType).label} ${AppUtils.languageTranslate('details')}',
              ),
              (checkout?.serviceableType == "job" ||
                      checkout?.serviceableType == "application")
                  ? Text(
                      checkout?.purpose ?? "",
                      style: AppTextStyles.style16Black500,
                    )
                  : SizedBox.shrink(),
              const Gap(10),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('name'),
                      value: checkout?.name ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('phone'),
                      value: checkout?.phone ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('email'),
                      value: checkout?.email ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('unit'),
                      value: checkout?.unit?.unitNumber ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('currentVisitorsCount'),
                      value: checkout?.visitorCount ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('visitPurpose'),
                      value: ValidationUtil.isValid(checkout?.purpose)?checkout?.purpose:  "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('entryCardNumber'),
                      value: checkout?.entryCardNumber ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('nationality'),
                      value: checkout?.visitor?.nationality ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('checkInTime'),
                      value: DateTimeUtil.getFormattedDateTime(
                          checkout?.checkinTime),
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('checkInGate'),
                      value: checkout?.checkinGate ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('checkOutTime'),
                      value: DateTimeUtil.getFormattedDateTime(
                          checkout?.checkoutTime),
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('checkOutGate'),
                      value: checkout?.checkoutGate ?? "--",
                    ),
                    TitleValueRowDividerDetailsContainerWidget(
                      title: AppUtils.languageTranslate('medium'),
                      valueWidget: Align(
                        alignment: Alignment.centerLeft,
                        child: MobileWebIconWidget(
                          isMobile: checkout?.isMobile ?? false,
                          isDecorationEnabled: false,
                          iconColor: AppColors.darkGrey,
                        ),
                      ),
                    ),
                    Align(
                      alignment: context.locale.languageCode == 'en'
                          ? Alignment.topLeft
                          : Alignment.topRight,
                      child: ReadMoreWidget(
                          title: AppUtils.languageTranslate('description'),
                          valueText: checkout?.description ?? "--"),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Text(
                AppUtils.languageTranslate('checkInLog'),
                style: AppTextStyles.style20primary600,
              ),
              const Gap(10),
              BlocBuilder<CheckoutDetailsCubit, CheckOutDetailsState>(
                builder: (context, state) {
                  if (state.isLoading) {
                    return LoaderWidget();
                  }
                  return Container(
                    padding: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(10)),
                    child: ListView.builder(
                      //physics: AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      itemCount: state.checkOutLogs?.length ?? 0,
                      itemBuilder: (BuildContext context, int index) {
                        LogModel? item = state.checkOutLogs?[index];
                        bool isLast =
                            (state.checkOutLogs?.length ?? 0) - 1 == index;
                        return ActivityLogWidget(
                          isLast: isLast ? true : false,
                          status: item?.status ?? "--",
                          byValue: '',
                          description: item?.description ?? "--",
                          dateTime: DateTimeUtil.getFormattedDateTime(
                              item?.createdAt),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
