import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/view/cities_menu.dart';
import 'package:weather/view/temperature_chart_with_cityname.dart';
import 'package:weather/view/daily_weak_weathers_with_city_name.dart';
import 'package:weather/view/hourly_week_weathers_with_city_name.dart';
import 'package:weather/view/today_weather_with_city_name.dart';


class CityWeatherDetailsWithName extends StatefulWidget {

  final String cityName;
  final IconData trueIcon;

  CityWeatherDetailsWithName(this.cityName, this.trueIcon);

  @override
  _CityWeatherDetailsWithNameState createState() => _CityWeatherDetailsWithNameState(cityName, trueIcon);
}

class _CityWeatherDetailsWithNameState extends State<CityWeatherDetailsWithName> {

  final String cityName;
  final IconData trueIcon;

  _CityWeatherDetailsWithNameState(this.cityName, this.trueIcon);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    return Scaffold(
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
              )
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                TodayWeatherWithCityName(cityName, trueIcon),
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
        ),
      ),
    );
  }
}

