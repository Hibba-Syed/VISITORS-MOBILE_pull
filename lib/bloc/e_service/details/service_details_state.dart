part of 'service_details_cubit.dart';

class ServiceDetailsState {
  final bool isLoading;
  final bool isAddLogLoading;
  final bool isCompleteServiceLoading;
  final bool isClearPaymentLoading;
  ServiceDetailsModel? serviceDetails;
  ServiceDetailsState({
    this.isLoading = false,
    this.serviceDetails,
    this.isAddLogLoading = false,
    this.isCompleteServiceLoading = false,
    this.isClearPaymentLoading = false,
  });
  ServiceDetailsState copyWith({
    bool? isLoading,
    bool? isAddLogLoading,
    bool? isCompleteServiceLoading,
    bool? isClearPaymentLoading,
    ServiceDetailsModel? serviceDetails,
  }) {
    return ServiceDetailsState(
        isLoading: isLoading ?? this.isLoading,
        serviceDetails: serviceDetails ?? this.serviceDetails,
        isAddLogLoading: isAddLogLoading ?? this.isAddLogLoading,
        isCompleteServiceLoading:
            isCompleteServiceLoading ?? this.isCompleteServiceLoading,
        isClearPaymentLoading: isClearPaymentLoading ?? this.isClearPaymentLoading
    );
  }
}
