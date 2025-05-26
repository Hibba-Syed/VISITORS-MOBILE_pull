import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/device%20decider/device_decider_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/date_time.dart';
import 'package:visitors/view/Common%20Screens/check%20outs/components/check_outs_card_widget.dart';
import 'package:visitors/view/Common%20Screens/check%20outs/components/check_outs_filter_bottom_sheet.dart';
import 'package:visitors/view/widgets/Filter/filter_widget.dart';
import 'package:visitors/view/widgets/button/custom_button.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/text%20field/search_text_field.dart';

import '../../../bloc/check_out/check_out_cubit.dart';
import '../../../model/check_out/check_out_model.dart';
import '../../../service/download_file/pdf_downloader.dart';
import '../../widgets/empty_widget.dart';

class CheckOutsScreen extends StatefulWidget {
  const CheckOutsScreen({super.key});

  @override
  State<CheckOutsScreen> createState() => _CheckOutsScreenState();
}

class _CheckOutsScreenState extends State<CheckOutsScreen> {
  final TextEditingController _searchController = TextEditingController();
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
        body: BlocBuilder<CheckOutCubit, CheckOutState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              child: Column(
                children: [
                  const Gap(10),
                  Row(
                    children: [
                       Flexible(child: SearchTextField(
                          controller: _searchController,
                          onClearPressed: () async {
                            _searchController.clear();
                             context
                                .read<CheckOutCubit>()
                                .onChangeSearchKeyWord('');
                            context.read<CheckOutCubit>().getCheckOut();
                          },
                          onFieldSubmitted: (value) {
                            context
                                .read<CheckOutCubit>().
                            onChangeSearchKeyWord(value);
                            context.read<CheckOutCubit>().getCheckOut();
                          }
                      )),
                      const Gap(6),
                      FilterContainerWidget(
                        isFilterApplied: (state.selectedUnit != null) ||
                            (state.selectedType?.value.isNotEmpty ??
                                false) ||
                            (state.selectedVendor != null) ||
                            (state.dateRang != null) || (state.selectedRang != null)
                            ? true
                            : false,
                        onPressed: () {
                          _checkOutFilterBottomSheet(context);
                        },
                      )
                    ],
                  ),
                  const Gap(10),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: CustomButton(
                        buttonColor: AppColors.primary,
                        text: 'Export',
                        height: 41,
                        width: 90,
                        borderRadius: 6,
                        onPressed: () {
                          FileDownloader.downloadFile(context: context);
                        }),
                  ),
                  const Gap(10),
                  Expanded(
                    child:
                    state.isCheckOutLoading
                        ? const LoaderWidget()
                        : state.checkOutModel?.isNotEmpty ?? false
                        ?
                    RefreshIndicator(
                      onRefresh: () async{
                       await context.read<CheckOutCubit>().getCheckOut();
                      },
                      child: ListView.separated(
                        physics: AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 10),
                        shrinkWrap: true,
                        primary: false,
                        itemCount: state.checkOutModel?.length ?? 0,
                        itemBuilder: (context, index) {
                          CheckOutModel? checkOutModel = state.checkOutModel?[index];
                          return CheckOutsCardWidget(
                            visitorCount: checkOutModel?.visitorCount ?? "",
                            typeText: checkOutModel?.unit?.unitNumber ?? "",
                            name: checkOutModel?.name ?? "",
                            profileImageUrl: checkOutModel?.visitor?.imageUrl ?? "",
                            type: checkOutModel?.type ?? "",
                            checkInDate: DateTimeUtil.getFormattedDateTime(checkOutModel?.checkinTime.toString()),
                            checkOutDate: DateTimeUtil.getFormattedDateTime(checkOutModel?.checkoutTime.toString()),
                            phone: checkOutModel?.phone ?? "",
                            checkInGateValue: checkOutModel?.checkinGate ?? "",
                            checkOutGateValue: checkOutModel?.checkoutGate ?? "",
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const Gap(10);
                        },
                      ),
                    ) : const EmptyWidget(
                      text: 'No data found',
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  _checkOutFilterBottomSheet(context) {
    showModalBottomSheet(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width,
      ),
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) {
        context.read<CheckOutCubit>().getVendors();
        context.read<CheckOutCubit>().getUnits();
        return const CheckOutsFilterBottomSheet();
      },
    );
  }
}
