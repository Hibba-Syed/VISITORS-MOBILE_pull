import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/model/check_ins/check_ins_response_model.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_card_widget.dart';
import 'package:visitors/view/Common%20Screens/check%20ins/componants/check_in_filter_bottom_sheet.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/all_check_out_design_widget.dart';
import 'package:visitors/view/widgets/Filter/filter_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/text%20field/search_text_field.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../widgets/empty_widget.dart';


class CheckInsScreen extends StatefulWidget {
  const CheckInsScreen({super.key});

  @override
  State<CheckInsScreen> createState() => _CheckInsScreenState();
}

class _CheckInsScreenState extends State<CheckInsScreen> {
  final ScrollController _scrollController = ScrollController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<CheckInsCubit>().getMoreCheckIns();
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic) async {
        if (didPop) return;
        context
            .read<DeviceDeciderCubit>()
            .onChangeSelectedIndex(context, AppConstants.dashboardIndex);
      },
      child: Scaffold(
        body: BlocBuilder<CheckInsCubit, CheckInsState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Row(
                      children: [
                        const Flexible(child: SearchTextField()),
                        const Gap(6),
                        FilterContainerWidget(
                          onPressed: () {
                            _checkInFilterBottomSheet(context);
                          },
                        )
                      ],
                    ),
                  ),
                  const Gap(15),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                      buttonColor: AppColors.red,
                      text: 'Check-Outs All',
                      height:  AppUtils.isTablet(context)  ? 50 : 42,
                      width: AppUtils.isTablet(context) ? 200 : 170,
                      imageHeight: AppUtils.isTablet( context) ? 25 : 18,
                      borderRadius: 6,
                      image: AppImages.logout,
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogBox(
                              insetPadding:
                              AppUtils.isTablet(context) ?  EdgeInsets.symmetric(horizontal: 30) : EdgeInsets.symmetric(horizontal: 10),
                              isCancelButtonDisable: true,
                              confirmButtonColor: AppColors.red,
                              confirmButtonText: 'Checkout All',
                              title: 'Checkout for All Check-Ins',
                              contentBuilder: (context, setState) {
                                return const Align(
                                  alignment: Alignment.center,
                                  child: AllCheckOutDesignWidget(),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: state.isLoading ? LoaderWidget() :
                        state.checkInsRecord?.isNotEmpty ?? false
                            ?
                             RefreshIndicator(
                             onRefresh: ()async{
                               context.read<CheckInsCubit>().getCheckIns();
                            },
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        controller: _scrollController,
                        padding: const EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.checkInsRecord?.length ?? 0,
                        itemBuilder: (context, index) {
                          CheckInsRecord? checkInsRecord = state.checkInsRecord?[index];
                          return CheckInCardWidget(
                            count:  int.tryParse(checkInsRecord?.visitorCount.toString() ?? '0') ?? 0,
                            typeImage: (checkInsRecord?.type?.toLowerCase() == 'community visit' || checkInsRecord?.type?.toLowerCase() == 'community service' )?
                            AppImages.community : "",
                            typeText: (checkInsRecord?.type?.toLowerCase() == 'unit visit' || checkInsRecord?.type?.toLowerCase() == 'unit service') ?
                                checkInsRecord?.unit?.unitNumber
                            : checkInsRecord?.type ?? "",
                            name: checkInsRecord?.name ?? "",
                            profileImageUrl: checkInsRecord?.visitor?.imageUrl ?? "",
                            type:  "Guest",
                            date: DateTimeUtil.getFormattedDatesTime(checkInsRecord?.visitor?.createdAt),
                            phone: checkInsRecord?.phone ?? "",
                            gateValue: checkInsRecord?.checkinGate ?? "",
                            checkOutOnPressed: () {
                              _showCheckoutDialog(context);
                            },
                            detailsOnPressed: () {
                              Navigator.pushNamed(
                                  context, AppRoutes.checkInDetailsScreen);
                            },
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(10);
                        },
                      ),
                    ) :  const EmptyWidget(
                          text: 'No data available',
                        ),
                  ),
                  if (state.loadMore) const LoaderWidget(),
                ],
              ),
            );
             }
    ),
        ),

    );
  }

  void _showCheckoutDialog(BuildContext context) {
    final TextEditingController visitorsNoController = TextEditingController();

    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title: 'Checkout for Ahmed',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              checkOutAllOnPress: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 10),
                      isCancelButtonDisable: true,
                      confirmButtonColor: AppColors.red,
                      confirmButtonText: 'Checkout All',
                      title: 'Checkout for All Check-Ins',
                      contentBuilder: (context, setState) {
                        return const Align(
                          alignment: Alignment.center,
                          child: AllCheckOutDesignWidget(),
                        );
                      },
                    );
                  },
                );
              },
              checkOutOnPress: () {},
              logIsLast: true,
              horizontalPadding: 0,
              logDate: "2025-04-04T05:33:36.000000Z",
              controller: visitorsNoController,
              logStatus: 'Check-In',
              logByValue: '',
              visitorsCount: 5,
              logDescription:
                  '6 visitor(s) checked-in from gate ‘The W Residences',
            );
          },
        );
      },
    );
  }

  _checkInFilterBottomSheet(context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: AppUtils.isTablet(context) ? AppConstants.tabletScreen : AppConstants.mobileScreen),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const CheckInFilterBottomSheet();
      },
    );
  }
}
