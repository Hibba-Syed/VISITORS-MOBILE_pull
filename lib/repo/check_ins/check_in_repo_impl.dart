
import 'package:visitors/model/check_ins/check_ins_response_model.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/check_ins/check_in_log_model.dart';
import '../../model/check_ins/check_out_all_model.dart';
import '../../resource/constants/api_url.dart';
import 'check_in_repo.dart';

class CheckInRepoImpl implements CheckInRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<CheckInsResponseModel?> getCheckIns({
    int? page,
    int? limit,
    String? keyword,
    List<int>? unitId,
    String? dateRange,
    String? serviceableType,
    List<int>? vendorId,
  }) async {
    try {
      String url =
          '${ApiUrl.checkIns}?page=${page ?? 1}&limit=${limit ?? 10}&keyword=${keyword ?? ''}&vendor_id=${vendorId ?? ''}&serviceable_type=${serviceableType ?? ''}&date_range=${dateRange ?? ''}&unit_id=${unitId ?? ''}';
      print('url^^ $url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return CheckInsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }

  }

  @override
  Future<CheckInLogModel?> getCheckInLogs({required int? id}) async {
    try {
      String url = '${ApiUrl.checkInLogs}/$id';
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return CheckInLogModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<CheckOutAllModel?> checkOutAll() async {
    try {
      dynamic response = await _apiService
          .getAuthPutApiResponse(ApiUrl.checkOutAll);
      return CheckOutAllModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
