import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather/view/temperature_chart_with_cityname.dart';
import 'package:weather/view/daily_weak_weathers_with_city_name.dart';
import 'dart:ui' as ui;
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
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[900].withOpacity(0.5),
                        borderRadius: BorderRadius.circular(25)
                    ),
                    width: MediaQuery.of(context).size.width/1.05,
                    height: MediaQuery.of(context).size.height/2.1,
                    child: Directionality(
                      textDirection: ui.TextDirection.ltr,
                      child: TodayWeatherWithCityName(cityName),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/80,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[900].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25)),
                      width: MediaQuery.of(context).size.width/1.05,
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
                          Expanded(child: HourlyWeekWeathersWithCityName(cityName))
                        ],
                      )
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/80,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[900].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25)),
                      width: MediaQuery.of(context).size.width/1.05,
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
                          Expanded(child: DailyWeekWeathersWithCityName(cityName)),
                        ],
                      )
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/80,
                  ),
                  Container(
                      decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(25)),
                      width: MediaQuery.of(context).size.width/1.05,
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
                                  'DAILY Chart',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 13.0),
                                )),
                          ),
                          Expanded(child: TemperatureChartWithCityName(cityName)),
                        ],
                      )
                  ),
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

