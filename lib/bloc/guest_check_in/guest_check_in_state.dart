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
  final TypeItemModel? selectedVisitType;

  const GuestCheckInState({
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
    this.selectedVisitType,
  });

  static const _sentinel = Object();

  GuestCheckInState copyWith({
    bool? isLoading,
    bool? isCountriesLoading,
    bool? isUnitLoading,
    bool? isProfileLoading,
    bool? isNumberInfoLoading,
    bool? isDeleteVisitorLoading,
    bool? isGuestCheckInLoading,
    List<Country>? countries,
    Object? selectedNationality = _sentinel,
    Object? selectedPurpose = _sentinel,
    ProfileRecord? profileRecord,
    List<UnitModel>? units,
    Object? selectedUnit = _sentinel,
    List<NumberInfo>? numberInfo,
    CheckInModel? checkInModel,
    Object? selectedVisitType = _sentinel,
  }) {
    return GuestCheckInState(
      isLoading: isLoading ?? this.isLoading,
      isCountriesLoading: isCountriesLoading ?? this.isCountriesLoading,
      isUnitLoading: isUnitLoading ?? this.isUnitLoading,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isNumberInfoLoading: isNumberInfoLoading ?? this.isNumberInfoLoading,
      isDeleteVisitorLoading:
      isDeleteVisitorLoading ?? this.isDeleteVisitorLoading,
      isGuestCheckInLoading:
      isGuestCheckInLoading ?? this.isGuestCheckInLoading,
      countries: countries ?? this.countries,
      profileRecord: profileRecord ?? this.profileRecord,
      units: units ?? this.units,
      numberInfo: numberInfo ?? this.numberInfo,
      checkInModel: checkInModel ?? this.checkInModel,

      // 👇 sentinel handling
      selectedNationality: identical(selectedNationality, _sentinel)
          ? this.selectedNationality
          : selectedNationality as Country?,

      selectedPurpose: identical(selectedPurpose, _sentinel)
          ? this.selectedPurpose
          : selectedPurpose as VisitorsPurpose?,

      selectedUnit: identical(selectedUnit, _sentinel)
          ? this.selectedUnit
          : selectedUnit as UnitModel?,

      selectedVisitType: identical(selectedVisitType, _sentinel)
          ? this.selectedVisitType
          : selectedVisitType as TypeItemModel?,
    );
  }
}
