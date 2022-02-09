import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/bloc.dart';
import 'package:weather/bloc/fetch_all_cities/bloc.dart';
import 'package:weather/bloc/search_location_bloc/bloc.dart';
import 'package:weather/bloc/weather_bloc/bloc.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:weather/view/home_page.dart';
import 'bloc/daily_hourly_weather_bloc/bloc.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp]);

    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (BuildContext context) =>
                  SearchLocationsBloc(WeatherRepository())),
          BlocProvider(
              create: (BuildContext context) =>
                  WeatherBloc(WeatherRepository())),
          BlocProvider(
              create: (BuildContext context) =>
                  WeatherDetailsBloc(WeatherRepository())),
          BlocProvider(
              create: (BuildContext context) =>
                  CitiesWeathersSummeryBloc(WeatherRepository())),
          BlocProvider(
              create: (BuildContext context) =>
                  FetchCitiesDataBloc(WeatherRepository())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage())
    );
  }
}


