import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart' show Gap;
import 'package:visitors/bloc/directory/directory_cubit.dart';
import 'package:visitors/resource/constants/app_colors.dart';
import 'package:visitors/resource/constants/app_constants.dart';
import 'package:visitors/utils/app_utils.dart';
import 'package:visitors/view/widgets/empty_widget.dart';
import 'package:visitors/view/widgets/heading_widget.dart';
import 'package:visitors/view/widgets/single_selected_dropdown_widget.dart';

import '../../../bloc/main_dashboard/main_dashboard_cubit.dart';
import '../../../model/unit/unit_model.dart';
import '../../widgets/phone_email_information_card_widget.dart';

class DirectoryScreen extends StatefulWidget {
  const DirectoryScreen({super.key});

  @override
  State<DirectoryScreen> createState() => _DirectoryScreenState();
}

class _DirectoryScreenState extends State<DirectoryScreen> {
  Locale? _currentLocale;
  @override
  void didChangeDependencies() {
    final locale = Localizations.localeOf(context);
    if (locale != _currentLocale) {
      _currentLocale = locale;
      setState(() {});
    }
    super.didChangeDependencies();
  }
@override
  void initState() {
  context.read<DirectoryCubit>().getUnits();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, dynamic) async {
        if (didPop) return;
        context.read<MainDashboardCubit>().onBackButtonPressed();
      },
      child: Scaffold(
        body: BlocBuilder<DirectoryCubit, DirectoryState>(
          builder: (context, state) {
            final selectedUnit = state.selectedUnit;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.horizontalPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(10),
                  SingleSelectedDropdownWidget<UnitModel>(
                    hint: AppUtils.languageTranslate('unit'),
                    fillColor: AppColors.white,
                    selectedItem: selectedUnit,
                    itemAsString: (unit) => unit.unitNumber ?? "",
                    compareFn: (unit, item) => unit.id == item.id,
                    items: state.units ?? [],
                    onChanged: (value) {
                      if (value != null) {
                        context
                            .read<DirectoryCubit>()
                            .onChangeSelectedUnit(value);
                        final selectedUnit = value;
                        final primaryOwner =
                            (selectedUnit.primaryOwner?.isNotEmpty ?? false)
                                ? selectedUnit.primaryOwner?.first
                                : null;
                        final resident = selectedUnit.resident;
                        context
                            .read<DirectoryCubit>()
                            .setOwnerData(primaryOwner);
                        context
                            .read<DirectoryCubit>()
                            .setResidentData(resident);
                      } else {
                        context.read<DirectoryCubit>().resetOwnerAndResident();
                      }
                    },
                  ),
                  selectedUnit == null
                      ? Expanded(
                          child: EmptyWidget(
                              text: AppUtils.languageTranslate(
                                  'selectUnitToViewDetails')))
                      : SizedBox.shrink(),
                  if (state.primaryOwner != null) ...[
                    const Gap(20),
                    HeadingWidget(
                        heading:
                            AppUtils.languageTranslate('ownerInformation')),
                    const Gap(10),
                    PhoneEmailInformationCardWidget(
                      name: state.primaryOwner?.fullName ?? "--",
                      phone: (state.primaryOwner?.primaryPhone?.isNotEmpty ??
                              false)
                          ? state.primaryOwner?.primaryPhone ?? "--"
                          : '--',
                      email: state.primaryOwner?.primaryEmail ?? "--",
                    ),
                  ],
                  if (state.resident != null) ...[
                    const Gap(20),
                    HeadingWidget(
                        heading:
                            AppUtils.languageTranslate('residentInformation')),
                    const Gap(10),
                    PhoneEmailInformationCardWidget(
                      name: state.resident?.fullName ?? "--",
                      phone: state.resident?.primaryPhone ?? "--",
                      email: state.resident?.primaryEmail ?? "--",
                    ),
                  ]
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
