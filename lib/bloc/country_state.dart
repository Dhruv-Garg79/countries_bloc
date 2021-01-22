part of 'country_bloc.dart';

enum CountryStatus { initial, success, failure }

class CountryState extends Equatable {
  const CountryState({
    this.status = CountryStatus.initial,
    this.countries = const <CountryModal>[],
    this.hasReachedMax = false,
    this.errorMessage,
  });

  final CountryStatus status;
  final List<CountryModal> countries;
  final bool hasReachedMax;
  final String errorMessage;

  CountryState copyWith({
    CountryStatus status,
    List<CountryModal> countries,
    bool hasReachedMax,
    String errorMessage,
  }) {
    return CountryState(
      status: status ?? this.status,
      countries: countries ?? this.countries,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, countries, hasReachedMax, errorMessage];
}
