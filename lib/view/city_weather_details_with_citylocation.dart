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
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage( ( int.parse(formattedTime) < 18) ?'assets/images/sunny.png' : 'assets/images/night.png'),
                    fit: BoxFit.fill,
                    colorFilter: new ColorFilter.mode(Colors.black.withOpacity(0.7), BlendMode.dstATop),
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height/20,
                        left: MediaQuery.of(context).size.height/50,
                        right: MediaQuery.of(context).size.height/50,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[900].withOpacity(0.5),
                            borderRadius: BorderRadius.circular(25)
                        ),
                        width: MediaQuery.of(context).size.height,
                        height: MediaQuery.of(context).size.height/1.98,
                        child: Directionality(
                          textDirection: ui.TextDirection.ltr,
                          child: TodayWeatherWithCityLocation(lat, lon),
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height/40,
                          left: MediaQuery.of(context).size.height/50,
                          right: MediaQuery.of(context).size.height/50,
                        ),
                        child: Container(
                            decoration: BoxDecoration(
                                color: Colors.grey[900].withOpacity(0.5),
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
                                Expanded(child: HourlyWeekWeathersWithCityLocation(lat, lon))
                              ],
                            )
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height/40,
                        left: MediaQuery.of(context).size.height/50,
                        right: MediaQuery.of(context).size.height/50,
                      ),
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.grey[900].withOpacity(0.5),
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
                              Expanded(child: DailyWeekWeathersWithCityLocation(lat, lon)),
                            ],
                          )
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
                              color: Colors.white.withOpacity(0.5),
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
                                      'DAILY Chart',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 13.0),
                                    )),
                              ),
                              Expanded(child: TemperatureChartWithCityLocation(lat, lon)),
                            ],
                          )
                      ),
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
