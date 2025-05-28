import '../../model/service/add_service_log_response_model.dart';
import '../../model/service/service_details_response_model.dart';
import '../../model/service/service_response_model.dart';
import '../../model/service/vIsitors_service_complete_response_model.dart';

abstract class ServiceRepo{
  Future<ServiceResponseModel?> getServices({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? serviceType,

  });
  Future<ServiceDetailsResponseModel?> getServiceDetails( {int? serviceId});
  Future<AddServiceLogResponseModel?> addServiceLog(
      {required Map<String, dynamic> data,
      });
  Future<VisitorsServiceCompleteResponseModel?> serviceCompleted(
      {required Map<String, dynamic> data,
      });
}