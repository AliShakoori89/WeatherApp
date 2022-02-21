import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/cities_weather_bloc/bloc.dart';
import 'package:weather/bloc/fetch_all_cities/bloc.dart';
import 'package:weather/bloc/search_city_bloc/bloc.dart';
import 'package:weather/bloc/search_location_bloc/bloc.dart';
import 'package:weather/bloc/weather_bloc/bloc.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:weather/view/home_page.dart';
import 'bloc/daily_hourly_weather_bloc/bloc.dart';


void main() => runApp(
    MyApp());

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
                  CitiesWeatherBloc(WeatherRepository())),
          BlocProvider(
              create: (BuildContext context) =>
                  FetchCitiesDataBloc(WeatherRepository())),
          BlocProvider(
              create: (BuildContext context) =>
                  SearchCityBloc(WeatherRepository())),
        ],
        child: MaterialApp(
            debugShowCheckedModeBanner: false,
            home: HomePage())
    );
  }
}


