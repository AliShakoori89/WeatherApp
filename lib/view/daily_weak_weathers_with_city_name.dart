import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/bloc.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/event.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/state.dart';
import 'package:weather/convert/convert_temperature.dart';

class DailyWeekWeathersWithCityName extends StatelessWidget {

  final String cityName;

  DailyWeekWeathersWithCityName(this.cityName);

  @override
  Widget build(BuildContext context) {

    final weatherBloc = BlocProvider.of<WeatherDetailsBloc>(context);
    weatherBloc.add(FetchWeathersDetailsWithCityName(cityName));

    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(builder: (context, state){
      if (state is WeatherDetailsLoadingState){
        return Center();
      }else
      if (state is WeatherDetailsIsLoadedState){

        var daily = state.getWeather.list;

        return Container(
            margin: const EdgeInsets.only(
                left: 15.0,
                right: 15.0,
            ),
          decoration: BoxDecoration(
              color: Colors.grey[900].withOpacity(0.9),
              borderRadius: BorderRadius.circular(25)),
          width: MediaQuery.of(context).size.width/1.05,
          height: MediaQuery.of(context).size.height / 4.2,
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
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: BouncingScrollPhysics(),
                    itemCount: daily.length,
                    itemBuilder: (context, index){
                      return SizedBox(
                        width: MediaQuery.of(context).size.height / 10,
                        child: Column(
                          children: [
                            SizedBox(height: MediaQuery.of(context).size.height / 150),
                            Container(
                              width: MediaQuery.of(context).size.height / 12,
                              height: MediaQuery.of(context).size.height / 12,
                              child: Center(
                                child: Image.asset('assets/gifs/' +daily[index].weather[0].icon+'.gif',
                                    height: 35, width: 35)
                              ),
                            ),
                            Text(
                              '${ConvertTemperature().fahrenheitToCelsius(daily[index].main.tempMax)}°C',

                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 150),
                            Text(
                              '${ConvertTemperature().fahrenheitToCelsius(daily[index].main.tempMin)}°C',
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 13),
                            ),
                            SizedBox(height: MediaQuery.of(context).size.height / 60),
                            Text('${DateFormat('MM-dd').format( DateTime.fromMillisecondsSinceEpoch(daily[index].dt* 1000))}', style: TextStyle(color: Colors.white,
                                fontSize: 13, fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                      );
                    })
              ),
            ],
          )
        );
      }else
      if (state is WeatherDetailsIsNotLoadedState){
        return Text(
          '',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      }else
        return Text("", style: TextStyle(fontSize: 25, color: Colors.white));
    }
    );
  }
}
