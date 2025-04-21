
import 'package:visitors/model/check_ins/visitors_check_ins_response_model.dart';

abstract class CheckInRepo {

  Future<VisitorCheckInsResponseModel?> getCheckIns({
    int? page,
    int? limit,
  });
}