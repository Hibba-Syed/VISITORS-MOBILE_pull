part of 'guest_check_in_cubit.dart';

class GuestCheckInState {
  final bool isLoading;
  final bool isCountriesLoading;
  final bool isUnitLoading;
  final bool isProfileLoading;
  final bool isNumberInfoLoading;
  final bool isDeleteVisitorLoading;
  final List<Country>? countries;
  final Country? selectedCountry;
  final VisitorsPurpose? selectedPurpose;
  final ProfileRecord? profileRecord;
  final List<UnitModel>? units;
  final List<NumberInfo>? numberInfo;
  final UnitModel? selectedUnit;

  GuestCheckInState({
    this.isLoading = false,
    this.isCountriesLoading = false,
    this.isUnitLoading = false,
    this.isProfileLoading = false,
    this.isNumberInfoLoading = false,
    this.isDeleteVisitorLoading = false,
    this.countries,
    this.selectedCountry,
    this.selectedPurpose,
    this.profileRecord,
    this.units,
    this.selectedUnit,
    this.numberInfo,
  });
  GuestCheckInState copyWith({
    bool? isLoading,
    bool? isCountriesLoading,
    bool? isUnitLoading,
    bool? isProfileLoading,
    bool? isNumberInfoLoading,
    bool? isDeleteVisitorLoading,
    List<Country>? countries,
    Country? selectedCountry,
    VisitorsPurpose? selectedPurpose,
    ProfileRecord? profileRecord,
    List<UnitModel>? units,
    UnitModel? selectedUnit,
    List<NumberInfo>? numberInfo,
  }) {
    return GuestCheckInState(
      isLoading: isLoading ?? this.isLoading,
      countries: countries ?? this.countries,
      selectedCountry: selectedCountry ?? this.selectedCountry,
      selectedPurpose: selectedPurpose ?? this.selectedPurpose,
      profileRecord: profileRecord ?? this.profileRecord,
      isCountriesLoading: isCountriesLoading ?? this.isCountriesLoading,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      units: units ?? this.units,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isNumberInfoLoading: isNumberInfoLoading ?? this.isNumberInfoLoading,
      numberInfo: numberInfo ?? this.numberInfo,
        isDeleteVisitorLoading: isDeleteVisitorLoading ?? this.isDeleteVisitorLoading
    );
  }
}
