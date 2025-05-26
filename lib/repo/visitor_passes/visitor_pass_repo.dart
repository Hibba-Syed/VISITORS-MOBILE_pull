import '../../model/visitor_passes/visitor_pass_response_model.dart';

abstract class VisitorPassRepo{
  Future<VisitorPassResponseModel?> getVisitorPass({
    int? page,
    int? limit,
    String? keyword,
    int? unitId,
  });
}