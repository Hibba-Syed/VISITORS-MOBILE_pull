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

class CheckOutsFilterBottomSheet extends StatefulWidget {
  const CheckOutsFilterBottomSheet({super.key});

  @override
  State<CheckOutsFilterBottomSheet> createState() =>
      _CheckOutsFilterBottomSheetState();
}

class _CheckOutsFilterBottomSheetState
    extends State<CheckOutsFilterBottomSheet> {
  DateTimeRange? _selectedDateRange;
  String? _selectedRange;
  TypeModel? _selectedType;
  UnitModel? _selectedUnit;
  VendorModel? _selectedVendor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final checkoutCubit = context.read<CheckOutCubit>().state;
      _selectedDateRange = checkoutCubit.selectedDateRange;
      _selectedRange = checkoutCubit.selectedRange;
      _selectedType = checkoutCubit.selectedType;
      _selectedUnit = checkoutCubit.selectedUnit;
      _selectedVendor = checkoutCubit.selectedVendor;
      setState(() {});
    });
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
            child: BlocBuilder<CheckOutCubit, CheckOutState>(
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Align(
                  alignment: Alignment.center,
                  child: HeadingWidget(
                      heading: AppUtils.languageTranslate('checkOutFilter'),
                      style: AppTextStyles.style16black600),
                ),
                const Gap(15),
                DateRangePickerWidget(
                  initialDateRange: _selectedDateRange,
                  firstDate: DateTime(2020, 1, 1),
                  lastDate: DateTime(2030, 12, 31),
                  onDateRangePicked: (value) {
                    _selectedDateRange = value;
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<String>(
                  hint: AppUtils.languageTranslate('range'),
                  fillColor: AppColors.white,
                  selectedItem: _selectedRange,
                  itemAsString: (range) => range,
                  compareFn: (p0, p1) => p0 == p1,
                  items: AppConstants.rangeList,
                  onChanged: (value) {
                    _selectedRange = value;

                    if (value == null) {
                      _selectedDateRange = null;
                    } else {
                      _selectedDateRange =
                          AppUtils.getDateRangeStringFromLabel(value);
                    }
                    setState(() {});
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<TypeModel>(
                  hint: AppUtils.languageTranslate('type'),
                  fillColor: AppColors.white,
                  selectedItem: _selectedType,
                  itemAsString: (type) => type.label,
                  compareFn: (p0, p1) => p0.value == p1.value,
                  items: AppUtils.checkInTypeList,
                  onChanged: (value) {
                    _selectedType = value;
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<UnitModel>(
                  hint: AppUtils.languageTranslate('unit'),
                  fillColor: AppColors.white,
                  selectedItem: state.selectedUnit,
                  itemAsString: (unit) => unit.unitNumber ?? "",
                  compareFn: (unit, item) => unit.id == item.id,
                  items: state.units ?? [],
                  enabled: _selectedVendor == null,
                  onChanged: (value) {
                    setState(() {
                      _selectedUnit = value;
                    });
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<VendorModel>(
                  hint: AppUtils.languageTranslate('vendors'),
                  fillColor: AppColors.white,
                  selectedItem: state.selectedVendor,
                  itemAsString: (vendor) => vendor.companyName ?? "",
                  compareFn: (vendor, item) => vendor.id == item.id,
                  items: state.vendors ?? [],
                  enabled: _selectedUnit == null,
                  onChanged: (value) {
                    setState(() {
                      _selectedVendor = value;
                    });
                  },
                ),
                const Gap(30),
                FilterButtonWidget(
                  applyOnPressed: () {
                    final cubit = context.read<CheckOutCubit>();

                    cubit.onChangeDateRange(_selectedDateRange);
                    cubit.onChangeSelectedRange(_selectedRange);
                    cubit.onChangeSelectedType(_selectedType);
                    cubit.onChangeSelectedUnit(_selectedUnit);
                    cubit.onChangeSelectedVendors(_selectedVendor);
                    context.read<CheckOutCubit>().getCheckOuts();
                    Navigator.pop(context);
                  },
                  clearOnPressed: () {
                    _selectedDateRange = null;
                    _selectedRange = null;
                    _selectedType = null;
                    _selectedUnit = null;
                    _selectedVendor = null;
                    context.read<CheckOutCubit>().resetFilterData();
                    Navigator.pop(context);
                    context.read<CheckOutCubit>().getCheckOuts();
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
