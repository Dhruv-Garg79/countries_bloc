import 'package:countries_bloc/models/CountryModal.dart';
import 'package:countries_bloc/models/CountryResponse.dart';
import 'package:countries_bloc/utils/api_client.dart';
import 'package:countries_bloc/utils/app_logger.dart';
import 'package:countries_bloc/utils/global.dart';

class CountryApiProvider {
  Future<CountryResponse> fetchCountries(int offset) async {
    try {
      final path = "${Global.baseurl}/countries";
      final response = await ApiClient.getInstance().get(
        path,
        queryParameters: {
          "offset": offset,
        },
      );

      if (response.statusCode == 200) {
        final List<CountryModal> list = [];
        (response.data['data'] as Map<String, dynamic>).entries.forEach((element) {
          final country = CountryModal.fromMap(element.value);
          country.countryCode = element.key;
          list.add(country);
        });

        return CountryResponse(list, "");
      } else {
        return CountryResponse.withError(response.data['message']);
      }
    } on Exception catch (e) {
      AppLogger.print(e.toString());
      return CountryResponse.withError(e.toString());
    }
  }
}
