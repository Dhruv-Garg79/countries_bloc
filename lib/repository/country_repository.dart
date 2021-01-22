import 'package:countries_bloc/models/CountryResponse.dart';
import 'package:countries_bloc/resource/country_api_provider.dart';

class CountryRepository {
  final _provider = CountryApiProvider();

  Future<CountryResponse> fetchCountries(int offset) =>
      _provider.fetchCountries(offset);
}
