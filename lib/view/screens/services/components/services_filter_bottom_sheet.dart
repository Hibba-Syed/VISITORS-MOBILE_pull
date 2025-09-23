import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/bloc/e_service/service_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../../model/unit/unit_model.dart';
import '../../../widgets/loader/loader_widget.dart';

class ServicesFilterBottomSheet extends StatefulWidget {
  const ServicesFilterBottomSheet({super.key});

  @override
  State<ServicesFilterBottomSheet> createState() =>
      _ServicesFilterBottomSheetState();
}

class _ServicesFilterBottomSheetState extends State<ServicesFilterBottomSheet> {
  TypeModel? _selectedType;
  UnitModel? _selectedUnit;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final serviceState = context.read<ServiceCubit>().state;
      _selectedType = serviceState.selectedType;
      _selectedUnit = serviceState.selectedUnit;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ConstrainedBox(
        constraints: const BoxConstraints(minWidth: 600),
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
              child: BlocBuilder<ServiceCubit, ServiceState>(
            builder: (context, state) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  Align(
                    alignment: Alignment.center,
                    child: HeadingWidget(
                        heading: AppUtils.languageTranslate('eServicesFilter'),
                        style: AppTextStyles.style16black600),
                  ),
                  const Gap(15),
                  SingleSelectedDropdownWidget<TypeModel>(
                      hint: AppUtils.languageTranslate('type'),
                      fillColor: AppColors.white,
                      selectedItem: _selectedType,
                      itemAsString: (type) => type.label,
                      compareFn: (type, item) => type.value == item.value,
                      items: AppUtils().serviceTypeList,
                      onChanged: (value) {
                        _selectedType = value;
                      }),
                  const Gap(10),
                  state.isUnitLoading
                      ? LoaderWidget()
                      : SingleSelectedDropdownWidget<UnitModel>(
                          hint: AppUtils.languageTranslate('unit'),
                          fillColor: AppColors.white,
                          selectedItem: _selectedUnit,
                          itemAsString: (unit) => unit.unitNumber ?? "",
                          compareFn: (unit, item) => unit.id == item.id,
                          items: state.units ?? [],
                          onChanged: (value) {
                            _selectedUnit = value;
                          }),
                  const Gap(30),
                  FilterButtonWidget(
                    applyOnPressed: () {
                      final cubit = context.read<ServiceCubit>();

                      cubit.onChangeSelectedType(_selectedType);
                      cubit.onChangeSelectedUnit(_selectedUnit);
                      context.read<ServiceCubit>().getServices();
                      Navigator.pop(context);
                    },
                    clearOnPressed: () {
                      _selectedType = null;
                      _selectedUnit = null;
                      context.read<ServiceCubit>().resetFilterData();
                      Navigator.pop(context);
                      context.read<ServiceCubit>().getServices();
                    },
                  ),
                ],
              );
            },
          )),
        ),
      ),
    );
  }
}
