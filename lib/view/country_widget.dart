import 'package:countries_bloc/bloc/favorite_bloc.dart';
import 'package:countries_bloc/models/CountryModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryWidget extends StatefulWidget {
  final CountryModal country;

  const CountryWidget({Key key, this.country}) : super(key: key);
  @override
  _CountryWidgetState createState() => _CountryWidgetState();
}

class _CountryWidgetState extends State<CountryWidget> {
  bool _isFavorite = false;

  @override
  Widget build(BuildContext context) {
    final country = widget.country;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  country.country,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  '${country.region} • ${country.countryCode}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 16),
          IconButton(
            icon: Icon(
              Icons.favorite,
              color: _isFavorite ? Colors.red : Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isFavorite = !_isFavorite;
              });
              if (_isFavorite) {
                BlocProvider.of<FavoriteBloc>(context, listen: false)
                    .add(AddFavoriteEvent(country));
              } else {
                BlocProvider.of<FavoriteBloc>(context, listen: false)
                    .add(RemoveFavoriteEvent(country.countryCode));
              }
            },
          ),
        ],
      ),
    );
  }
}
