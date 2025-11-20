import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/bloc/main_dashboard/main_dashboard_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/constants/images.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/all_check_out_design_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/container_widgets/check_out_container_widget.dart';
import 'package:visitors/view/widgets/Alert_dialog_box/custom_alert_dialog_box.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/utils/app_utils.dart';

import '../../../bloc/check_ins/details/check_ins_details_cubit.dart';
import '../../../model/check_ins/check_in_model.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/text field/search_text_field.dart';
import 'componants/check_in_card_widget.dart';
import 'componants/check_in_filter_bottom_sheet.dart';

class CheckInsScreen extends StatefulWidget {
  const CheckInsScreen({super.key});

  @override
  State<CheckInsScreen> createState() => _CheckInsScreenState();
}

class _CheckInsScreenState extends State<CheckInsScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController visitorsNoController = TextEditingController();
  Locale? _currentLocale;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          context.read<CheckInsCubit>().state.loadMore == false) {
        context.read<CheckInsCubit>().getMoreCheckIns(
              keyword: _searchController.text,
            );
      }
    });
    context.read<CheckInsCubit>().getUnits();
    context.read<CheckInsCubit>().getVendors();
  }

  @override
  void didChangeDependencies() {
    final locale = Localizations.localeOf(context);
    if (locale != _currentLocale) {
      _currentLocale = locale;
      setState(() {});
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic) async {
        if (didPop) return;
        context.read<MainDashboardCubit>().onBackButtonPressed();
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
                  child: SearchTextField(
                    controller: _searchController,
                    onClearPressed: () async {
                      _searchController.clear();
                      context.read<CheckInsCubit>().onChangeSearchKeyWord('');
                      context.read<CheckInsCubit>().getCheckIns();
                    },
                    onFieldSubmitted: (value) {
                      context
                          .read<CheckInsCubit>()
                          .onChangeSearchKeyWord(value);
                      context.read<CheckInsCubit>().getCheckIns();
                    },
                    isFilterApplied: (state.selectedUnit != null) ||
                            (state.selectedVisitorType?.value.isNotEmpty ??
                                false) ||
                            (state.selectedVendor != null) ||
                            (state.selectedDateRange != null)
                        ? true
                        : false,
                    onFilterPressed: () {
                      _checkInFilterBottomSheet(context);
                    },
                  ),
                ),
                const Gap(15),
                ((state.checkIns?.isNotEmpty ?? false)&&(state.isLoading==false))
                    ? Align(
                        alignment: Alignment.bottomRight,
                        child: CustomButton(
                          buttonColor: AppColors.red,
                          text: AppUtils.languageTranslate('checkoutAll'),
                          height: AppUtils.isTablet(context) ? 42 : 41,
                          width: AppUtils.isTablet(context) ? 200 : 170,
                          imageHeight: AppUtils.isTablet(context) ? 22 : 18,
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
                                  isFirstButtonDisable: true,
                                  secondButtonColor: AppColors.red,
                                  secondButtonText:
                                      AppUtils.languageTranslate('yes'),
                                  title: AppUtils.languageTranslate(
                                      'checkOutForAllCheckIns'),
                                  onSecondButtonPressed: () async {
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
                        ))
                    : SizedBox.shrink(),
                const Gap(10),
                Expanded(
                  child: state.isLoading
                      ? LoaderWidget()
                      : state.checkIns?.isNotEmpty ?? false
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
                                itemCount: state.checkIns?.length ?? 0,
                                itemBuilder: (context, index) {
                                  CheckInModel? checkIn =
                                      state.checkIns?[index];
                                  return CheckInCardWidget(
                                    phone: checkIn?.phone ?? "--",
                                    count: checkIn?.visitorCount ?? "--",
                                    typeImage: (checkIn?.type?.toLowerCase() ==
                                                'community visit' ||
                                            checkIn?.type?.toLowerCase() ==
                                                'community service')
                                        ? AppImages.community
                                        : (checkIn?.type?.toLowerCase() ==
                                                    'unit visit' ||
                                                checkIn?.type?.toLowerCase() ==
                                                    'unit service')
                                            ? AppImages.unit
                                            : "",
                                    typeText: (checkIn?.type?.toLowerCase() ==
                                                'unit visit' ||
                                            checkIn?.type?.toLowerCase() ==
                                                'unit service')
                                        ? checkIn?.unit?.unitNumber
                                        : checkIn?.type ?? "--",
                                    name: checkIn?.name ?? "--",
                                    profileImageUrl:
                                        checkIn?.visitor?.imageUrl ?? "",
                                    type: AppUtils.getServiceableType(
                                            checkIn?.serviceableType)
                                        .label,
                                    createdDate:
                                        DateTimeUtil.getFormattedDateTime(
                                            checkIn?.createdAt),
                                    isMobile: checkIn?.isMobile,
                                    checkOutOnPressed: () {
                                      context
                                          .read<CheckInsDetailsCubit>()
                                          .getCheckInDetailsLog(
                                              id: checkIn?.id);
                                      _showCheckoutDialog(context, checkIn);
                                    },
                                    detailsOnPressed: () {
                                      context
                                          .read<CheckInsDetailsCubit>()
                                          .getCheckInDetailsLog(
                                              id: checkIn?.id);
                                      Navigator.pushNamed(
                                          context, AppRoutes.checkInDetails,
                                          arguments: checkIn);
                                    },
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const Gap(10);
                                },
                              ),
                            )
                          : EmptyWidget(
                              text:
                                  AppUtils.languageTranslate('noDataAvailable'),
                            ),
                ),
                if (state.loadMore) const LoaderWidget(),
              ],
            ),
          );
        }),
      ),
    );
  }

  void _showCheckoutDialog(BuildContext context, CheckInModel? checkIns) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return CustomAlertDialogBox(
          insetPadding: const EdgeInsets.symmetric(horizontal: 10),
          hideBothButtons: true,
          title:
              '${AppUtils.languageTranslate('checkoutFor')} ${checkIns?.name ?? ""}',
          contentBuilder: (context, setState) {
            return CheckOutContainerWidget(
              visitorsCount: checkIns?.visitorCount ?? "",
              controller: visitorsNoController,
              checkOutAllOnPress: () {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
                      isFirstButtonDisable: true,
                      secondButtonColor: AppColors.red,
                      secondButtonText: AppUtils.languageTranslate('yes'),
                      title:
                          AppUtils.languageTranslate('checkOutForAllCheckIns'),
                      onSecondButtonPressed: () async {
                        final result = await context
                            .read<CheckInsCubit>()
                            .checkOutVisitors(
                              context,
                              id: checkIns?.id,
                              data: visitorsNoController.text.isNotEmpty
                                  ? {
                                      "checkout_count":
                                          visitorsNoController.text
                                    }
                                  : {},
                            );
                        visitorsNoController.clear();
                        return result;
                      },
                    );
                  },
                );
              },
              checkOutOnPress: () async {
                final enteredCount =
                    int.tryParse(visitorsNoController.text.trim());
                final availableCount =
                    int.tryParse(checkIns?.visitorCount ?? '') ?? 0;
                if ((enteredCount ?? 0) > availableCount) {
                  Fluttertoast.showToast(
                      msg: AppUtils.languageTranslate(
                          "availableCountIs $availableCount"));
                  return;
                }
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return CustomAlertDialogBox(
                        insetPadding:
                            const EdgeInsets.symmetric(horizontal: 20),
                        isFirstButtonDisable: true,
                        secondButtonColor: AppColors.red,
                        secondButtonText: AppUtils.languageTranslate('yes'),
                        title:
                            AppUtils.languageTranslate('checkoutForVisitors'),
                        onSecondButtonPressed: () async {
                          final result = await context
                              .read<CheckInsCubit>()
                              .checkOutVisitors(context,
                                  id: checkIns?.id,
                                  data: {
                                "checkout_count": visitorsNoController.text
                              });
                          visitorsNoController.clear();
                          return result;
                        });
                  },
                );
              },
            );
          },
        );
      },
    );
  }

  void _checkInFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const CheckInFilterBottomSheet();
      },
    );
  }
}
