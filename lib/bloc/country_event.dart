part of 'country_bloc.dart';

abstract class CountryEvent extends Equatable {
  const CountryEvent();

  @override
  List<Object> get props => [];
}

class FetchCountry extends CountryEvent {}

class FavoriteCountryEvent extends CountryEvent{
  final String countryCode;

  const FavoriteCountryEvent(this.countryCode);

  @override
  List<Object> get props => [countryCode];
}

class UnfavoriteCountryEvent extends CountryEvent{
  final String countryCode;

  const UnfavoriteCountryEvent(this.countryCode);

  @override
  List<Object> get props => [countryCode];
}
