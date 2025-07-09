part of 'guest_check_in_cubit.dart';

class GuestCheckInState {
  final bool isLoading;
  final bool isCountriesLoading;
  final bool isGuestCheckInLoading;
  final bool isUnitLoading;
  final bool isProfileLoading;
  final bool isNumberInfoLoading;
  final bool isDeleteVisitorLoading;
  final List<Country>? countries;
  final Country? selectedNationality;
  final VisitorsPurpose? selectedPurpose;
  final ProfileRecord? profileRecord;
  final List<UnitModel>? units;
  final List<NumberInfo>? numberInfo;
  final UnitModel? selectedUnit;
  final CheckInModel? checkInModel;

  GuestCheckInState({
    this.isLoading = false,
    this.isCountriesLoading = false,
    this.isUnitLoading = false,
    this.isProfileLoading = false,
    this.isNumberInfoLoading = false,
    this.isDeleteVisitorLoading = false,
    this.isGuestCheckInLoading = false,
    this.countries,
    this.selectedNationality,
    this.selectedPurpose,
    this.profileRecord,
    this.units,
    this.selectedUnit,
    this.numberInfo,
    this.checkInModel,
  });
  GuestCheckInState copyWith({
    bool? isLoading,
    bool? isCountriesLoading,
    bool? isUnitLoading,
    bool? isProfileLoading,
    bool? isNumberInfoLoading,
    bool? isDeleteVisitorLoading,
    bool? isGuestCheckInLoading,
    List<Country>? countries,
    Country? selectedNationality,
    VisitorsPurpose? selectedPurpose,
    ProfileRecord? profileRecord,
    List<UnitModel>? units,
    UnitModel? selectedUnit,
    List<NumberInfo>? numberInfo,
    CheckInModel? checkInModel,
  }) {
    return GuestCheckInState(
      isLoading: isLoading ?? this.isLoading,
      countries: countries ?? this.countries,
      selectedNationality: selectedNationality ?? this.selectedNationality,
      selectedPurpose: selectedPurpose ?? this.selectedPurpose,
      profileRecord: profileRecord ?? this.profileRecord,
      isCountriesLoading: isCountriesLoading ?? this.isCountriesLoading,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      units: units ?? this.units,
      selectedUnit: selectedUnit ?? this.selectedUnit,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isNumberInfoLoading: isNumberInfoLoading ?? this.isNumberInfoLoading,
      numberInfo: numberInfo ?? this.numberInfo,
      isDeleteVisitorLoading:
          isDeleteVisitorLoading ?? this.isDeleteVisitorLoading,
      isGuestCheckInLoading:
          isGuestCheckInLoading ?? this.isGuestCheckInLoading,
      checkInModel: checkInModel ?? this.checkInModel,
    );
  }
}
