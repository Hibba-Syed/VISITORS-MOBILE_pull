import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
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

import '../../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../../model/check_ins/check_in_model.dart';
import '../../widgets/empty_widget.dart';

class CheckInsScreen extends StatefulWidget {
  const CheckInsScreen({super.key});

  @override
  State<CheckInsScreen> createState() => _CheckInsScreenState();
}

class _CheckInsScreenState extends State<CheckInsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<CheckInsCubit>().getMoreCheckIns(
              keyword: _searchController.text,
            );
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
            .onChangeSelectedIndex(AppConstants.dashboardIndex);
      },
      child: SafeArea(
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
                        Flexible(
                          child: SearchTextField(
                              controller: _searchController,
                              onClearPressed: () async {
                                _searchController.clear();
                                 context
                                    .read<CheckInsCubit>()
                                    .onChangeSearchKeyWord('');
                                 context.read<CheckInsCubit>().getCheckIns();
                              },
                              onFieldSubmitted: (value) {
                                context
                                    .read<CheckInsCubit>()
                                    .onChangeSearchKeyWord(value);
                                context.read<CheckInsCubit>().getCheckIns();
                              }
                              ),
                        ),
                        const Gap(6),
                        FilterContainerWidget(
                          isFilterApplied: (state.selectedUnit != null) ||
                                  (state.selectedType?.value.isNotEmpty ??
                                      false) ||
                                  (state.selectedVendor != null) ||
                                  (state.dateRang != null)
                              ? true
                              : false,
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
                      height: AppUtils.isTablet(context) ? 50 : 42,
                      width: AppUtils.isTablet(context) ? 200 : 170,
                      imageHeight: AppUtils.isTablet(context) ? 25 : 18,
                      borderRadius: 6,
                      image: AppImages.logoutCard,
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return CustomAlertDialogBox(
                              insetPadding: AppUtils.isTablet(context)
                                  ? EdgeInsets.symmetric(horizontal: 30)
                                  : EdgeInsets.symmetric(horizontal: 10),
                              isCancelButtonDisable: true,
                              confirmButtonColor: AppColors.red,
                              confirmButtonText: 'Checkout All',
                              title: 'Checkout for All Check-Ins',
                              onConfirm: () async {
                                return context
                                    .read<CheckInsCubit>()
                                    .checkOutAll(context);
                              },
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
                    child: state.isLoading
                        ? LoaderWidget()
                        : state.checkInModel?.isNotEmpty ?? false
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  context.read<CheckInsCubit>().getCheckIns(
                                      keyword: _searchController.text);
                                },
                                child: ListView.separated(
                                  physics: AlwaysScrollableScrollPhysics(),
                                  controller: _scrollController,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: state.checkInModel?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    CheckInModel? checkInsRecord =
                                        state.checkInModel?[index];
                                    return CheckInCardWidget(
                                      count: checkInsRecord?.visitorCount ?? "",
                                      typeImage:
                                          (checkInsRecord?.type?.toLowerCase() ==
                                                      'community visit' ||
                                                  checkInsRecord?.type
                                                          ?.toLowerCase() ==
                                                      'community service')
                                              ? AppImages.community
                                              : "",
                                      typeText:
                                          (checkInsRecord?.type?.toLowerCase() ==
                                                      'unit visit' ||
                                                  checkInsRecord?.type
                                                          ?.toLowerCase() ==
                                                      'unit service')
                                              ? checkInsRecord?.unit?.unitNumber
                                              : checkInsRecord?.type ?? "",
                                      name: checkInsRecord?.name ?? "",
                                      profileImageUrl:
                                          checkInsRecord?.visitor?.imageUrl ?? "",
                                      type: AppUtils.getServiceableType(
                                              checkInsRecord?.serviceableType)
                                          .value,
                                      date: DateTimeUtil.getFormattedDatesTime(
                                          checkInsRecord?.visitor?.createdAt),
                                      checkOutOnPressed: () {
                                        _showCheckoutDialog(context);
                                      },
                                      detailsOnPressed: () {
                                        context
                                            .read<CheckInsDetailsCubit>()
                                            .getCheckInDetailsLog(
                                                id: checkInsRecord?.id);
                                        Navigator.pushNamed(context,
                                            AppRoutes.checkInDetailsScreen,
                                            arguments:
                                                state.checkInModel?[index]);
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Gap(10);
                                  },
                                ),
                              )
                            : const EmptyWidget(
                                text: 'No data available',
                              ),
                  ),
                  if (state.loadMore) const LoaderWidget(),
                ],
              ),
            );
          }),
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
                      onConfirm: (){
                        return context
                            .read<CheckInsCubit>()
                            .checkOutAll(context);
                      },
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
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        context.read<CheckInsCubit>().getVendors();
        context.read<CheckInsCubit>().getUnits();
        return const CheckInFilterBottomSheet();
      },
    );
  }
}
