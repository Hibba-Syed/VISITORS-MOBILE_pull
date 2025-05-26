import '../../model/unit/units_response_model.dart';
import '../../model/vendor/vendor_response_model.dart';

abstract class GeneralFilterRepo{
Future<UnitsResponseModel?> getUnits();
Future<VendorsResponseModel?> getVendors();
}