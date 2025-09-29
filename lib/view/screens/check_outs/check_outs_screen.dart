import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/check_out/details/check_out_details_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/text%20field/search_text_field.dart';

import '../../../bloc/check_out/check_out_cubit.dart';
import '../../../bloc/main_dashboard/main_dashboard_cubit.dart';
import '../../../model/check_out/check_out_model.dart';
import '../../../resource/constants/images.dart';
import '../../../service/download_file/pdf_downloader.dart';
import '../../../utils/routes/app_routes.dart';
import '../../widgets/empty_widget.dart';
import 'components/check_outs_card_widget.dart';
import 'components/check_outs_filter_bottom_sheet.dart';

class CheckOutsScreen extends StatefulWidget {
  const CheckOutsScreen({super.key});

  @override
  State<CheckOutsScreen> createState() => _CheckOutsScreenState();
}

class _CheckOutsScreenState extends State<CheckOutsScreen> {
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  Locale? _currentLocale;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent &&
          context.read<CheckOutCubit>().state.loadMore == false) {
        context
            .read<CheckOutCubit>()
            .getMoreCheckOut(keyword: _searchController.text);
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
        child: Scaffold(
          body: BlocBuilder<CheckOutCubit, CheckOutState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.horizontalPadding),
                child: Column(
                  children: [
                    const Gap(10),
                    SearchTextField(
                      controller: _searchController,
                      onClearPressed: () async {
                        _searchController.clear();
                        context.read<CheckOutCubit>().onChangeSearchKeyWord('');
                        context.read<CheckOutCubit>().getCheckOuts();
                      },
                      onFieldSubmitted: (value) {
                        context
                            .read<CheckOutCubit>()
                            .onChangeSearchKeyWord(value);
                        context.read<CheckOutCubit>().getCheckOuts();
                      },
                      isFilterApplied: (state.selectedUnit != null) ||
                              (state.selectedType?.value.isNotEmpty ?? false) ||
                              (state.selectedVendor != null) ||
                              (state.selectedDateRange != null) ||
                              (state.selectedRange != null)
                          ? true
                          : false,
                      onFilterPressed: () {
                        _checkOutFilterBottomSheet(context);
                      },
                    ),
                    const Gap(10),
                    Expanded(
                      child: state.isCheckOutLoading
                          ? const LoaderWidget()
                          : state.checkOuts?.isNotEmpty ?? false
                              ? RefreshIndicator(
                                  onRefresh: () async {
                                    await context
                                        .read<CheckOutCubit>()
                                        .getCheckOuts(
                                            keyword: _searchController.text);
                                  },
                                  child: ListView.separated(
                                    controller: _scrollController,
                                    physics: AlwaysScrollableScrollPhysics(),
                                    padding: const EdgeInsets.only(bottom: 10),
                                    shrinkWrap: true,
                                    primary: false,
                                    itemCount: state.checkOuts?.length ?? 0,
                                    itemBuilder: (context, index) {
                                      CheckOutModel? item =
                                          state.checkOuts?[index];
                                      return CheckOutCardWidget(
                                        visitorCount: item?.visitorCount ?? "",
                                        typeText: item?.unit?.unitNumber ?? "",
                                        name: item?.name ?? "--",
                                        profileImageUrl:
                                            item?.visitor?.imageUrl ?? "",
                                        type: item?.type ?? "--",
                                        checkInDate:
                                            DateTimeUtil.getFormattedDateTime(
                                                item?.checkinTime.toString()),
                                        checkOutDate:
                                            DateTimeUtil.getFormattedDateTime(
                                                item?.checkoutTime.toString()),
                                        phone: item?.phone ?? "--",
                                        isMobile: item?.isMobile,
                                        onTap: () {
                                          context
                                              .read<CheckoutDetailsCubit>()
                                              .getCheckOutDetailsLog(
                                                  id: item?.id);
                                          Navigator.pushNamed(context,
                                              AppRoutes.checkOutDetails,
                                              arguments: item);
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
          floatingActionButton: FloatingActionButton.extended(
            backgroundColor: AppColors.primary,
            onPressed: () {
              FileDownloader.downloadFile(
                  context: context,
                  dateRage:
                      '${context.read<CheckOutCubit>().state.selectedDateRange ?? ""}');
            },
            icon: SvgPicture.asset(
              AppImages.export,
              colorFilter:
                  const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              height: 13,
              // fit: BoxFit.scaleDown,
            ),
            label: Text(
              AppUtils.languageTranslate('export'),
              style: AppTextStyles.style13white500,
            ),
          ),
        ));
  }

  void _checkOutFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        context.read<CheckOutCubit>().getUnits();
        context.read<CheckOutCubit>().getVendors();
        return const CheckOutsFilterBottomSheet();
      },
    );
  }
}
