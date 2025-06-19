import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/picker/date_range_picker_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../../bloc/check_out/check_out_cubit.dart';
import '../../../../model/unit/unit_model.dart';
import '../../../../model/vendor/vendor_model.dart';
import '../../../../resource/constants/app_constants.dart';
import '../../../../utils/app_utils.dart';
import '../../../../utils/date_time.dart';

class CheckOutsFilterBottomSheet extends StatefulWidget {
  const CheckOutsFilterBottomSheet({super.key});

  @override
  State<CheckOutsFilterBottomSheet> createState() =>
      _CheckOutsFilterBottomSheetState();
}

class _CheckOutsFilterBottomSheetState
    extends State<CheckOutsFilterBottomSheet> {
  TextEditingController dateRangeController = TextEditingController();
  final now = DateTime.now();
  late DateTime firstDayOfMonth;
  late DateTime lastDayOfMonth;

  @override
  void initState() {
    super.initState();
    final selectedDate = DateTime(now.year, now.month - 1, 1);
    firstDayOfMonth = DateTime(selectedDate.year, selectedDate.month, 1);
    lastDayOfMonth = DateTime(selectedDate.year, selectedDate.month + 1, 0);
  }

  DateTimeRange? dateRangeString;
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
            child: BlocBuilder<CheckOutCubit, CheckOutState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                const Align(
                  alignment: Alignment.center,
                  child: HeadingWidget(
                      heading: 'Check-In Filter',
                      style: AppTextStyles.style16black600),
                ),
                const Gap(15),
                DateRangePickerField(
                  controller: dateRangeController,
                  firstDate: firstDayOfMonth,
                  lastDate: lastDayOfMonth,
                  onDateRangeSelected: (range) {
                    context.read<CheckOutCubit>().onChangeDateRange(range);
                    // print("SelectedRange: $range ");
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<String>(
                  hint: "Range",
                  fillColor: AppColors.white,
                  selectedItem: state.selectedRange,
                  itemAsString: (range) => range,
                  compareFn: (p0, p1) => p0 == p1,
                  items: AppConstants.rangList,
                  onChanged: (value) {
                    if (value == null) {
                      dateRangeController.clear();
                      context.read<CheckOutCubit>().onChangeDateRange(null);
                    } else {
                      dateRangeString =
                          AppUtils.getDateRangeStringFromLabel(value);
                      dateRangeController.text =
                          DateTimeUtil.getFormatDateRange(dateRangeString);
                      context.read<CheckOutCubit>().onChangeDateRange(dateRangeString);
                      // print('dateRangeString $dateRangeString');
                    }
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<TypeModel>(
                    hint: "Type",
                    fillColor: AppColors.white,
                    selectedItem: state.selectedType,
                    itemAsString: (type) => type.label,
                    compareFn: (p0, p1) => p0.value == p1.value,
                    items: AppUtils.checkInTypeList,
                    onChanged: (value) {
                      context.read<CheckOutCubit>().onChangeSelectedType(value);
                    }),
                const Gap(10),
                SingleSelectedDropdownWidget<UnitModel>(
                    hint: "Unit",
                    fillColor: AppColors.white,
                    selectedItem: state.selectedUnit,
                    itemAsString: (unit) => unit.unitNumber ?? "",
                    compareFn: (unit, item) => unit.id == item.id,
                    items: state.units ?? [],
                    onChanged: (value) {
                      context
                          .read<CheckOutCubit>()
                          .onChangeSelectedUnit(value!);
                    }),
                const Gap(10),
                SingleSelectedDropdownWidget<VendorModel>(
                    hint: "Vendors",
                    fillColor: AppColors.white,
                    selectedItem: state.selectedVendor,
                    itemAsString: (vendor) => vendor.companyName ?? "",
                    compareFn: (vendor, item) => vendor.id == item.id,
                    items: state.vendors ?? [],
                    onChanged: (value) {
                      context
                          .read<CheckOutCubit>()
                          .onChangeSelectedVendors(value!);
                    }),
                const Gap(30),
                FilterButtonWidget(
                  applyOnPressed: () {
                    context.read<CheckOutCubit>().getCheckOut();
                    Navigator.pop(context);
                  },
                  clearOnPressed: () {
                    context.read<CheckOutCubit>().resetFilterData();
                    Navigator.pop(context);
                    context.read<CheckOutCubit>().getCheckOut();
                  },
                ),
              ],
            );
          },
        )),
      ),
    );
  }
}

