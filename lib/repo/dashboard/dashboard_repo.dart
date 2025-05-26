import '../../model/count/count_response_model.dart';

abstract class DashboardRepo {

  Future<CountResponseModel?> getDashboardCount();
}