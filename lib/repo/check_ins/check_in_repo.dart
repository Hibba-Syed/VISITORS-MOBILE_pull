
import 'package:visitors/model/check_ins/check_ins_response_model.dart';

import '../../model/check_ins/check_in_log_model.dart';
import '../../model/check_out/check_out_all_model.dart';

abstract class CheckInRepo {

  Future<CheckInsResponseModel?> getCheckIns({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? dateRange,
    String? serviceableType,
    int? vendorId,

  });
  Future<CheckInLogModel?> getCheckInLogs({required int? id});
  Future<CheckOutAllModel?> checkOutAll();
}