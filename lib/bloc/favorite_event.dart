part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class AddFavoriteEvent extends FavoriteEvent {
  final CountryModal country;

  const AddFavoriteEvent(this.country);

  @override
  List<Object> get props => [country];
}

class RemoveFavoriteEvent extends FavoriteEvent {
  final String countryCode;

  const RemoveFavoriteEvent(this.countryCode);

  @override
  List<Object> get props => [countryCode];
}
