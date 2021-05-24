import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/week_weather_bloc.dart';

class DailyWeekWeathers extends StatefulWidget {

  final String cityName;

  DailyWeekWeathers(this.cityName);
  @override
  _DailyWeekWeathersState createState() => _DailyWeekWeathersState(cityName);
}

class _DailyWeekWeathersState extends State<DailyWeekWeathers> {

  final String cityName;

  _DailyWeekWeathersState(this.cityName);

  @override
  Widget build(BuildContext context) {
    final weatherBloc = BlocProvider.of<DailyWeatherBloc>(context);
    weatherBloc.add(FetchDailyWeathersWithGetForecastEvent(cityName));

    return BlocBuilder<DailyWeatherBloc, DailyWeatherState>(builder: (context, state){
      if (state is DailyWeatherLoadingState){
        return Center(child: CircularProgressIndicator());
      }else
      if (state is DailyWeatherIsLoadedState){
        var daily = state.getWeather.;
        return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
            itemCount: daily.,
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
                          child: SvgPicture.asset(
                            "assets/svgs/"+daily[index]+".svg", width: 40.0, cacheColorFilter: true,),
                        ),
                      ),
                      Text(
                        '${fahrenheitToCelsius(daily[index].main.tempMax)}°C',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w300,
                            fontSize: 13),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 150),
                      Text(
                        '${fahrenheitToCelsius(daily[index].main.tempMin)}°C',
                        style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.w300,
                            fontSize: 13),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height / 60),
                      Text('${DateFormat('MM-dd').format( DateTime.fromMillisecondsSinceEpoch(daily[index].dt* 1000))}', style: TextStyle(color: Colors.white,
                          fontSize: 13, fontWeight: FontWeight.w300),),
                    ],
                  )
              );
            });
      }else
      if (state is DailyWeatherIsNotLoadedState){
        return Text(
          'City not Found',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      }else
        return Text("Nothing", style: TextStyle(fontSize: 25, color: Colors.white));
    }
    );
  }

  fahrenheitToCelsius( double degree ){
    int celsious = (degree - 273.15).toInt();
    return celsious;
  }
}
