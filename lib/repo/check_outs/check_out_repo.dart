import '../../model/check_out/check_out_response_model.dart';

abstract class CheckOutRepo{
Future<CheckOutResponseModel?> getCheckOuts({
  int? page,
  int? limit,
  String? keyword,
  List<int>? unitId,
  String? dateRange,
  String? serviceableType,
  List<int>? vendorId,
});
}