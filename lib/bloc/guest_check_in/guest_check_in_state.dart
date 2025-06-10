part of 'guest_check_in_cubit.dart';


class GuestCheckInState {
  final bool isLoading;
  List<Countries>? countries;
  Countries? selectedCountries;
  GuestCheckInState({
    this.isLoading = false,
    this.countries,
    this.selectedCountries,
  });
  GuestCheckInState copyWith({
    bool? isLoading,
    List<Countries>? countries,
    Countries? selectedCountries,
  }) {
    return GuestCheckInState(
      isLoading: isLoading ?? this.isLoading,
      countries: countries ?? this.countries,
        selectedCountries: selectedCountries ?? this.selectedCountries

    );
  }
}