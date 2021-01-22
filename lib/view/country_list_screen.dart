import 'package:auto_route/auto_route.dart';
import 'package:countries_bloc/bloc/country_bloc.dart';
import 'package:countries_bloc/utils/app_logger.dart';
import 'package:countries_bloc/utils/global.dart';
import 'package:countries_bloc/view/country_widget.dart';
import 'package:countries_bloc/widgets/loader.dart';
import 'package:countries_bloc/widgets/my_error_widget.dart';
import 'package:countries_bloc/widgets/network_widget.dart';
import 'package:flutter/material.dart';
import 'package:countries_bloc/routes/app_router.gr.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CountryListScreen extends StatefulWidget {
  @override
  _CountryListScreenState createState() => _CountryListScreenState();
}

class _CountryListScreenState extends State<CountryListScreen> {
  final _scrollController = ScrollController();
  final _scrollThreshold = 400.0;
  CountryBloc _countryBloc;
  bool _showFBA = true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _countryBloc = BlocProvider.of<CountryBloc>(context);
    _countryBloc.add(FetchCountry());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Global.appName),
      ),
      body: NetworkWidget(
        child: BlocBuilder<CountryBloc, CountryState>(
          builder: (context, state) {
            AppLogger.print(state.countries.length.toString());
            if (state.countries.length == 0) return Loader();
            if (state.status == CountryStatus.failure)
              return MyErrorWidget(
                onRetry: () {
                  _countryBloc.add(FetchCountry());
                },
              );

            return ListView.builder(
              controller: _scrollController,
              itemBuilder: (context, index) {
                return index >= state.countries.length
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Loader(),
                      )
                    : CountryWidget(country: state.countries[index]);
              },
              itemCount: state.status != CountryStatus.loading
                  ? state.countries.length
                  : state.countries.length + 1,
            );
          },
        ),
      ),
      floatingActionButton: _showFBA
          ? FloatingActionButton(
              child: Icon(
                Icons.favorite_border_outlined,
                color: Colors.pinkAccent,
              ),
              onPressed: () {
                ExtendedNavigator.root.push(Routes.favoriteListScreen);
              },
            )
          : null,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // to hide FBA when user scrolling down
    if (_scrollController.position.userScrollDirection ==
            ScrollDirection.reverse &&
        _showFBA) {
      setState(() {
        _showFBA = false;
      });
    } else if (_scrollController.position.userScrollDirection ==
            ScrollDirection.forward &&
        !_showFBA) {
      setState(() {
        _showFBA = true;
      });
    }

    //to fetch more data when user reach end of list
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold &&
        _countryBloc.state.status != CountryStatus.loading) {
      _countryBloc.add(FetchCountry());
    }
  }
}
