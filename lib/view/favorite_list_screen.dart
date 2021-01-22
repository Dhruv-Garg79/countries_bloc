import 'package:countries_bloc/bloc/favorite_bloc.dart';
import 'package:countries_bloc/models/CountryModal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavoriteListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorite Countries"),
      ),
      body: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state.countries.length == 0)
            return Center(
              child: Text("No Favorite Countries"),
            );

          return ListView.builder(
            itemBuilder: (context, index) {
              return buildItem(state.countries[index]);
            },
            itemCount: state.countries.length,
          );
        },
      ),
    );
  }

  Widget buildItem(CountryModal country) {
    return Padding(
      padding: const EdgeInsets.all(16),
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
    );
  }
}
