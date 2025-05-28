part of 'service_details_cubit.dart';

class ServiceDetailsState {
  final bool isLoading;
  final bool isAddLogLoading;
  final bool isCompleteServiceLoading;
  ServiceDetailsModel? serviceDetails;
  ServiceDetailsState({
    this.isLoading = false,
    this.serviceDetails,
    this.isAddLogLoading = false,
    this.isCompleteServiceLoading = false,
  });
  ServiceDetailsState copyWith({
    bool? isLoading,
    bool? isAddLogLoading,
    bool? isCompleteServiceLoading,
    ServiceDetailsModel? serviceDetails,
  }) {
    return ServiceDetailsState(
        isLoading: isLoading ?? this.isLoading,
        serviceDetails: serviceDetails ?? this.serviceDetails,
        isAddLogLoading: isAddLogLoading ?? this.isAddLogLoading,
        isCompleteServiceLoading:
            isCompleteServiceLoading ?? this.isCompleteServiceLoading);
  }
}
