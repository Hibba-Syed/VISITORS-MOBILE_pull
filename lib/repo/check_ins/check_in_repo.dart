
import 'package:visitors/model/check_ins/visitors_check_ins_model.dart';

abstract class CheckInRepo {

  Future<VisitorCheckInsModel?> getCheckIns({
    int? page,
    int? limit,
  });
}