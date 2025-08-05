import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/work_order/details/work_order_details_cubit.dart';
import 'package:visitors/bloc/work_order/work_order_cubit.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../bloc/main_dashboard/main_dashboard_cubit.dart';
import '../../../model/work_order/work_order_model.dart';
import '../../../resource/constants/strings.dart';
import '../../../utils/date_time.dart';
import '../../widgets/text field/search_text_field.dart';
import 'package:visitors/utils/app_utils.dart';

import 'components/work_order_filter_bottom_sheet.dart';
import 'components/work_order_rfp_card_widget.dart';

class WorkOrderRfpScreen extends StatefulWidget {
  const WorkOrderRfpScreen({super.key});

  @override
  State<WorkOrderRfpScreen> createState() => _WorkOrderRfpScreenState();
}

class _WorkOrderRfpScreenState extends State<WorkOrderRfpScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  Locale? _currentLocale;
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context
            .read<WorkOrderCubit>()
            .getMoreWorkOrder(keyword: _searchController.text);
      }
    });
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
      child: SafeArea(
        child: Scaffold(
          body: BlocBuilder<WorkOrderCubit, WorkOrderState>(
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
                            context
                                .read<WorkOrderCubit>()
                                .onChangeSearchKeyWord('');
                            context.read<WorkOrderCubit>().getWorkOrder();
                          },
                          onFieldSubmitted: (value) {
                            context
                                .read<WorkOrderCubit>()
                                .onChangeSearchKeyWord(value);
                            context.read<WorkOrderCubit>().getWorkOrder();
                          },
                          isFilterApplied: (state.selectedVendor != null) ||
                                  (state.selectedType?.value.isNotEmpty ??
                                      false)
                              ? true
                              : false,
                          onFilterPressed: () {
                            _workOrderFilterBottomSheet(context);
                          }),
                    ),
                    const Gap(10),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<WorkOrderCubit>()
                              .getWorkOrder(keyword: _searchController.text);
                        },
                        child: state.isLoading
                            ? LoaderWidget()
                            : state.workOrderModel?.isNotEmpty ?? true
                                ? ListView.separated(
                                    controller: _scrollController,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount:
                                        state.workOrderModel?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      WorkOrderModel? workOrder =
                                          state.workOrderModel?[index];
                                      return WorkOrderRFPCardWidget(
                                        isAwarded: workOrder?.isAwarded,
                                        status: workOrder?.status ?? "--",
                                        title: workOrder?.title ?? "--",
                                        reference: workOrder?.reference ?? "--",
                                        vendorName:
                                            workOrder?.newVendor?.companyName ??
                                                "--",
                                        createdDate:
                                            DateTimeUtil.getFormattedDate(
                                                workOrder?.startDate),
                                        updatedDate:
                                            DateTimeUtil.getFormattedDate(
                                                workOrder?.finishDate),
                                        isActiveCheckins: (workOrder
                                                    ?.activeCheckIns
                                                    ?.isNotEmpty ??
                                                true)
                                            ? true
                                            : false,
                                        checkInPressed: () {
                                          Navigator.pushNamed(context,
                                                  AppRoutes.guestCheckIn)
                                              .then(
                                            (value) {
                                              if (value == true) {
                                                context
                                                    .read<WorkOrderCubit>()
                                                    .getWorkOrder(
                                                        keyword:
                                                            _searchController
                                                                .text);
                                              }
                                            },
                                          );
                                        },
                                        detailsOnPressed: () {
                                          context
                                              .read<WorkOrderDetailsCubit>()
                                              .getWorkOrderDetails(
                                                  workOrderId: workOrder?.id);
                                          Navigator.pushNamed(context,
                                              AppRoutes.workOrderJobDetails);
                                        },
                                        jobCheckInOnPressed: () {
                                          context
                                              .read<CheckInsCubit>()
                                              .onChangeSelectedVisitorType(
                                                  AppUtils.getServiceableType(
                                                      Strings.keyWorkOrder));
                                          context
                                              .read<CheckInsCubit>()
                                              .onChangeSelectedServiceableId(
                                                  workOrder?.id);
                                          context
                                              .read<CheckInsCubit>()
                                              .getCheckIns();
                                          Navigator.pushNamed(
                                              context, AppRoutes.jobCheckIns);
                                        },
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Gap(10);
                                    },
                                  )
                                : EmptyWidget(
                                    text: AppUtils.languageTranslate(
                                        'noDataAvailable'),
                                  ),
                      ),
                    ),
                    if (state.loadMore) const LoaderWidget(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  void _workOrderFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        context.read<WorkOrderCubit>().getVendors();
        return const WorkOrderFilterBottomSheet();
      },
    );
  }
}
