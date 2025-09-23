import '../../model/service/move_out_service_clear_payment_response_model.dart';
import 'package:http/http.dart' as http;


abstract class PaymentRepo{
  Future<MoveOutServiceClearPaymentResponseModel?> clearPayment({
    required int? id,
    required Map<String, dynamic> data,
    required List<http.MultipartFile> files,
  });
}