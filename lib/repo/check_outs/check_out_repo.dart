import '../../model/check_out/check_out_response_model.dart';

abstract class CheckOutRepo{
Future<CheckOutResponseModel?> getCheckOuts({
  int? page,
  int? limit,
  String? keyword,
  int? unitId,
  String? dateRange,
  String? serviceableType,
  int? vendorId,
});
}