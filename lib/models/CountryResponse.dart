import 'package:countries_bloc/models/CountryModal.dart';

class CountryResponse{
  final List<CountryModal> modal;
  final String error;

  CountryResponse(this.modal, this.error);

  CountryResponse.withError(String val) : modal = [], error = val;
}