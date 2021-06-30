import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc.dart';
import 'package:weather/convert/convert_temperature.dart';
import 'package:weather/view/temperature_Line_Chart.dart';

class TemperatureChartWithCityLocation extends StatefulWidget {

  final double lat;
  final double lon;

  const TemperatureChartWithCityLocation(this.lat, this.lon);

  @override
  _TemperatureChartWithCityLocationState createState() => _TemperatureChartWithCityLocationState(lat, lon);
}

class _TemperatureChartWithCityLocationState extends State<TemperatureChartWithCityLocation> {

  final double lat;
  final double lon;

  _TemperatureChartWithCityLocationState(this.lat, this.lon);

  @override
  Widget build(BuildContext context) {

    final weatherBloc = BlocProvider.of<WeatherDetailsBloc>(context);
    weatherBloc.add(FetchWeathersDetailsWithCityLocation(lat, lon));

    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(builder: (context, state){

      if (state is WeatherDetailsLoadingState){
        return Center(child: SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: SpinKitCircle(color: Colors.black54)));
      }else
      if (state is WeatherDetailsIsLoadedState){
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
        return Wrap(
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
            SizedBox(
              height: MediaQuery.of(context).size.height / 80,
            ),
            Center(
              child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(25)),
                  width: MediaQuery.of(context).size.width/1.05,
                  height: MediaQuery.of(context).size.height / 3.5,
                  child: TemperatureLineChart(date, maxTemp, minTemp)),
            ),
          ],
        );

      }else
      if (state is WeatherDetailsIsNotLoadedState){
        return Text(
          'There was an error fetching weather data',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      }else
        return Text("We have trouble fetching weather for this location", style: TextStyle(fontSize: 25, color: Colors.white));
    });
  }
}
