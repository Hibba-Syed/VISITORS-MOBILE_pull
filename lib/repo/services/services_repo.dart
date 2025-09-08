
import '../../model/service/add_service_log_response_model.dart';
import '../../model/service/service_details_response_model.dart';
import '../../model/service/service_response_model.dart';
import '../../model/service/visitors_service_complete_response_model.dart';

abstract class ServiceRepo {
  Future<ServiceResponseModel?> getServices({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? type,
  });
  Future<ServiceDetailsResponseModel?> getServiceDetails({int? serviceId});
  Future<AddServiceLogResponseModel?> addServiceLog({
    required Map<String, dynamic> data,
  });
  Future<VisitorsServiceCompleteResponseModel?> completeService({
    required Map<String, dynamic> data,
  });
  Future<VisitorsServiceCompleteResponseModel?> completeAccessDeviceService(
      {required Map<String, dynamic> data, required int? serviceId});

}
