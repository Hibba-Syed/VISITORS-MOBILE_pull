import '../../model/unit/units_response_model.dart';

abstract class UnitsRepo {
  Future<UnitsResponseModel?> getUnits();
}