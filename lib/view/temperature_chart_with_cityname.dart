import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

    final weatherBloc = BlocProvider.of<WeatherDetailsBloc>(context);
    weatherBloc.add(FetchWeathersDetailsWithCityName(cityName));

    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(builder: (context, state){

    if (state is WeatherDetailsLoadingState){
    return Center(child: CircularProgressIndicator());
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
          return TemperatureLineChart(date, maxTemp, minTemp);

    }else
    if (state is WeatherDetailsIsNotLoadedState){
      return Text(
        'There was an error fetching weather data',
        style: TextStyle(fontSize: 25, color: Colors.white),
      );
    }else
      return Text("We have trouble fetching weather for $cityName", style: TextStyle(fontSize: 25, color: Colors.white));
    });
  }
}
