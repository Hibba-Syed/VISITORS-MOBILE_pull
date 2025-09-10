import '../../model/check_out/check_in_log_response_model.dart';
import '../../model/check_out/check_out_all_model.dart';
import '../../model/check_out/check_out_response_model.dart';

abstract class CheckOutRepo {
  Future<CheckOutResponseModel?> getCheckOuts({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? dateRange,
    String? serviceableType,
    int? vendorId,
  });
  Future<CheckOutAll?> checkOutAll();
  Future<CheckOutLogResponseModel?> getCheckOutDetailsLogs({required int? id});
}
