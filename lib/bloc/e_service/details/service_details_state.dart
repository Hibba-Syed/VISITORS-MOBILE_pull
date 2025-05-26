part of 'service_details_cubit.dart';

class ServiceDetailsState {
  final bool isLoading;
  ServiceDetailsModel? serviceDetails;
  ServiceDetailsState({
    this.isLoading = false,
    this.serviceDetails,
  });
  ServiceDetailsState copyWith({
    bool? isLoading,
    ServiceDetailsModel? serviceDetails,

  }) {
    return ServiceDetailsState(
      isLoading: isLoading ?? this.isLoading,
      serviceDetails: serviceDetails ?? this.serviceDetails,
    );
  }
}
