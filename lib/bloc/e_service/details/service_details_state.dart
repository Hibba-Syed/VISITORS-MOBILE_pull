part of 'service_details_cubit.dart';

class ServiceDetailsState {
  final bool isLoading;
  final int page;
  ServiceDetailsModel? serviceDetails;
  ServiceDetailsState({
    this.isLoading = false,
    this.page = 1,
    this.serviceDetails,
  });
  ServiceDetailsState copyWith({
    bool? isLoading,
    bool? isServicesDetailsLoading,
    int? page,
    ServiceDetailsModel? serviceDetails,


  }) {
    return ServiceDetailsState(
        isLoading: isLoading ?? this.isLoading,
        page: page ?? this.page,
      serviceDetails: serviceDetails ?? this.serviceDetails,

    );
  }
}