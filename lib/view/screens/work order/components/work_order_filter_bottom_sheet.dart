import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/work_order/work_order_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
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
  VendorModel? _selectedVendor;
  TypeModel? _selectedType;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final workOrderState = context.read<WorkOrderCubit>().state;
      _selectedType = workOrderState.selectedType;
      _selectedVendor = workOrderState.selectedVendor;
      setState(() {});
    });
  }

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
                Align(
                  alignment: Alignment.center,
                  child: HeadingWidget(
                      heading: AppUtils.languageTranslate('workOrderRfpFilter'),
                      style: AppTextStyles.style16black600),
                ),
                const Gap(15),
                SingleSelectedDropdownWidget<TypeModel>(
                  hint: AppUtils.languageTranslate('type'),
                  fillColor: AppColors.white,
                  selectedItem: _selectedType,
                  itemAsString: (type) => type.label,
                  compareFn: (p0, p1) => p0.value == p1.value,
                  items: AppUtils.workOrderType,
                  onChanged: (value) {
                    _selectedType = value;

                    if (value?.value != '1') {
                      _selectedVendor = null;
                    }
                    setState(() {});
                  },
                ),
                const Gap(10),
                SingleSelectedDropdownWidget<VendorModel>(
                    hint: AppUtils.languageTranslate('vendors'),
                    outLineColor: AppColors.outLineGray,
                    fillColor: AppColors.white,
                    selectedItem: _selectedVendor,
                    itemAsString: (vendor) => vendor.companyName ?? "",
                    compareFn: (vendor, item) => vendor.id == item.id,
                    items: state.vendors ?? [],
                    onChanged: (value) {
                      _selectedVendor = value;
                    },
                    enabled: _selectedType?.value == '1' ? true : false),
                const Gap(30),
                FilterButtonWidget(
                  applyOnPressed: () {
                    context
                        .read<WorkOrderCubit>()
                        .onChangeSelectedType(_selectedType);
                    context
                        .read<WorkOrderCubit>()
                        .onChangeSelectedVendors(_selectedVendor);
                    context.read<WorkOrderCubit>().getWorkOrder();
                    Navigator.pop(context);
                  },
                  clearOnPressed: () {
                    _selectedType = null;
                    _selectedVendor = null;
                    context.read<WorkOrderCubit>().resetFilterData();
                    Navigator.pop(context);
                    context.read<WorkOrderCubit>().getWorkOrder();
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
