import 'dart:convert';

class CountryModal {
  String countryCode;
  final String country;
  final String region;
  bool isFavorite = false;

  CountryModal({
    this.countryCode,
    this.country,
    this.region,
    this.isFavorite,
  });

  CountryModal copyWith({
    String countryCode,
    String country,
    String region,
    bool isFavorite,
  }) {
    return CountryModal(
      countryCode: countryCode ?? this.countryCode,
      country: country ?? this.country,
      region: region ?? this.region,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'countryCode': countryCode,
      'country': country,
      'region': region,
      'isFavorite': isFavorite,
    };
  }

  factory CountryModal.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CountryModal(
      country: map['country'],
      region: map['region'],
      isFavorite: false,
    );
  }

  String toJson() => json.encode(toMap());

  factory CountryModal.fromJson(String source) => CountryModal.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountryModal(countryCode: $countryCode, country: $country, region: $region, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CountryModal &&
      o.countryCode == countryCode &&
      o.country == country &&
      o.region == region &&
      o.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return countryCode.hashCode ^
      country.hashCode ^
      region.hashCode ^
      isFavorite.hashCode;
  }
}
