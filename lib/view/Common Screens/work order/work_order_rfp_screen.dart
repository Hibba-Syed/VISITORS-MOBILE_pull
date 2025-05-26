import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/bloc/work_order/details/work_order_details_cubit.dart';
import 'package:visitors/bloc/work_order/work_order_cubit.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_filter_bottom_sheet.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_rfp_card_widget.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../model/work_order/work_order_model.dart';
import '../../../resource/constants/strings.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/text field/search_text_field.dart';
import 'package:visitors/utils/app_utils.dart';

class WorkOrderRfpScreen extends StatefulWidget {
  const WorkOrderRfpScreen({super.key});

  @override
  State<WorkOrderRfpScreen> createState() => _WorkOrderRfpScreenState();
}

class _WorkOrderRfpScreenState extends State<WorkOrderRfpScreen> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<WorkOrderCubit>().getMoreWorkOrder(

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
          body: BlocBuilder<WorkOrderCubit, WorkOrderState>(
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
                           Flexible(child: SearchTextField(
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
                              }
                          )),
                          const Gap(6),
                          FilterContainerWidget(
                            isFilterApplied: (state.selectedVendor != null) ||
                                (state.selectedType?.value.isNotEmpty ?? false)
                                ? true
                                : false,
                            onPressed: () {
                              _workOrderFilterBottomSheet(context);
                            },
                          )
                        ],
                      ),
                    ),
                    const Gap(10),
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: ()async{
                          context.read<WorkOrderCubit>().getWorkOrder();
                        },
                        child: state.isLoading ? LoaderWidget() :
                        state.workOrderModel?.isNotEmpty ?? true ?
                        ListView.separated(
                          controller: _scrollController,
                          physics: AlwaysScrollableScrollPhysics(),
                          shrinkWrap: true,
                          primary: false,
                          itemCount: state.workOrderModel?.length ?? 0,
                          itemBuilder: (context, index) {
                            WorkOrderModel? workOrder = state.workOrderModel?[index];
                            return WorkOrderRFPCardWidget(
                              isAwarded: workOrder?.isAwarded,
                              status: workOrder?.status ?? "",
                              title: workOrder?.title ?? "",
                              reference: workOrder?.reference ?? "",
                              vendorName: workOrder?.newVendor?.companyName ?? "",
                              date: workOrder?.createdAt.toString() ?? "",
                              isActiveCheckins: (workOrder?.activeCheckIns?.isNotEmpty ??
                                  true)
                                  ? true
                                  : false,
                              //DateTimeUtil.getFormattedDateTime(workOrder?.createdAt.toString()),
                              checkInPressed: () {
                                AppUtils.isTablet(context)
                                    ? Navigator.pushNamed(
                                        context, AppRoutes.tabletGuestCheckInScreen)
                                    : Navigator.pushNamed(context,
                                        AppRoutes.mobileGuestCheckInScreen);
                              },
                              detailsOnPressed: () {
                                context.read<WorkOrderDetailsCubit>().getWorkOrderDetails(workOrderId: workOrder?.id);
                                Navigator.pushNamed(
                                    context, AppRoutes.workOrderJobDetailsScreen);
                              },
                              jobCheckInOnPressed: () {
                                context
                                    .read<CheckInsCubit>()
                                    .onChangeSelectedType(
                                    AppUtils.getServiceableType(
                                        Strings.keyWorkOrder));
                                context.read<CheckInsCubit>().onChangeSelectedServiceableId(workOrder?.id);
                                context.read<CheckInsCubit>().getCheckIns();
                                Navigator.pushNamed(
                                    context, AppRoutes.jobCheckInsScreen);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const Gap(10);
                          },
                        ) : EmptyWidget(text: 'No data available',),
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

  _workOrderFilterBottomSheet(context) {
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
