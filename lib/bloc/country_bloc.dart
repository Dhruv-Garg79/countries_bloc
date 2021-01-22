import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:countries_bloc/models/CountryModal.dart';
import 'package:countries_bloc/repository/country_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_event.dart';
part 'country_state.dart';

class CountryBloc extends Bloc<CountryEvent, CountryState> {
  final _repo = CountryRepository();

  CountryBloc() : super(CountryState());

  int offset = 0;

  @override
  Stream<CountryState> mapEventToState(
    CountryEvent event,
  ) async* {
    if (event is FetchCountry && !state.hasReachedMax) {
      yield state.copyWith(status: CountryStatus.loading);
      final response = await _repo.fetchCountries(offset);

      if (response.error.isEmpty) {
        if (offset == 0)
          yield state.copyWith(
            status: CountryStatus.success,
            hasReachedMax: response.modal.isEmpty,
            countries: response.modal,
          );
        else
          yield state.copyWith(
            status: CountryStatus.success,
            hasReachedMax: response.modal.isEmpty,
            countries: state.countries..addAll(response.modal),
          );
        offset++;
      } else {
        offset = 0;
        yield state.copyWith(
          status: CountryStatus.failure,
          errorMessage: response.error,
        );
      }
    }

    if (event is FavoriteCountryEvent) {
      final i = state.countries
          .indexWhere((element) => element.countryCode == event.countryCode);
      state.countries[i].isFavorite = true;

      state.copyWith(countries: state.countries);
    }

    if (event is UnfavoriteCountryEvent) {
      final i = state.countries
          .indexWhere((element) => element.countryCode == event.countryCode);
      state.countries[i].isFavorite = false;

      state.copyWith(countries: state.countries);
    }
  }
}
