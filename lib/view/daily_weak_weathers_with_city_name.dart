import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc.dart';
import 'package:weather/convert/convert_temperature.dart';

class DailyWeekWeathersWithCityName extends StatefulWidget {

  final String cityName;

  DailyWeekWeathersWithCityName(this.cityName);
  @override
  _DailyWeekWeathersWithCityNameState createState() => _DailyWeekWeathersWithCityNameState(cityName);
}

class _DailyWeekWeathersWithCityNameState extends State<DailyWeekWeathersWithCityName> {

  final String cityName;

  _DailyWeekWeathersWithCityNameState(this.cityName);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);
    
    final weatherBloc = BlocProvider.of<WeatherDetailsBloc>(context);
    weatherBloc.add(FetchWeathersDetailsWithCityName(cityName));

    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(builder: (context, state){
      if (state is WeatherDetailsLoadingState){
        return Center(
            // child: SpinKitCircle(color: Colors.white)
        );
      }else
      if (state is WeatherDetailsIsLoadedState){

        var daily = state.getWeather.list;

        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[900].withOpacity(0.5),
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
                          color: (int.parse(formattedTime) < 18)
                              ? Colors.white
                              : Colors.black54, fontSize: 13.0),
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
                                child: SvgPicture.asset(
                                  "assets/svgs/"+daily[index].weather[0].icon+".svg", width: 40.0, cacheColorFilter: true,),
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
          'City not Found',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      }else
        return Text("", style: TextStyle(fontSize: 25, color: Colors.white));
    }
    );
  }
}
