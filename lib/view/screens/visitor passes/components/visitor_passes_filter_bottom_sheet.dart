import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/styles/styles.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/view/widgets/button/filter_button_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../../bloc/visitor_passes/visitor_pass_cubit.dart';
import '../../../../model/unit/unit_model.dart';
import '../../../widgets/loader/loader_widget.dart';

class VisitorPassesFilterBottomSheet extends StatefulWidget {
  const VisitorPassesFilterBottomSheet({super.key});

  @override
  State<VisitorPassesFilterBottomSheet> createState() =>
      _VisitorPassesFilterBottomSheetState();
}

class _VisitorPassesFilterBottomSheetState
    extends State<VisitorPassesFilterBottomSheet> {
  UnitModel? _selectedUnit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final visitorPassState = context.read<VisitorPassCubit>().state;
      _selectedUnit = visitorPassState.selectedUnit;
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(10),
              Align(
                alignment: Alignment.center,
                child: HeadingWidget(
                    heading: AppUtils.languageTranslate('visitorPassesFilter'),
                    style: AppTextStyles.style16black600),
              ),
              const Gap(15),
              BlocBuilder<VisitorPassCubit, VisitorPassState>(
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
                    onChanged: (value) {
                      _selectedUnit = value;
                    },
                  );
                },
              ),
              const Gap(30),
              FilterButtonWidget(
                applyOnPressed: () {
                  context
                      .read<VisitorPassCubit>()
                      .onChangeSelectedUnit(_selectedUnit);
                  context.read<VisitorPassCubit>().getVisitorPasses();
                  Navigator.pop(context);
                },
                clearOnPressed: () {
                  _selectedUnit = null;
                  context.read<VisitorPassCubit>().resetFilterData();
                  Navigator.pop(context);
                  context.read<VisitorPassCubit>().getVisitorPasses();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
