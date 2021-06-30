import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/view/daily_week_weathers_with_city_location.dart';
import 'package:weather/view/hourly_week_weathers_with_city_location.dart';
import 'package:weather/view/temperature_chart_with_citylocation.dart';
import 'dart:ui' as ui;
import 'package:weather/view/today_weather_with_citylocation.dart';


class CityWeatherDetailsWithCityLocation extends StatefulWidget {

  final double lat;
  final double lon;
  CityWeatherDetailsWithCityLocation(this.lat, this.lon);

  @override
  _CityWeatherDetailsWithCityLocationState createState() => _CityWeatherDetailsWithCityLocationState(lat, lon);
}

class _CityWeatherDetailsWithCityLocationState extends State<CityWeatherDetailsWithCityLocation> {

  final double lat;
  final double lon;
  _CityWeatherDetailsWithCityLocationState(this.lat, this.lon);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage( ( int.parse(formattedTime) < 18)
                        ? 'assets/images/sunny.png'
                        : 'assets/images/night.png'),
                    fit: BoxFit.fitWidth,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height/80,
                    ),
                    TodayWeatherWithCityLocation(lat, lon),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/80,
                    ),
                    HourlyWeekWeathersWithCityLocation(lat, lon),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/80,
                    ),
                    DailyWeekWeathersWithCityLocation(lat, lon),
                    SizedBox(
                      height: MediaQuery.of(context).size.height/80,
                    ),
                    TemperatureChartWithCityLocation(lat, lon),
                    SizedBox(
                        height: MediaQuery.of(context).size.height / 50
                    )
                  ],
                ),
              ),
            )
        )
    );
  }
}
