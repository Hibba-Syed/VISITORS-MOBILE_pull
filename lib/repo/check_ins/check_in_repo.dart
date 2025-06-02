
import 'package:visitors/model/check_ins/check_ins_response_model.dart';

import '../../model/check_ins/check_in_log_response_model.dart';
import '../../model/check_out/check_out_all_model.dart';
import 'package:visitors/model/check_outs/check_out_visitor_response_model.dart';

abstract class CheckInRepo {
  Future<CheckInsResponseModel?> getCheckIns({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? dateRange,
    String? serviceableType,
    int? vendorId,
    int? serviceableId

  });
  Future<CheckInLogResponseModel?> getCheckInDetailsLogs({required int? id});
  Future<CheckOutAll?> checkOutAll();
  Future<CheckOutVisitorResponseModel?> checkOutVisitors({
    required int? id,
    required Map<String, dynamic> data,
  });
}