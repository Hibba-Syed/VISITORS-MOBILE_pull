import '../../model/service/service_response_model.dart';

abstract class ServiceRepo{
  Future<ServiceResponseModel?> getServices({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? serviceType,
  });
}