import 'package:auto_route/auto_route.dart';
import 'package:countries_bloc/app_theme.dart';
import 'package:countries_bloc/bloc/country_bloc.dart';
import 'package:countries_bloc/bloc/favorite_bloc.dart';
import 'package:countries_bloc/utils/global.dart';
import 'package:countries_bloc/view/country_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:countries_bloc/routes/app_router.gr.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CountryBloc(),
        ),
        BlocProvider(
          create: (context) => FavoriteBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: Global.appName,
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: AppTheme.primaryColor,
          accentColor: AppTheme.accentColor,
          fontFamily: 'Montserrat',
          canvasColor: Colors.black,
        ),
        builder: ExtendedNavigator.builder<AppRouter>(
          router: AppRouter(),
          initialRoute: Routes.countryListScreen,
        ),
        home: CountryListScreen(),
      ),
    );
  }
}
