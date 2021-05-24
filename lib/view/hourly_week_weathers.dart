import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/bloc/hourly_weather_bloc.dart';
import 'package:weather/bloc/week_weather_bloc.dart';

class HourlyWeekWeathers extends StatefulWidget {

  final String cityName;

  HourlyWeekWeathers(this.cityName);

  @override
  _HourlyWeekWeathersState createState() => _HourlyWeekWeathersState(cityName);
}

class _HourlyWeekWeathersState extends State<HourlyWeekWeathers> {

  final String cityName;
  var fm = new DateFormat('yyyy-MM-dd – kk:mm');

  _HourlyWeekWeathersState(this.cityName);
  // var date = DateFormat.d().format(DateTime.now()).length == 2? DateFormat.d().format(DateTime.now())
  //     : '0'+ DateFormat.d().format(DateTime.now());

  @override
  Widget build(BuildContext context) {

    final weatherBloc = BlocProvider.of<HourlyWeatherBloc>(context);
    weatherBloc.add(FetchHourlyWeathersWithGetForecastEvent(cityName));

    return BlocBuilder<HourlyWeatherBloc, HourlyWeatherState>(builder: (context, state){
      if (state is HourlyWeatherLoadingState){
        return Center(child: CircularProgressIndicator());
      }else if (state is HourlyWeatherIsLoadedState) {

        var hourly = state.getWeather.list;

        return ListView.builder(
            scrollDirection: Axis.horizontal,
            physics: BouncingScrollPhysics(),
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
                          child: SvgPicture.asset(
                            "assets/svgs/"+hourly[index].weather[0].icon+".svg", width: 40.0, cacheColorFilter: false,),
                          // Image.network(
                          //   'https://api.openweathermap.org/img/w/${hourly[index].weather[index].icon}.png',
                          //   fit: BoxFit.cover,
                          // ),

                      ),
                    ),
                    // Text("${list[index].dt_txt.substring(5,10)}", overflow: TextOverflow.ellipsis,style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.w500),),
                    // Text("${list[index].dt_txt.substring(10,16)}", overflow: TextOverflow.ellipsis,style: TextStyle(
                    //     fontSize: 16,
                    //     color: Colors.white,
                    //     fontWeight: FontWeight.w500),),
                    Text(
                      '${fahrenheitToCelsius(hourly[index].main.temp)}°C',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 13),
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 150),
                    // Text(
                    //   '${fahrenheitToCelsius(list[index].main.temp_max)}°C',
                    //   style: TextStyle(
                    //       color: Colors.white,
                    //       fontWeight: FontWeight.w300,
                    //       fontSize: 13),
                    // ),
                    // Text('${fm.format(new DateTime.fromMicrosecondsSinceEpoch(1621080000))}',style:TextStyle(color: Colors.white),),
                    // Text('${list[index].weather[0].description}', style: TextStyle(color: Colors.white),),

                    Text('${DateFormat('h:m a').format( DateTime.fromMillisecondsSinceEpoch(hourly[index].dt* 1000))}', style: TextStyle(color: Colors.white,
                      fontSize: 13, fontWeight: FontWeight.w300),),
                    // Text('${DateFormat('yyyy-MM-dd').format( DateTime.fromMillisecondsSinceEpoch(hourly[index].dt* 1000))}', style: TextStyle(color: Colors.white,
                    //     fontSize: 13, fontWeight: FontWeight.w300),),

                    // Text('${fm.format(new DateTime.fromMicrosecondsSinceEpoch(hourly[index].dt))}', style: TextStyle(color: Colors.white,
                    //     fontSize: 13, fontWeight: FontWeight.w300),),
                    // Text("${hourly[index].dt}",
                    //     overflow: TextOverflow.ellipsis,
                    //     style: TextStyle(
                    //         color: Colors.white,
                    //         fontWeight: FontWeight.w300,
                    //         fontSize: 13)),
                    // SizedBox(height: MediaQuery.of(context).size.height/5,)
                  ],
                )
              );
            });
      } else if (state is DailyWeatherIsNotLoadedState) {
        return Text(
          'City not Found',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      } else
        return Text("Nothing",
            style: TextStyle(fontSize: 25, color: Colors.white));
    });
  }

  fahrenheitToCelsius( double degree ){
    int celsious = (degree - 273.15).toInt();
    return celsious;
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


