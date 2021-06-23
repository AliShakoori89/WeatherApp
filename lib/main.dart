import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/cities_summery_container_bloc.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:weather/view/search_screen.dart';

Void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown
    ]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      home: MultiBlocProvider(
          providers: [
            BlocProvider(
                create: (BuildContext context) =>
                    WeatherBloc(WeatherRepository())),
            BlocProvider(
                create: (BuildContext context) =>
                    WeatherDetailsBloc(WeatherRepository())),
            BlocProvider(
                create: (BuildContext context) =>
                    CitiesWeathersSummeryBloc(WeatherRepository())),
          ],
          child: SearchScreen(),
      )
    );
  }
}


