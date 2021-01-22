import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:countries_bloc/models/CountryModal.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteState());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is AddFavoriteEvent) {
      yield state.copyWith(
        countries: state.status == FavoriteStatus.initial
            ? [event.country]
            : (state.countries
          ..add(event.country)),
        status: FavoriteStatus.loaded,
      );
    }
    if (event is RemoveFavoriteEvent) {
      yield state.copyWith(
        countries: state.countries
          ..removeWhere((element) => element.countryCode == event.countryCode),
        status: FavoriteStatus.loaded,
      );
    }
  }
}
