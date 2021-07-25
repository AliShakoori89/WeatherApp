import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/search_location_bloc.dart';
import 'package:weather/view/daily_week_weathers_with_city_location.dart';
import 'package:weather/view/hourly_week_weathers_with_city_location.dart';
import 'package:weather/view/search_screen.dart';
import 'package:weather/view/temperature_chart_with_citylocation.dart';
import 'package:weather/view/today_weather_with_citylocation.dart';


class CityWeatherDetailsWithCityLocation extends StatefulWidget {

  CityWeatherDetailsWithCityLocation();

  @override
  _CityWeatherDetailsWithCityLocationState createState() => _CityWeatherDetailsWithCityLocationState();
}

class _CityWeatherDetailsWithCityLocationState extends State<CityWeatherDetailsWithCityLocation> {

  _CityWeatherDetailsWithCityLocationState();

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    final searchBloc = BlocProvider.of<SearchLocationsBloc>(context);
    searchBloc.add(FetchWeathersLocations());

    return WillPopScope(
      onWillPop: () async{
        FocusScope.of(context).unfocus();
        return Navigator.canPop(context);
      },
      child: BlocBuilder<SearchLocationsBloc, SearchLocationStat>(builder: (context, state){
      if (state is SearchLocationLoadingState){
        return Padding(
          padding: const EdgeInsets.only(
              left: 140,
          right: 140),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/images/Weather.gif')
              )
            ),
          ),
        );
          // SpinKitCircle(color: Colors.white);
      }else
      if (state is SearchLocationIsLoadedState){
        var lat = state.getLocations.latitude;
        var lon = state.getLocations.longitude;

        return Scaffold(
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
                        height: 20,
                      ),
                      TodayWeatherWithCityLocation(lat, lon),
                      SizedBox(
                        height: 20,
                      ),
                      HourlyWeekWeathersWithCityLocation(lat, lon),
                      SizedBox(
                        height: 20,
                      ),
                      DailyWeekWeathersWithCityLocation(lat, lon),
                      SizedBox(
                        height: 20,
                      ),
                      TemperatureChartWithCityLocation(lat
                          , lon),
                      SizedBox(
                          height: 20
                      )
                    ],
                  ),
                ),
              )
          )
        );
      }else
      if (state is SearchLocationIsNotLoadedState){
        return Text(
          '',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      }else
        return Text("", style: TextStyle(fontSize: 25, color: Colors.white));
      }
      ),
    );
  }
}
