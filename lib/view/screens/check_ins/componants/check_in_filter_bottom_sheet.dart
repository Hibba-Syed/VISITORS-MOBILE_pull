import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/picker/date_range_picker_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../../model/unit/unit_model.dart';
import '../../../../model/vendor/vendor_model.dart';
import '../../../../utils/date_time.dart';
import '../../../widgets/loader/loader_widget.dart';

class CheckInFilterBottomSheet extends StatefulWidget {
  const CheckInFilterBottomSheet({
    super.key,
  });

  @override
  State<CheckInFilterBottomSheet> createState() =>
      _CheckInFilterBottomSheetState();
}

class _CheckInFilterBottomSheetState extends State<CheckInFilterBottomSheet> {
  TextEditingController dateRangeController = TextEditingController();
  DateTimeRange? dateRangeString;
  final now = DateTime.now();
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;

  @override
  void initState() {
    super.initState();
    firstDayOfMonth = DateTime(now.year, now.month, 1);
    lastDayOfMonth = DateTime(now.year, now.month + 1, 0);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            border: Border.all(color: AppColors.gray)),
        child: SingleChildScrollView(
          child: BlocBuilder<CheckInsCubit, CheckInsState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                 Align(
                  alignment: Alignment.center,
                  child: HeadingWidget(
                      heading:  AppUtils.languageTranslate('checkInFilter'),
                      style: AppTextStyles.style16black600),
                ),
                const Gap(15),
                DateRangePickerField(
                  controller: dateRangeController,
                  firstDate: firstDayOfMonth,
                  lastDate: lastDayOfMonth,
                  onDateRangeSelected: (range) {
                    context.read<CheckInsCubit>().onChangeDateRange(range);
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<String>(
                  hint: AppUtils.languageTranslate('range'),
                  fillColor: AppColors.white,
                  selectedItem: state.selectedRange,
                  itemAsString: (range) => range,
                  compareFn: (p0, p1) => p0 == p1,
                  items: AppConstants.rangList,
                  onChanged: (value) {
                    if (value == null) {
                      dateRangeController.clear();
                      context.read<CheckInsCubit>().onChangeDateRange(null);
                    } else {
                      dateRangeString =
                          AppUtils.getDateRangeStringFromLabel(value);
                      dateRangeController.text =
                          DateTimeUtil.getFormatDateRange(dateRangeString);
                      context
                          .read<CheckInsCubit>()
                          .onChangeDateRange(dateRangeString);
                    }
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<TypeModel>(
                    hint: AppUtils.languageTranslate('type'),
                    fillColor: AppColors.white,
                    selectedItem: state.selectedType,
                    itemAsString: (type) => type.label,
                    compareFn: (p0, p1) => p0.value == p1.value,
                    items: AppUtils.checkInTypeList,
                    onChanged: (value) {
                      context.read<CheckInsCubit>().onChangeSelectedType(value);
                    }),
                const Gap(10),
                BlocBuilder<CheckInsCubit, CheckInsState>(
                  builder: (context, state) {
                    if (state.isUnitLoading) {
                      return LoaderWidget();
                    }

                    return SingleSelectedDropdownWidget<UnitModel>(
                        hint: AppUtils.languageTranslate('unit'),
                        fillColor: AppColors.white,
                        selectedItem: state.selectedUnit,
                        itemAsString: (unit) => unit.unitNumber ?? "",
                        compareFn: (unit, item) => unit.id == item.id,
                        items: state.units ?? [],
                        onChanged: (value) {
                          context
                              .read<CheckInsCubit>()
                              .onChangeSelectedUnit(value!);
                        });
                  },
                ),
                const Gap(10),
                BlocBuilder<CheckInsCubit, CheckInsState>(
                  builder: (context, state) {
                    return SingleSelectedDropdownWidget<VendorModel>(
                        hint: AppUtils.languageTranslate('vendors'),
                        fillColor: AppColors.white,
                        selectedItem: state.selectedVendor,
                        itemAsString: (vendor) => vendor.companyName ?? "",
                        compareFn: (vendor, item) => vendor.id == item.id,
                        items: state.vendors ?? [],
                        onChanged: (value) {
                          context
                              .read<CheckInsCubit>()
                              .onChangeSelectedVendors(value!);
                        });
                  },
                ),
                const Gap(30),
                FilterButtonWidget(
                  applyOnPressed: () {
                    context.read<CheckInsCubit>().getCheckIns();
                    Navigator.pop(context);
                  },
                  clearOnPressed: () {
                    context.read<CheckInsCubit>().resetFilterData();
                    Navigator.pop(context);
                    context.read<CheckInsCubit>().getCheckIns();
                  },
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
