import 'package:flutter/material.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

class ServicesFilterBottomSheet extends StatefulWidget {
  const ServicesFilterBottomSheet({super.key});

  @override
  State<ServicesFilterBottomSheet> createState() =>
      _ServicesFilterBottomSheetState();
}

class _ServicesFilterBottomSheetState extends State<ServicesFilterBottomSheet> {
  String? selectedType;
  String? selectedUnit;

  final List<String> typeList = [
    'Guests',
    'Services',
    'Work Order / RFPs',
    'Visitor Pass'
  ];
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
                  heading: 'E-Services Filter',
                  style: AppTextStyles.style16black600),
            ),
            const Gap(15),
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
            SingleSelectedDropdownWidget<String>(
                hint: "Unit",
                fillColor: AppColors.white,
                selectedItem: selectedUnit,
                itemAsString: (type) => type,
                compareFn: (p0, p1) => p0 == p1,
                items: ['1', '2', '3'],
                onChanged: (value) {
                  selectedUnit = value;
                }),
            const Gap(30),
            FilterButtonWidget(
              applyOnPressed: () {},
              clearOnPressed: () {},
            ),
          ],
        )),
      ),
    );
  }
}
