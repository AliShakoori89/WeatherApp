import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/bloc.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/event.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/state.dart';
import 'package:weather/convert/convert_temperature.dart';

class HourlyWeekWeathersWithCityName extends StatelessWidget {

  final String cityName;

  HourlyWeekWeathersWithCityName(this.cityName);

  var fm = new DateFormat('MM-dd – kk:mm');

  @override
  Widget build(BuildContext context) {

    final weatherBloc = BlocProvider.of<WeatherDetailsBloc>(context);
    weatherBloc.add(FetchWeathersDetailsWithCityName(cityName));

    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(builder: (context, state){
      if (state is WeatherDetailsLoadingState){
        return Center();
      }else if (state is WeatherDetailsIsLoadedState) {

        var hourly = state.getWeather.list;

        return Container(
          margin: EdgeInsets.only(
            left: 15,
            right: 15
          ),
          decoration: BoxDecoration(
              color: Colors.grey[900].withOpacity(0.9),
              borderRadius: BorderRadius.circular(25)),
          width: MediaQuery.of(context).size.width/1.05,
          height: MediaQuery.of(context).size.height/4.5,
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
              SizedBox(
                height: MediaQuery.of(context).size.height / 200,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: hourly.length - 20,
                    itemBuilder: (context, index) {

                      return SizedBox(
                          width: MediaQuery.of(context).size.height / 10,
                          child: Column(
                            children: [
                              SizedBox(height: MediaQuery.of(context).size.height / 150),
                              Container(
                                width: MediaQuery.of(context).size.height / 12,
                                height: MediaQuery.of(context).size.height / 12,
                                child: Center(
                                  child: Image.asset('assets/gifs/' +hourly[index].weather[0].icon+'.gif',
                                    width: 35, height: 35,)
                                ),
                              ),
                              Text(
                                '${ConvertTemperature().fahrenheitToCelsius(hourly[index].main.temp)}°C',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300,
                                    fontSize: 13),
                              ),
                              SizedBox(height: MediaQuery.of(context).size.height / 150),
                              Text('${DateFormat('h:m a').format( DateTime.fromMillisecondsSinceEpoch(hourly[index].dt* 1000))}', style: TextStyle(color: Colors.white,
                                  fontSize: 13, fontWeight: FontWeight.w300),),
                            ],
                          )
                      );
                    }),
              )
            ],
          )
        );
      } else if (state is WeatherDetailsIsNotLoadedState) {
        return Text(
          '',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      } else
        return Text("",
            style: TextStyle(fontSize: 25, color: Colors.white));
    });
  }

  getLat() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    final lat = prefs.getDouble('lat') ?? null;
    return lat;
  }

  getLon() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return double
    final lon = prefs.getDouble('lon') ?? null;
    return lon;
  }
}


