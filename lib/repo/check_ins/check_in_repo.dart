
import 'package:visitors/model/check_ins/check_ins_response_model.dart';

import '../../model/check_ins/check_in_log_response_model.dart';
import '../../model/check_ins/guest_checkin_response_model.dart';
import '../../model/visitor_info/visitor_phone_info_response_model.dart';

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



  Future<VisitorPhoneInfoResponseModel?> getNumberInfo({required String? phoneNumber});

  Future<GuestCheckInResponseModel?> guestCheckIn(
  {required Map<String, dynamic> data}
      );
}