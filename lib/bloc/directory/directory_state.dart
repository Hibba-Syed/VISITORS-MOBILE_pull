part of 'directory_cubit.dart';

class DirectoryState {
  final bool isLoading;
  final List<UnitModel>? units;
  final UnitModel? selectedUnit;
  // final UnitModel? unitModel;
  final PrimaryOwner? primaryOwner;
  final Resident? resident;

  DirectoryState({
    this.isLoading = false,
    this.units,
    this.selectedUnit,
    // this.unitModel,
    this.primaryOwner,
    this.resident,
  });
  DirectoryState copyWith({
    bool? isLoading,
    List<UnitModel>? units,
    UnitModel? selectedUnit,
    // UnitModel? unitModel,
    PrimaryOwner? primaryOwner,
    Resident? resident,
  }) {
    return DirectoryState(
        isLoading: isLoading ?? this.isLoading,
        units: units ?? this.units,
        selectedUnit: selectedUnit ?? this.selectedUnit,
        // unitModel: unitModel ?? this.unitModel,
        primaryOwner: primaryOwner ?? this.primaryOwner,
        resident: resident ?? this.resident,
    );
  }
}
