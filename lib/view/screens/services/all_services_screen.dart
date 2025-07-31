import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/e_service/details/service_details_cubit.dart';
import 'package:visitors/utils/routes/app_routes.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';

import '../../../bloc/check_ins/check_ins_cubit.dart';
import '../../../bloc/e_service/service_cubit.dart';
import '../../../bloc/main_dashboard/main_dashboard_cubit.dart';
import '../../../model/service/service_model.dart';
import '../../../resource/constants/app_constants.dart';
import '../../../resource/constants/strings.dart';
import '../../widgets/text field/search_text_field.dart';
import 'package:visitors/utils/app_utils.dart';

import 'components/services_card_widget.dart';
import 'components/services_filter_bottom_sheet.dart';

class AllServicesScreen extends StatefulWidget {
  const AllServicesScreen({super.key});

  @override
  State<AllServicesScreen> createState() => _AllServicesScreenState();
}

class _AllServicesScreenState extends State<AllServicesScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Locale? _currentLocale;

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
    context.read<ServiceCubit>().getUnits();
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
          body: BlocBuilder<ServiceCubit, ServiceState>(
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
                              .read<ServiceCubit>()
                              .onChangeSearchKeyWord('');
                          await context.read<ServiceCubit>().getServices();
                        },
                        onFieldSubmitted: (value) {
                          context
                              .read<ServiceCubit>()
                              .onChangeSearchKeyWord(value);
                          context.read<ServiceCubit>().getServices(

                          );
                        },
                        isFilterApplied: (state.selectedUnit != null) ||
                                (state.selectedType?.value.isNotEmpty ?? false)
                            ? true
                            : false,
                        onFilterPressed: () {
                          _servicesFilterBottomSheet(context);
                        },
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
                                        keyword: _searchController.text,
                                    );
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
                                        unit: service?.unit?.unitNumber ?? "",
                                        title: service?.applicationType ?? "--",
                                        reference: service?.reference ?? "--",
                                        status: service?.status ?? "--",
                                        serviceType:
                                            service?.applicationTitle ?? "--",
                                        name: service?.clientName ?? "--",
                                        checkInOnPressed: () {
                                          Navigator.pushNamed(
                                              context, AppRoutes.guestCheckIn);
                                        },
                                        serviceableCheckInOnPressed: () {
                                          context
                                              .read<CheckInsCubit>()
                                              .onChangeSelectedVisitorType(
                                                  AppUtils.getServiceableType(
                                                      Strings.keyServices));
                                          context
                                              .read<CheckInsCubit>()
                                              .onChangeSelectedServiceableId(
                                                  service?.id);
                                          context
                                              .read<CheckInsCubit>()
                                              .getCheckIns();
                                          Navigator.pushNamed(context,
                                              AppRoutes.serviceableCheckIns);
                                        },
                                        detailsOnPressed: () {
                                          ServiceDetailsCubit serviceDetailsCubit = context
                                              .read<ServiceDetailsCubit>();
                                          serviceDetailsCubit.clearData();
                                          serviceDetailsCubit
                                              .getServiceDetails(
                                                  serviceId: service?.id);
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    AppUtils.getRouteName(
                                                        service),
                                              ));
                                        },
                                      );
                                    },
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5));
                                    },
                                  ),
                                )
                              : EmptyWidget(
                                  text: AppUtils.languageTranslate(
                                      'noDataAvailable'),
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

  void _servicesFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        return const ServicesFilterBottomSheet();
      },
    );
  }
}
