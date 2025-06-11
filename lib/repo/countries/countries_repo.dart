

import '../../model/country/countries_response_model.dart';

abstract class CountriesRepo {
  Future<CountriesResponseModel?> getCountries();
}


