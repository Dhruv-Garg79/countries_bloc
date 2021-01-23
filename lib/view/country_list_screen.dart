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

class _CountryListScreenState extends State<CountryListScreen>
    with TickerProviderStateMixin {
  final _scrollController = ScrollController();
  final _scrollThreshold = 400.0;

  AnimationController _animationController;
  Animation<double> _animation;
  CountryBloc _countryBloc;
  bool _showFBA = true;

  @override
  void initState() {
    super.initState();
    _countryBloc = BlocProvider.of<CountryBloc>(context);
    _countryBloc.add(FetchCountry());

    _scrollController.addListener(_onScroll);
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween(begin: 1.0, end: 0.0).animate(_animationController);
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
      floatingActionButton: ScaleTransition(
        scale: _animation,
        child: FloatingActionButton(
          child: Icon(
            Icons.favorite_border_outlined,
            color: Colors.pinkAccent,
          ),
          onPressed: () {
            ExtendedNavigator.root.push(Routes.favoriteListScreen);
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // to hide FBA when user scrolling down
    final scrollDir = _scrollController.position.userScrollDirection;
    if (!_animationController.isAnimating) {
      if (scrollDir == ScrollDirection.reverse && _showFBA) {
        _showFBA = false;
        _animationController.forward(from: 0);
      } else if (scrollDir == ScrollDirection.forward && !_showFBA) {
        _showFBA = true;
        _animationController.reverse(from: 1);
      }
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
