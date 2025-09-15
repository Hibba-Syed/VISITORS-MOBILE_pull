part of 'service_details_cubit.dart';

class ServiceDetailsState {
  final bool isLoading;
  final bool isAddLogLoading;
  final bool isCompleteServiceLoading;
  final bool isClearPaymentLoading;
  ServiceDetailsModel? serviceDetails;
  final String? applicationType;
  ServiceDetailsState({
    this.isLoading = false,
    this.serviceDetails,
    this.isAddLogLoading = false,
    this.isCompleteServiceLoading = false,
    this.isClearPaymentLoading = false,
    this.applicationType,
  });
  ServiceDetailsState copyWith({
    bool? isLoading,
    bool? isAddLogLoading,
    bool? isCompleteServiceLoading,
    bool? isClearPaymentLoading,
    ServiceDetailsModel? serviceDetails,
    String? applicationType,
  }) {
    return ServiceDetailsState(
        isLoading: isLoading ?? this.isLoading,
        serviceDetails: serviceDetails ?? this.serviceDetails,
        isAddLogLoading: isAddLogLoading ?? this.isAddLogLoading,
        isCompleteServiceLoading:
            isCompleteServiceLoading ?? this.isCompleteServiceLoading,
        isClearPaymentLoading:
            isClearPaymentLoading ?? this.isClearPaymentLoading,
        applicationType: applicationType ?? this.applicationType);
  }
}
