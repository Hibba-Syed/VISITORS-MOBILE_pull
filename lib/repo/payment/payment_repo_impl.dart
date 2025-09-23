import 'package:visitors/data/network/base_api_services.dart';
import 'package:visitors/data/network/network_api_services.dart';
import 'package:visitors/repo/payment/payment_repo.dart';

import '../../model/service/move_out_service_clear_payment_response_model.dart';
import 'package:http/http.dart' as http;

import '../../resource/constants/api_url.dart';

class PaymentRepoImpl implements PaymentRepo {
  final BaseApiServices _apiService = NetworkApiServices();
  @override
  Future<MoveOutServiceClearPaymentResponseModel?> clearPayment({
    required int? id,
    required Map<String, dynamic> data,
    required List<http.MultipartFile> files,
  }) async {
    try {
      String url = '${ApiUrl.clearPayment}/$id';
      // print('clearPayment^^ $url');
      dynamic response = await _apiService.getAuthPostApiMultipartResponse(
        url,
        data,
        files,
      );
      return MoveOutServiceClearPaymentResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }
}
