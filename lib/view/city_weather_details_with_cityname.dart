import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/cities_summery_container_bloc.dart';
import 'package:weather/view/temperature_chart_with_cityname.dart';
import 'package:weather/view/daily_weak_weathers_with_city_name.dart';
import 'package:weather/view/hourly_week_weathers_with_city_name.dart';
import 'package:weather/view/today_weather_with_city_name.dart';


class CityWeatherDetailsWithName extends StatefulWidget {

  final String cityName;

  CityWeatherDetailsWithName(this.cityName);

  @override
  _CityWeatherDetailsWithNameState createState() => _CityWeatherDetailsWithNameState(cityName);
}

class _CityWeatherDetailsWithNameState extends State<CityWeatherDetailsWithName> {

  final String cityName;
  _CityWeatherDetailsWithNameState(this.cityName);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    return WillPopScope(
      onWillPop: () async{
        FocusScope.of(context).unfocus();
        return Navigator.canPop(context);
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage( ( int.parse(formattedTime) < 18 )
                        ? 'assets/images/sunny.png'
                        : 'assets/images/night.png'),
                    fit: BoxFit.fitWidth,
                    colorFilter: new ColorFilter.mode(
                        Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    TodayWeatherWithCityName(cityName),
                    SizedBox(
                      height: 20,
                    ),
                    HourlyWeekWeathersWithCityName(cityName),
                    SizedBox(
                      height: 20,
                    ),
                    DailyWeekWeathersWithCityName(cityName),
                    SizedBox(
                      height: 20,
                    ),
                    TemperatureChartWithCityName(cityName),
                    SizedBox(
                        height: 20
                    )
                  ],
                ),
              ),
            )
        )
      ),
    );
  }
}

