import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
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
  DateTimeRange? _selectedDateRange;
  String? _selectedRange;
  TypeModel? _selectedType;
  UnitModel? _selectedUnit;
  VendorModel? _selectedVendor;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final checkInsState = context.read<CheckInsCubit>().state;
      _selectedDateRange = checkInsState.selectedDateRange;
      _selectedRange = checkInsState.selectedRange;
      _selectedType = checkInsState.selectedVisitorType;
      _selectedUnit = checkInsState.selectedUnit;
      _selectedVendor = checkInsState.selectedVendor;
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
          child: BlocBuilder<CheckInsCubit, CheckInsState>(
              builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Gap(10),
                Align(
                  alignment: Alignment.center,
                  child: HeadingWidget(
                      heading: AppUtils.languageTranslate('checkInFilter'),
                      style: AppTextStyles.style16black600),
                ),
                const Gap(15),
                DateRangePickerWidget(
                  initialDateRange: _selectedDateRange,
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
                BlocBuilder<CheckInsCubit, CheckInsState>(
                  builder: (context, state) {
                    if (state.isUnitLoading) {
                      return LoaderWidget();
                    }
                    return SingleSelectedDropdownWidget<UnitModel>(
                      hint: AppUtils.languageTranslate('unit'),
                      fillColor: AppColors.white,
                      selectedItem: _selectedUnit,
                      itemAsString: (unit) => unit.unitNumber ?? "",
                      compareFn: (unit, item) => unit.id == item.id,
                      items: state.units ?? [],
                      enabled: _selectedVendor == null,
                      onChanged: (value) {
                        setState(() {
                          _selectedUnit = value;
                        });
                      },
                    );
                  },
                ),
                const Gap(10),
                BlocBuilder<CheckInsCubit, CheckInsState>(
                  builder: (context, state) {
                    return SingleSelectedDropdownWidget<VendorModel>(
                      hint: AppUtils.languageTranslate('vendors'),
                      fillColor: AppColors.white,
                      selectedItem: _selectedVendor,
                      itemAsString: (vendor) => vendor.companyName ?? "",
                      compareFn: (vendor, item) => vendor.id == item.id,
                      items: state.vendors ?? [],
                      enabled: _selectedUnit == null,
                      onChanged: (value) {
                        setState(() {
                          _selectedVendor = value;
                        });
                      },
                    );
                  },
                ),
                const Gap(30),
                FilterButtonWidget(
                  applyOnPressed: () {
                    final cubit = context.read<CheckInsCubit>();

                    cubit.onChangeDateRange(_selectedDateRange);
                    cubit.onChangeSelectedRange(_selectedRange);
                    cubit.onChangeSelectedVisitorType(_selectedType);
                    cubit.onChangeSelectedUnit(_selectedUnit);
                    cubit.onChangeSelectedVendors(_selectedVendor);
                    context.read<CheckInsCubit>().getCheckIns();
                    Navigator.pop(context);
                  },
                  clearOnPressed: () {
                    _selectedDateRange = null;
                    _selectedRange = null;
                    _selectedType = null;
                    _selectedUnit = null;
                    _selectedVendor = null;
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
