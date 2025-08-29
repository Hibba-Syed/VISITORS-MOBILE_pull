import '../../model/check_outs/check_out_visitor_response_model.dart';
import '../../model/visitor_info/delete_visitor_response_model.dart';

abstract class VisitorRepo {
  Future<CheckOutVisitorResponseModel?> checkOutVisitors({
    required int? id,
    required Map<String, dynamic> data,
  });
  Future<DeleteVisitorResponseModel?> deleteVisitor({required int? id});
}
