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
import '../../../widgets/loader/loader_widget.dart';
class CheckOutsFilterBottomSheet extends StatefulWidget {
  const CheckOutsFilterBottomSheet({super.key});

  @override
  State<CheckOutsFilterBottomSheet> createState() => _CheckOutsFilterBottomSheetState();
}

class _CheckOutsFilterBottomSheetState extends State<CheckOutsFilterBottomSheet> {
  // String? selectedRang;
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
            child: Column(
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
                CustomDateRangePickerWidget(
                  hintText: "Date Range",
                  selectedDate: context.watch<CheckOutCubit>().state.dateRang,
                  onChangeDate: (value) {
                    context.read<CheckOutCubit>().onChangeDateRange(value);
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<String>(
                  hint: "Range",
                  fillColor: AppColors.white,
                  selectedItem: context.watch<CheckOutCubit>().state.selectedRang,
                  itemAsString: (rang) => rang,
                  compareFn: (p0, p1) => p0 == p1,
                  items: AppConstants.rangList,
                  onChanged: (value) {
                    if (value != null) {
                      final dateRangeString = AppUtils.getDateRangeStringFromLabel(value);
                      context.read<CheckOutCubit>().onChangeDateRange(dateRangeString);

                    }
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<TypeModel>(
                    hint: "Type",
                    fillColor: AppColors.white,
                    selectedItem: context.watch<CheckOutCubit>().state.selectedType,
                    itemAsString: (type) => type.label,
                    compareFn: (p0, p1) => p0.value == p1.value,
                    items: AppUtils.checkInTypeList,
                    onChanged: (value) {
                      context.read<CheckOutCubit>().onChangeSelectedType(value);
                    }),
                const Gap(10),
                BlocBuilder<CheckOutCubit, CheckOutState>(
                  builder: (context, state) {
                    if (state.isUnitLoading) {
                      return LoaderWidget();
                    }

                    return SingleSelectedDropdownWidget<UnitModel>(
                        hint: "Unit",
                        fillColor: AppColors.white,
                        selectedItem:
                        context.watch<CheckOutCubit>().state.selectedUnit,
                        itemAsString: (unit) => unit.unitNumber ?? "",
                        compareFn: (unit, item) => unit.id == item.id,
                        items: state.units ?? [],
                        onChanged: (value) {
                          context
                              .read<CheckOutCubit>()
                              .onChangeSelectedUnit(value!);
                        });
                  },
                ),
                const Gap(10),
                BlocBuilder<CheckOutCubit, CheckOutState>(
                  builder: (context, state) {
                    return SingleSelectedDropdownWidget<VendorModel>(
                        hint: "Vendors",
                        fillColor: AppColors.white,
                        selectedItem:
                        context.watch<CheckOutCubit>().state.selectedVendor,
                        itemAsString: (vendor) => vendor.companyName ?? "",
                        compareFn: (vendor, item) => vendor.id == item.id,
                        items: state.vendors ?? [],
                        onChanged: (value) {
                          context
                              .read<CheckOutCubit>()
                              .onChangeSelectedVendors(value!);
                        });
                  },
                ),
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
            )),
      ),
    );
  }
}
