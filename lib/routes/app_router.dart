import 'package:auto_route/auto_route_annotations.dart';
import 'package:countries_bloc/view/country_list_screen.dart';
import 'package:countries_bloc/view/favorite_list_screen.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    MaterialRoute(page: CountryListScreen),
    MaterialRoute(page: FavoriteListScreen),
  ],
)
class $AppRouter {}
