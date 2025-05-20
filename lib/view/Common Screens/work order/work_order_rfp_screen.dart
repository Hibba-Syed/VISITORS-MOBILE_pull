import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/bloc/work_order/work_order_cubit.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_filter_bottom_sheet.dart';
import 'package:visitors/view/Common%20Screens/work%20order/components/work_order_rfp_card_widget.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import '../../../model/work_order/work_order_model.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/text field/search_text_field.dart';
import 'package:visitors/utils/app_utils.dart';

class WorkOrderRfpScreen extends StatefulWidget {
  const WorkOrderRfpScreen({super.key});

  @override
  State<WorkOrderRfpScreen> createState() => _WorkOrderRfpScreenState();
}

class _WorkOrderRfpScreenState extends State<WorkOrderRfpScreen> {
  final TextEditingController _scrollController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  // @override
  // void initState() {
  //   super.initState();
  //   context.read<CheckInsCubit>().getUnits();
  //   context.read<CheckInsCubit>().getVendors();
  //   _scrollController.addListener(() {
  //     if (_scrollController.position.pixels >=
  //         _scrollController.position.maxScrollExtent) {
  //       context.read<CheckInsCubit>().getMoreCheckIns(
  //         keyword: _searchController.text,
  //       );
  //     }
  //   });
  // }
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
                                await context
                                    .read<WorkOrderCubit>()
                                    .onChangeSearchKeyWord('');
                              },
                              onFieldSubmitted: (value) {
                                context
                                    .read<WorkOrderCubit>()
                                    .onChangeSearchKeyWord(value);
                              }
                          )),
                          const Gap(6),
                          FilterContainerWidget(
                            isFilterApplied: (state.selectedVendor != null) ||
                                (state.selectedType?.isNotEmpty ?? false)
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
                              //DateTimeUtil.getFormattedDateTime(workOrder?.createdAt.toString()),
                              checkInPressed: () {
                                AppUtils.isTablet(context)
                                    ? Navigator.pushNamed(
                                        context, AppRoutes.tabletGuestCheckInScreen)
                                    : Navigator.pushNamed(context,
                                        AppRoutes.mobileGuestCheckInScreen);
                              },
                              detailsOnPressed: () {
                                Navigator.pushNamed(
                                    context, AppRoutes.workOrderJobDetailsScreen);
                              },
                              jobCheckInOnPressed: () {
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
