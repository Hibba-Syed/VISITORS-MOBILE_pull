
import 'package:visitors/model/check_ins/check_ins_response_model.dart';

abstract class CheckInRepo {

  Future<CheckInsResponseModel?> getCheckIns({
    int? page,
    int? limit,
  });
}