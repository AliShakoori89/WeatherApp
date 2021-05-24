import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/hourly_weather_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/bloc/week_weather_bloc.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:weather/view/daily_weak_weathers.dart';
import 'package:weather/view/today_weather.dart';
import 'dart:ui' as ui;

import 'package:weather/view/hourly_week_weathers.dart';


class CityWeatherDetails extends StatefulWidget {

  final String cityName;
  CityWeatherDetails(this.cityName);

  @override
  _CityWeatherDetailsState createState() => _CityWeatherDetailsState(cityName);
}

class _CityWeatherDetailsState extends State<CityWeatherDetails> {

  final String cityName;
  _CityWeatherDetailsState(this.cityName);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: MultiBlocProvider(
        providers: [
        BlocProvider (
          create: (BuildContext context) => WeatherBloc (WeatherRepository())),
        BlocProvider(
          create: (BuildContext context) => DailyWeatherBloc(WeatherRepository())),
        BlocProvider(
          create: (BuildContext context) => HourlyWeatherBloc(WeatherRepository())),
        ],
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/4,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage('assets/images/weather_types.jpg'),
                        fit: BoxFit.fitWidth,
                        alignment: Alignment.topCenter,
                        colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                      )
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height/20,
                    left: MediaQuery.of(context).size.height/50,
                    right: MediaQuery.of(context).size.height/50,
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[900],
                        borderRadius: BorderRadius.circular(25)
                    ),
                    width: MediaQuery.of(context).size.height,
                    height: MediaQuery.of(context).size.height/2.37,
                    child: Directionality(
                        textDirection: ui.TextDirection.ltr,
                        child: TodayWeather(cityName),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height/40,
                    left: MediaQuery.of(context).size.height/50,
                    right: MediaQuery.of(context).size.height/50,
                    // bottom: MediaQuery.of(context).size.height/20,
                  ),
                    child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[900],
                              borderRadius: BorderRadius.circular(25)),
                          width: MediaQuery.of(context).size.height,
                          height: MediaQuery.of(context).size.height/5,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 50,
                                  left: MediaQuery.of(context).size.height / 50,
                                ),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      'HOURLY',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 13.0),
                                    )),
                              ),
                              Expanded(child: HourlyWeekWeathers(cityName))
                            ],
                          )
                    )
                ),
                Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height/40,
                      left: MediaQuery.of(context).size.height/50,
                      right: MediaQuery.of(context).size.height/50,
                      // bottom: MediaQuery.of(context).size.height/20,
                    ),
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[900],
                            borderRadius: BorderRadius.circular(25)),
                        width: MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).size.height / 3.5,
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 50,
                                left: MediaQuery.of(context).size.height / 50,
                              ),
                              child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    'DAILY',
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 13.0),
                                  )),
                            ),
                            Expanded(child: DailyWeekWeathers(cityName))
                          ],
                        )
                    )
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}
