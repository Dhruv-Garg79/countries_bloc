part of 'favorite_bloc.dart';

enum FavoriteStatus { initial, loaded }

class FavoriteState extends Equatable {
  const FavoriteState({
    this.countries = const <CountryModal>[],
    this.status = FavoriteStatus.initial,
  });

  final List<CountryModal> countries;
  final FavoriteStatus status;

  FavoriteState copyWith({
    List<CountryModal> countries,
    FavoriteStatus status,
  }) {
    return FavoriteState(
      countries: countries ?? this.countries,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [countries, status];
}
