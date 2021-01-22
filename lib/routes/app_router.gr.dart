// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../view/country_list_screen.dart';
import '../view/favorite_list_screen.dart';

class Routes {
  static const String countryListScreen = '/country-list-screen';
  static const String favoriteListScreen = '/favorite-list-screen';
  static const all = <String>{
    countryListScreen,
    favoriteListScreen,
  };
}

class AppRouter extends RouterBase {
  @override
  List<RouteDef> get routes => _routes;
  final _routes = <RouteDef>[
    RouteDef(Routes.countryListScreen, page: CountryListScreen),
    RouteDef(Routes.favoriteListScreen, page: FavoriteListScreen),
  ];
  @override
  Map<Type, AutoRouteFactory> get pagesMap => _pagesMap;
  final _pagesMap = <Type, AutoRouteFactory>{
    CountryListScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => CountryListScreen(),
        settings: data,
      );
    },
    FavoriteListScreen: (data) {
      return MaterialPageRoute<dynamic>(
        builder: (context) => FavoriteListScreen(),
        settings: data,
      );
    },
  };
}
