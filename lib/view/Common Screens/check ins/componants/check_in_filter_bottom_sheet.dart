import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/picker/date_range_picker_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

class CheckInFilterBottomSheet extends StatefulWidget {
  const CheckInFilterBottomSheet({super.key});

  @override
  State<CheckInFilterBottomSheet> createState() =>
      _CheckInFilterBottomSheetState();
}

class _CheckInFilterBottomSheetState extends State<CheckInFilterBottomSheet> {
  String? _selectedDateRange;
  String?  _selectedRang;
  String? _selectedType;
  String? _selectedUnit;
  String? _selectedVendor;

  final List<String> rangList = ['Last 30 Days', 'Last 60 Days','Last 90 Days'];
  final List<String> typeList = ['Guests', 'Services','Work Order / RFPs','Visitor Pass'];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20),
          ),
          border: Border.all(color: AppColors.gray)
        ),
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
              selectedDate: _selectedDateRange,
              onChangeDate: (value) {
                _selectedDateRange = value;
              },
            ),
            const Gap(10),
            SingleSelectedDropdownWidget<String>(
                hint: "Range",
                fillColor: AppColors.white,
                selectedItem: _selectedRang,
                itemAsString: (rang) => rang,
                compareFn: (p0, p1) => p0 == p1,
                items:rangList,
                onChanged: (value) {
                  _selectedRang = value;
                }),
            const Gap(10),
            SingleSelectedDropdownWidget<String>(
                hint: "Type",
                fillColor: AppColors.white,
                selectedItem: _selectedType,
                itemAsString: (type) => type,
                compareFn: (p0, p1) => p0 == p1,
                items:typeList,
                onChanged: (value) {
                  _selectedType = value;
                }),
            const Gap(10),
            SingleSelectedDropdownWidget<String>(
                hint: "Unit",
                fillColor: AppColors.white,
                selectedItem: _selectedUnit,
                itemAsString: (type) => type,
                compareFn: (p0, p1) => p0 == p1,
                items: ['1','2','3'],
                onChanged: (value) {
                  _selectedUnit = value;
                }),
            const Gap(10),
            SingleSelectedDropdownWidget<String>(
                hint: "Vendors",
                fillColor: AppColors.white,
                selectedItem: _selectedVendor,
                itemAsString: (type) => type,
                compareFn: (p0, p1) => p0 == p1,
                items: ['A','B','C'],
                onChanged: (value) {
                  _selectedVendor = value;
                }),
            const Gap(30),
            FilterButtonWidget(
              applyOnPressed: () {  },
              clearOnPressed: () {  },),
          ],
        )),
      ),
    );
  }
}
