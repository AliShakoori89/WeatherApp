import 'package:flutter/material.dart';
import 'package:weather/component/day_time.dart';
import 'package:weather/view/daily_weak_weathers_with_city_name.dart';
import 'package:weather/view/hourly_week_weathers_with_city_name.dart';
import 'package:weather/view/search_city_weather_result.dart';
import 'package:weather/view/temperature_chart_with_cityname.dart';
import 'package:weather/view/today_weather_with_city_name.dart';


class SearchCityResultPage extends StatelessWidget {

  final String cityName;
  final IconData iconType;

  SearchCityResultPage(this.cityName, this.iconType);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          // color: Colors.white,
            image: DecorationImage(
              image: AssetImage((dayTime() < 16)
                  ? 'assets/images/sunny.png'
                  : (18 > dayTime())
                  ? 'assets/images/afternoon.png'
                  : 'assets/images/night.png'),
              fit: BoxFit.fill,
            )),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              SearchCityWeatherResult(cityName, iconType),
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
    );
  }
}

