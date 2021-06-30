import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc.dart';

class HourlyWeekWeathersWithCityLocation extends StatefulWidget {

  final double lat;
  final double lon;

  HourlyWeekWeathersWithCityLocation(this.lat, this.lon);

  @override
  _HourlyWeekWeathersWithCityLocationState createState() => _HourlyWeekWeathersWithCityLocationState(lat, lon);
}

class _HourlyWeekWeathersWithCityLocationState extends State<HourlyWeekWeathersWithCityLocation> {

  final double lat;
  final double lon;
  var fm = new DateFormat('yyyy-MM-dd – kk:mm');

  _HourlyWeekWeathersWithCityLocationState(this.lat, this.lon);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    final weatherBloc = BlocProvider.of<WeatherDetailsBloc>(context);
    weatherBloc.add(FetchWeathersDetailsWithCityLocation(lat, lon));

    return BlocBuilder<WeatherDetailsBloc, WeatherDetailsState>(builder: (context, state){
      if (state is WeatherDetailsLoadingState){
        return Center(
            // child: SpinKitCircle(color: Colors.white)
        );
      }else if (state is WeatherDetailsIsLoadedState) {


        var hourly = state.getWeather.list;

        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[900].withOpacity(0.5),
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
                          color: (int.parse(formattedTime) < 18)
                              ? Colors.black54
                              : Colors.white, fontSize: 13.0),
                    )),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 200,
              ),
              Expanded(
                child: ListView.builder(
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
                              ),
                            ),
                            Text(
                              '${fahrenheitToCelsius(hourly[index].main.temp)}°C',
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
                  })
              ),
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


