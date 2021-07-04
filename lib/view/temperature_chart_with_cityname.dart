import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc.dart';
import 'package:weather/convert/convert_temperature.dart';
import 'package:weather/view/temperature_Line_Chart.dart';

class TemperatureChartWithCityName extends StatefulWidget {

  final String cityName;

  const TemperatureChartWithCityName(this.cityName);

  @override
  _TemperatureChartWithCityNameState createState() => _TemperatureChartWithCityNameState(cityName);
}

class _TemperatureChartWithCityNameState extends State<TemperatureChartWithCityName> {

  final String cityName;

  _TemperatureChartWithCityNameState(this.cityName);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    final weatherBloc = BlocProvider.of<WeatherDetailsBloc>(context);
    weatherBloc.add(FetchWeathersDetailsWithCityName(cityName));

    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(builder: (context, state){

    if (state is WeatherDetailsLoadingState){
    return Align(
      alignment: Alignment.bottomCenter,
      child: SpinKitCircle(color: Colors.white),
    );
    }else
    if (state is WeatherDetailsIsLoadedState){
      print(state.getWeather.list[0].dt);
          List<String> date = [];
          List<int> maxTemp = [];
          List<int> minTemp = [];
          for(int i = 1 ; i < state.getWeather.list.length ; i++){
            if(
            DateFormat('d').format(
                DateTime.fromMillisecondsSinceEpoch(state.getWeather.list[i-1].dt * 1000))
            !=
            DateFormat('d').format(
                DateTime.fromMillisecondsSinceEpoch(state.getWeather.list[i].dt * 1000)
            )
            ){
              date.add(DateFormat('d').format(
                  DateTime.fromMillisecondsSinceEpoch(state.getWeather.list[i].dt * 1000)));
                  maxTemp.add(ConvertTemperature().fahrenheitToCelsius(state.getWeather.list[i].main.tempMax));
                  minTemp.add(ConvertTemperature().fahrenheitToCelsius(state.getWeather.list[i].main.tempMin));
            }
          }
          return Container(
              margin: const EdgeInsets.only(
                  left: 15.0,
                  right: 15.0,
              ),
              decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(25)),
              width: MediaQuery.of(context).size.width/1.05,
              height: MediaQuery.of(context).size.height / 3.2,
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
                              color: Colors.black54, fontSize: 13.0),
                        )),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 80,
                  ),
                  TemperatureLineChart(date, maxTemp, minTemp)
                ],
              )
          );

    }else
    if (state is WeatherDetailsIsNotLoadedState){
      return Text(
        'There was an error fetching weather data',
        style: TextStyle(fontSize: 25, color: Colors.white),
      );
    }else
      return Center(child: Text("We have trouble fetching weather for $cityName", style: TextStyle(fontSize: 16, color: (int.parse(formattedTime) < 18)
          ? Colors.black87
          : Colors.white)));
    });
  }
}
