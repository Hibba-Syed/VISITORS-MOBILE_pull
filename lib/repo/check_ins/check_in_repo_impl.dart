
import 'package:visitors/model/check_ins/check_ins_response_model.dart';

import '../../data/network/base_api_services.dart';
import '../../data/network/network_api_services.dart';
import '../../model/check_ins/check_in_log_response_model.dart';
import '../../model/check_ins/guest_checkin_response_model.dart';
import '../../model/check_out/check_out_all_model.dart';
import 'package:visitors/model/check_outs/check_out_visitor_response_model.dart';
import '../../model/visitor_info/delete_visitor_response_model.dart';
import '../../model/visitor_info/visitor_phone_info_response_model.dart';
import '../../resource/constants/api_url.dart';
import 'check_in_repo.dart';

class CheckInRepoImpl implements CheckInRepo {
  final BaseApiServices _apiService = NetworkApiServices();

  @override
  Future<CheckInsResponseModel?> getCheckIns({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
    String? dateRange,
    String? serviceableType,
    int? vendorId,
    int? serviceableId,
  }) async {
    try {
      String url =
          '${ApiUrl.checkIns}?page=${page ?? 1}&limit=${limit ?? 10}&keyword=${keyword ?? ''}&vendor_id=${vendorId ?? ''}&serviceable_type=${serviceableType ?? ''}&date_range=${dateRange ?? ''}&unit_id=${unitId ?? ''}&serviceable_id=${serviceableId ?? ''}';
      // print('checkIns$url');
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      // print('checkIns$response');
      return CheckInsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }

  }

  @override
  Future<CheckInLogResponseModel?> getCheckInDetailsLogs({required int? id}) async {
    try {
      String url = '${ApiUrl.checkInLogs}/$id';
      dynamic response = await _apiService.getAuthGetApiResponse(url);
      return CheckInLogResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }



  @override
  Future<VisitorPhoneInfoResponseModel?> getNumberInfo({required String? phoneNumber}) async {
    try {
      String url = '${ApiUrl.visitorQuickInfo}/$phoneNumber';
      dynamic response =await _apiService.getAuthGetApiResponse(url);
      return VisitorPhoneInfoResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }



  @override
  Future<GuestCheckInResponseModel?> guestCheckIn({
    required Map<String, dynamic> data,
  }) async {
    try {
      String url = ApiUrl.guestCheckIn;
      print('guestCheckIn$url');
      dynamic response =
      await _apiService.getAuthPostApiResponse(url, data);
      return GuestCheckInResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
