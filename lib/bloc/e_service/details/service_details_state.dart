part of 'service_details_cubit.dart';

class ServiceDetailsState {
  final bool isLoading;
  final bool isDocumentLoading;
  final bool isStatusLoading;
  final int page;
  ServiceDetailsModel? serviceDetails;
  ServiceDetailsState({
    this.isLoading = false,
    this.isDocumentLoading = false,
    this.page = 1,
    this.serviceDetails,
    this.isStatusLoading = false,
  });
  ServiceDetailsState copyWith({
    bool? isLoading,
    bool? isDocumentLoading,
    bool? isServicesDetailsLoading,
    bool? isStatusLoading,
    int? page,
    ServiceDetailsModel? serviceDetails,

  }) {
    return ServiceDetailsState(
      isLoading: isLoading ?? this.isLoading,
      page: page ?? this.page,
      serviceDetails: serviceDetails ?? this.serviceDetails,
      isDocumentLoading: isDocumentLoading ?? this.isDocumentLoading,
        isStatusLoading:isStatusLoading ?? this.isStatusLoading
    );
  }
}
