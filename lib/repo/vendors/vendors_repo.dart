import '../../model/vendor/vendor_response_model.dart';

abstract class VendorsRepo{

Future<VendorsResponseModel?> getVendors();
}