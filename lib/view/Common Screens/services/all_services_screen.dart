import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/bloc/e_service/details/service_details_cubit.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/Common%20Screens/services/components/services_filter_bottom_sheet.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';

import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../bloc/e_service/service_cubit.dart';
import '../../../model/service/service_model.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/strings.dart';
import '../../widgets/Filter/filter_widget.dart';
import '../../widgets/text field/search_text_field.dart';
import 'package:visitors/utils/app_utils.dart';

import 'components/services_card_widget.dart';
import 'detail/access_device_service_details_sceen.dart';
import 'detail/delivery_permit_service_details_screen.dart';
import 'detail/facility_booking_service_details_screen.dart';
import 'detail/fit_out_service_details_screen.dart';
import 'detail/move_in_service_details_screen.dart';
import 'detail/move_out_service_details_screen.dart';
import 'detail/work_permit_service_details_screen.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        context.read<ServiceCubit>().getMoreServices(
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
      child: Scaffold(
        body: BlocBuilder<ServiceCubit, ServiceState>(
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
                                    .read<ServiceCubit>()
                                    .onChangeSearchKeyWord('');
                                await context
                                    .read<ServiceCubit>()
                                    .getServices();
                              },
                              onFieldSubmitted: (value) {
                                context
                                    .read<ServiceCubit>()
                                    .onChangeSearchKeyWord(value);
                                context.read<ServiceCubit>().getServices();
                              }),
                        ),
                        const Gap(6),
                        FilterContainerWidget(
                          isFilterApplied: (state.selectedUnit != null) ||
                                  (state.selectedType?.value.isNotEmpty ??
                                      false)
                              ? true
                              : false,
                          onPressed: () {
                            _servicesFilterBottomSheet(context);
                          },
                        )
                      ],
                    ),
                  ),
                  const Gap(10),
                  Expanded(
                    child: state.isLoading
                        ? LoaderWidget()
                        : state.serviceModel?.isNotEmpty ?? true
                            ? RefreshIndicator(
                                onRefresh: () async {
                                  context.read<ServiceCubit>().getServices(
                                      keyword: _searchController.text);
                                },
                                child: ListView.separated(
                                  controller: _scrollController,
                                  padding: const EdgeInsets.only(bottom: 10),
                                  physics: AlwaysScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  primary: false,
                                  itemCount: state.serviceModel?.length ?? 0,
                                  itemBuilder: (context, index) {
                                    ServiceModel? service =
                                        state.serviceModel?[index];
                                    return ServicesCardWidget(
                                      isActiveCheckins: (service
                                                  ?.activeCheckIns
                                                  ?.isNotEmpty ??
                                              true)
                                          ? true
                                          : false,
                                      unit:
                                          service?.unit?.unitNumber ?? "",
                                      title:
                                          service?.applicationType ?? "",
                                      reference: service?.reference ?? "",
                                      status: service?.status ?? "",
                                      serviceType:
                                          service?.applicationTitle ?? "",
                                      name: service?.clientName ?? "",
                                      checkInOnPressed: () {
                                        AppUtils.isTablet(context)
                                            ? Navigator.pushNamed(
                                                context,
                                                AppRoutes
                                                    .tabletGuestCheckInScreen)
                                            : Navigator.pushNamed(
                                                context,
                                                AppRoutes
                                                    .mobileGuestCheckInScreen);
                                      },
                                      serviceableCheckInOnPressed: () {
                                        context
                                            .read<CheckInsCubit>()
                                            .onChangeSelectedType(
                                            AppUtils.getServiceableType(
                                                Strings.keyServices));
                                        context.read<CheckInsCubit>().onChangeSelectedServiceableId(service?.id);
                                        context.read<CheckInsCubit>().getCheckIns();
                                        Navigator.pushNamed(
                                            context,
                                            AppRoutes
                                                .serviceableCheckInsScreen);
                                      },
                                      detailsOnPressed: () {
                                        // print("TAPPED");
                                        // print('service move: ${service?.toJson()
                                        // }
                                        // );
                                        context.read<ServiceDetailsCubit>().getServiceDetails(serviceId: service?.id);
                                        // print("ROUTE::: ${AppUtils.getRouteName(service)}");
                                        // return;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AppUtils.getRouteName(service),
                                            ));
                                      },
                                    );
                                  },
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5));
                                  },
                                ),
                              )
                            : EmptyWidget(
                                text: 'No data available',
                              ),
                  ),
                  if (state.loadMore) const LoaderWidget(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
  _servicesFilterBottomSheet(context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        context.read<ServiceCubit>().getUnits();
        return const ServicesFilterBottomSheet();
      },
    );
  }

}
