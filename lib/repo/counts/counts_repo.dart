import '../../model/count/count_response_model.dart';

abstract class CountsRepo {

  Future<CountResponseModel?> getDashboardCount();
}