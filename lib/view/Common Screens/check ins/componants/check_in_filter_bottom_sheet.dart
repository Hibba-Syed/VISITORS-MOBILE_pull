import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/loader/loader_widget.dart';
import 'package:visitors/view/widgets/picker/date_range_picker_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../../model/unit/unit_model.dart';
import '../../../../model/unit/units_response_model.dart';
import '../../../../model/vendor/vendor_response_model.dart';

class CheckInFilterBottomSheet extends StatefulWidget {
  final String? keywordFilter;
  final String? selectedDateRange;
  final String? selectedRang;
  final String? selectedType;
  final UnitModel? selectedUnit;
  final VendorsRecord? selectedVendor;
  final Function(UnitModel? value)? onChangeUnit;
  final Function(String? value)? onChangeDateRange;
  final Function(String? value)? onChangeRang;
  final Function(VendorsRecord? value)? onChangeVendor;
  final Function(String? value)? onChangeType;
  const CheckInFilterBottomSheet({super.key,
    this.keywordFilter,
    this.selectedDateRange,
    this.onChangeRang,
    this.selectedRang,
    this.selectedType,
    this.onChangeDateRange,
    this.onChangeUnit,
    this.onChangeVendor,
    this.selectedUnit,
    this.selectedVendor,
    this.onChangeType,

  });

  @override
  State<CheckInFilterBottomSheet> createState() =>
      _CheckInFilterBottomSheetState();
}

class _CheckInFilterBottomSheetState extends State<CheckInFilterBottomSheet> {
  String? selectedDateRange;
  String? selectedRang;
  String? selectedType;
  UnitModel? selectedUnit;
  VendorsRecord? selectedVendor;

  final List<String> rangList = [
    'Last 30 Days',
    'Last 60 Days',
    'Last 90 Days'
  ];
  List<RangeModel?>? statuesList = [
    RangeModel(label: "Last 30 Days", value: "Last 30 Days"),
    RangeModel(label: "Last 60 Days", value: "Last 60 Days"),
    RangeModel(label: "Last 90 Days", value: "Last 90 Days"),
  ];
  final List<String> typeList = [
    'Guests',
    'Services',
    'Work Order / RFPs',
    'Visitor Pass'
  ];
  @override
  void initState() {
    selectedDateRange = widget.selectedDateRange;
    selectedRang = widget.selectedRang;
    selectedType = widget.selectedType;
    selectedUnit = widget.selectedUnit;
    selectedVendor = widget.selectedVendor;
    super.initState();
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
                  selectedDate: selectedDateRange,
                  onChangeDate: (value) {
                    selectedDateRange = value;
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<String>(
                    hint: "Range",
                    fillColor: AppColors.white,
                    selectedItem: selectedRang,
                    itemAsString: (rang) => rang,
                    compareFn: (p0, p1) => p0 == p1,
                    items: rangList,
                    onChanged: (value) {
                      selectedRang = value;
                    }),
                const Gap(10),
                SingleSelectedDropdownWidget<String>(
                    hint: "Type",
                    fillColor: AppColors.white,
                    selectedItem: selectedType,
                    itemAsString: (type) => type,
                    compareFn: (p0, p1) => p0 == p1,
                    items: typeList,
                    onChanged: (value) {
                      selectedType = value;
                    }),
                const Gap(10),
                BlocBuilder<CheckInsCubit, CheckInsState>(
                  builder: (context, state) {
                    if (state.isUnitLoading) {
                      return LoaderWidget();
                    }
                    return SingleSelectedDropdownWidget<UnitModel>(
                        hint: "Unit",
                        fillColor: AppColors.white,
                        selectedItem: selectedUnit,
                        itemAsString: (unit) => unit.unitNumber ?? "",
                        compareFn: (p0, p1) => p0.id == p1.id,
                        items: state.units ?? [],
                        onChanged: (value) {
                          selectedUnit = value;
                        });
                  },
                ),
                const Gap(10),
                BlocBuilder<CheckInsCubit, CheckInsState>(
                  builder: (context, state) {
                    return SingleSelectedDropdownWidget<VendorsRecord>(
                        hint: "Vendors",
                        fillColor: AppColors.white,
                        selectedItem: selectedVendor,
                        itemAsString: (vendor) => vendor.companyName ?? "",
                        compareFn: (p0, p1) => p0.id == p1.id,
                        items: state.vendorsModel?.record ?? [],
                        onChanged: (value) {
                          selectedVendor = value;
                        });
                  },
                ),
                const Gap(30),
                FilterButtonWidget(
                  applyOnPressed: () {
                    widget.onChangeType?.call(selectedType);
                    widget.onChangeVendor?.call(selectedVendor);
                    widget.onChangeUnit?.call(selectedUnit);
                    widget.onChangeDateRange?.call(selectedDateRange);
                    widget.onChangeRang?.call(selectedRang);
                    context.read<CheckInsCubit>().getCheckIns(
                        keyword: widget.keywordFilter,
                      unitId: widget.selectedUnit?.id,
                      vendorId: widget.selectedVendor?.id,
                      dateRange: widget.selectedDateRange,
                      serviceableType: widget.selectedType
                    );
                    print('vendor ${widget.selectedDateRange}${widget.selectedUnit?.id} ${widget.selectedType}');
                    Navigator.pop(context);
                  },
                  clearOnPressed: () {
                    context.read<CheckInsCubit>().getCheckIns(
                        keyword: widget.keywordFilter,);
                    widget.onChangeRang?.call(null);
                    widget.onChangeDateRange?.call(null);
                    widget.onChangeUnit?.call(null);
                    widget.onChangeVendor?.call(null);
                    widget.onChangeType?.call(null);
                    Navigator.pop(context);
                  },
                ),
              ],
            )),
      ),
    );
  }
}
class RangeModel{
  final String? label;
  final String? value;
  RangeModel({
    this.label,
    this.value,
  });
}