import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/work_order/work_order_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../../model/vendor/vendor_model.dart';

class WorkOrderFilterBottomSheet extends StatefulWidget {
  const WorkOrderFilterBottomSheet({super.key});

  @override
  State<WorkOrderFilterBottomSheet> createState() =>
      _WorkOrderFilterBottomSheetState();
}

class _WorkOrderFilterBottomSheetState
    extends State<WorkOrderFilterBottomSheet> {
  final List<String> typeList = [
    'RFPs',
    'Work Orders',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      width: double.maxFinite,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
      decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          border: Border.all(color: AppColors.gray)),
      child: SingleChildScrollView(
        child: BlocBuilder<WorkOrderCubit, WorkOrderState>(
            builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              const Align(
                alignment: Alignment.center,
                child: HeadingWidget(
                    heading: 'Work Order / RFP Filter',
                    style: AppTextStyles.style16black600),
              ),
              const Gap(15),
              SingleSelectedDropdownWidget<String>(
                  hint: "Type",
                  fillColor: AppColors.white,
                  selectedItem: state.selectedType,
                  itemAsString: (type) => type,
                  compareFn: (p0, p1) => p0 == p1,
                  items: typeList,
                  onChanged: (value) {
                    context.read<WorkOrderCubit>().onChangeSelectedType(value);
                  }),
              const Gap(10),
              SingleSelectedDropdownWidget<VendorModel>(
                  hint: "Vendors",
                  fillColor: AppColors.white,
                  selectedItem:
                      context.watch<WorkOrderCubit>().state.selectedVendor,
                  itemAsString: (vendor) => vendor.companyName ?? "",
                  compareFn: (vendor, item) => vendor.id == item.id,
                  items: state.vendors ?? [],
                  onChanged: (value) {
                    context
                        .read<WorkOrderCubit>()
                        .onChangeSelectedVendors(value!);
                  }),
              const Gap(30),
              FilterButtonWidget(
                applyOnPressed: () {
                  context.read<WorkOrderCubit>().getWorkOrder();
                  Navigator.pop(context);
                },
                clearOnPressed: () {
                  context.read<WorkOrderCubit>().clearFilterData();
                  Navigator.pop(context);
                  context.read<WorkOrderCubit>().getWorkOrder();
                },
              ),
            ],
          );
        }),
      ),
    ));
  }
}
