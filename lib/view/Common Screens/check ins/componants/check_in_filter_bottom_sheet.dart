import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/check_ins/check_ins_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/picker/date_range_picker_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../../model/unit/unit_model.dart';
import '../../../../model/vendor/vendor_model.dart';
import '../../../widgets/loader/loader_widget.dart';


class CheckInFilterBottomSheet extends StatefulWidget {
  const CheckInFilterBottomSheet({super.key,

  });

  @override
  State<CheckInFilterBottomSheet> createState() =>
      _CheckInFilterBottomSheetState();
}

class _CheckInFilterBottomSheetState extends State<CheckInFilterBottomSheet> {
  String? selectedRang;

  final List<String> rangList = [
    'Last 30 Days',
    'Last 60 Days',
    'Last 90 Days'
  ];

  final List<TypeModel> typeList = [
    TypeModel(label: 'Guests', value: 'guest'),
    TypeModel(label: 'Services', value: 'application'),
    TypeModel(label: 'Work Order / RFPs', value: 'job'),
    TypeModel(label: 'Visitor Pass', value: 'visitor Pass'),];

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
                  selectedDate: context.watch<CheckInsCubit>().state.dateRang,
                  onChangeDate: (value) {
                    context.read<CheckInsCubit>().onChangeDateRange(value);
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
                    final dateRangeString = getDateRangeStringFromLabel(value!);
                    context.read<CheckInsCubit>().onChangeDateRange(dateRangeString);
                    print('dateRange $dateRangeString');
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<TypeModel>(
                    hint: "Type",
                    fillColor: AppColors.white,
                    selectedItem:  context.watch<CheckInsCubit>().state.selectedType,
                    itemAsString: (type) => type.label,
                    compareFn:(p0, p1) => p0.value == p1.value,
                    items: typeList,
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
                        hint: "Unit",
                        fillColor: AppColors.white,
                         selectedItem: context.watch<CheckInsCubit>().state.selectedUnit,
                        itemAsString: (unit) => unit.unitNumber ?? "",
                        compareFn: (unit, item) => unit.id == item.id,
                        items: state.units ?? [],
                        onChanged: (value) {
                          context.read<CheckInsCubit>().onChangeSelectedUnit(value!);
                        });
                  },
                ),
                const Gap(10),
                BlocBuilder<CheckInsCubit, CheckInsState>(
                  builder: (context, state) {
                    return SingleSelectedDropdownWidget<VendorModel>(
                        hint: "Vendors",
                        fillColor: AppColors.white,
                        selectedItem: context.watch<CheckInsCubit>().state.selectedVendor,
                        itemAsString: (vendor) => vendor.companyName ?? "",
                        compareFn: (vendor, item) => vendor.id == item.id,
                        items: state.vendors ?? [],
                        onChanged: (value) {
                          context.read<CheckInsCubit>().onChangeSelectedVendors(value!);
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
                    context.read<CheckInsCubit>().clearFilterData();
                    Navigator.pop(context);
                     context.read<CheckInsCubit>().getCheckIns();
                  },
                ),
              ],
            )),
      ),
    );
  }
  String getDateRangeStringFromLabel(String label) {
    final now = DateTime.now();
    DateTime fromDate;
    if (label == 'Last 30 Days') {
      fromDate = now.subtract(const Duration(days: 30));
    } else if (label == 'Last 60 Days') {
      fromDate = now.subtract(const Duration(days: 60));
    } else if (label == 'Last 90 Days') {
      fromDate = now.subtract(const Duration(days: 90));
    } else {
      fromDate = now;
    }
    String format(DateTime date) {
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    }

    return '${format(fromDate)} - ${format(now)}';
  }

}
class TypeModel {
  final String label;
  final String value;

  TypeModel({required this.label, required this.value});
}
