part of 'service_details_cubit.dart';

class ServiceDetailsState {
  final bool isLoading;
  final bool isAddLogLoading;
  ServiceDetailsModel? serviceDetails;
  ServiceDetailsState({
    this.isLoading = false,
    this.serviceDetails,
    this.isAddLogLoading = false,
  });
  ServiceDetailsState copyWith({
    bool? isLoading,
    bool? isAddLogLoading,
    ServiceDetailsModel? serviceDetails,

  }) {
    return ServiceDetailsState(
      isLoading: isLoading ?? this.isLoading,
      serviceDetails: serviceDetails ?? this.serviceDetails,
        isAddLogLoading: isAddLogLoading ?? this.isAddLogLoading,
    );
  }
}
