import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:weather/bloc/cities_summery_container_bloc.dart';
import 'package:weather/bloc/weather_bloc.dart';
import 'package:weather/convert/convert_temperature.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/p_icons.dart';
import 'package:weather/view/search_screen.dart';
import 'package:weather/wind_icons.dart';

class TodayWeatherWithCityName extends StatefulWidget {

  final String cityName;
  TodayWeatherWithCityName(this.cityName);

  @override
  _TodayWeatherWithCityNameState createState() => _TodayWeatherWithCityNameState(cityName);
}

class _TodayWeatherWithCityNameState extends State<TodayWeatherWithCityName> {

  final String cityName;

  _TodayWeatherWithCityNameState(this.cityName);

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    String formattedTime = DateFormat('kk').format(now);

    final weatherBloc = BlocProvider.of<WeatherBloc>(context);
    weatherBloc.add(FetchWeatherWithCityNameEvent(cityName));

    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state){
      if (state is WeatherLoadingState){
        return Center(
            // child: SpinKitCircle(color: Colors.white)
        );
      }
      if (state is WeatherIsLoadedState){

        var temp = state.getWeather.main.temp;
        var name = state.getWeather.name;
        var weather = state.getWeather.weather;
        var pressure = state.getWeather.main.pressure;
        var humidity = state.getWeather.main.humidity;
        var maxTemp = state.getWeather.main.tempMax;
        var minTemp = state.getWeather.main.tempMin;
        var wind = state.getWeather.wind.speed;
        var sunrise = state.getWeather.sys.sunrise;
        var feelsLike = state.getWeather.main.feelsLike;
        var id = state.getWeather.id;
        var time = state.getWeather.dt;

        return Container(
          decoration: BoxDecoration(
              color: Colors.grey[900].withOpacity(0.5),
              borderRadius: BorderRadius.circular(25)
          ),
          width: MediaQuery.of(context).size.width/1.05,
          height: MediaQuery.of(context).size.height/2.5,
          child: Wrap(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  cityNameIcon(context, name),
                  addIcon(context, id, name, feelsLike, temp, maxTemp, minTemp, time, weather)
                ],
              ),
              todayTimeWidget(context, time),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              weatherIconAndWeatherDescriptionWidget(weather, context),
              SizedBox(
                height: MediaQuery.of(context).size.height / 50,
              ),
              Center(
                child: Text(
                  '${ConvertTemperature().fahrenheitToCelsius(temp)}' + '°C',
                  style: TextStyle(fontSize: 50, color: Colors.white, fontWeight: FontWeight.w100),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 30,
              ),
              todayWeatherDetailsWidget(context, pressure, humidity, maxTemp, minTemp, wind, sunrise)
            ],
          ),
        );
      }
      if (state is WeatherIsNotLoadedState){
        return Text(
          'City not Found',
          style: TextStyle(fontSize: 25, color: Colors.white),
        );
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height / 4 ,),
          Text("Please enter true city name", style: TextStyle(fontSize: 15, color: (int.parse(formattedTime) < 18)
              ? Colors.black87
              : Colors.white, fontWeight: FontWeight.w300)),
          Text("or", style: TextStyle(fontSize: 20, color: (int.parse(formattedTime) < 18)
              ? Colors.black87
              : Colors.white, fontWeight: FontWeight.w300)),
          Text("Please check your internet connection", style: TextStyle(fontSize: 15, color: (int.parse(formattedTime) < 18)
              ? Colors.black87
              : Colors.white, fontWeight: FontWeight.w300))
        ],
      );
    });
  }

  Container todayWeatherDetailsWidget(BuildContext context, int pressure, int humidity, double maxTemp, double minTemp, double wind, int sunrise) {
    return Container(
            decoration: BoxDecoration(
                color: Colors.grey[850].withOpacity(0.5),
                borderRadius: BorderRadius.circular(25)
            ),
            width: MediaQuery.of(context).size.width/1.05,
            height: MediaQuery.of(context).size.height/8.9,
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height/90,
                  bottom: MediaQuery.of(context).size.height/90
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pressureWidget(context, pressure),
                      humidityWidget(context, humidity),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      maxTemperatureWidget(context, maxTemp),
                      minTemperatureWidget(context, minTemp)
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      windInformationWidget(context, wind),
                      sunriseWidget(context, sunrise)
                    ],
                  ),
                ],
              ),
            ),
          );
  }

  Padding sunriseWidget(BuildContext context, int sunrise) {
    return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height/200,
              right: MediaQuery.of(context).size.height/40,),
            child: Row(
              children: [
                Icon(Icons.wb_sunny, color: Colors.orange,),
                SizedBox(width: MediaQuery.of(context).size.height/200,),
                Text('${ DateFormat('h:m a').format(DateTime.fromMicrosecondsSinceEpoch(sunrise))}', style: TextStyle(color: Colors.white,
                    fontSize: 13, fontWeight: FontWeight.w300),),
              ],
            ),
          );
  }

  Padding windInformationWidget(BuildContext context, double wind) {
    return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height/500,
            right: MediaQuery.of(context).size.height/40,),
            child: Row(
              children: [
                Icon(WindIcon.wind, color: Colors.blue[300],),
                SizedBox(width: MediaQuery.of(context).size.height/100,),
                Text('$wind',
                  style: TextStyle(color: Colors.white,
                      fontSize: 13, fontWeight: FontWeight.w300),),
                SizedBox(width: MediaQuery.of(context).size.height/120,),
                Text('m/s', style: TextStyle(color: Colors.white,
                    fontSize: 13, fontWeight: FontWeight.w300))
              ],
            ),
          );
  }

  Padding minTemperatureWidget(BuildContext context, double minTemp) {
    return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height/200,),
            child: Row(
              children: [
                Icon(Icons.arrow_downward, color: Colors.blue, size: 18),
                SizedBox(width: MediaQuery.of(context).size.height/100,),
                Text('${ConvertTemperature().fahrenheitToCelsius(minTemp)}°C',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 13),),
              ],
            ),
          );
  }

  Padding maxTemperatureWidget(BuildContext context, double maxTemp) {
    return Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.height/200,),
            child: Row(
              children: [
                Icon(Icons.arrow_upward_sharp, color: Colors.red, size: 18,),
                SizedBox(width: MediaQuery.of(context).size.height/100,),
                Text('${ConvertTemperature().fahrenheitToCelsius(maxTemp)}°C',
                  style: TextStyle(color: Colors.white,
                      fontWeight: FontWeight.w300,
                      fontSize: 13),),
              ],
            ),
          );
  }

  Padding humidityWidget(BuildContext context, int humidity) {
    return Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.height/50),
            child: Row(
              children: [
                Icon(Icons.opacity, color: Colors.blue,),
                Align(
                    alignment: Alignment.bottomLeft,
                    child: Text('$humidity %' ,
                      style: TextStyle(color: Colors.white,
                          fontWeight: FontWeight.w300,
                          fontSize: 13),)),
              ],
            ),
          );
  }

  Padding pressureWidget(BuildContext context, int pressure) {
    return Padding(
      padding: EdgeInsets.only(
          left: MediaQuery.of(context).size.height/30,
      top: MediaQuery.of(context).size.height/180),
      child: Row(
              children: [
                Icon(P.tachometer_alt, color: Colors.red[300],size: 18,),
                SizedBox(width: MediaQuery.of(context).size.height/150,),
                Text(pressure.toString(),style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300,
                    fontSize: 13))
              ],
      ),
    );
  }

  Row weatherIconAndWeatherDescriptionWidget(List<Weather> weather, BuildContext context) {
    return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/svgs/"+"${weather[0].icon}"+".svg", width: 70.0,),
              SizedBox(
                width: MediaQuery.of(context).size.width / 80,
              ),
              Column(
                children: [
                  Text(
                    '${weather[0].main}',
                    style: TextStyle(color: Colors.white),
                  ),
                  Text(
                    '${weather[0].description}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ],
          );
  }

  Padding todayTimeWidget(BuildContext context, int time) {
    return Padding(
            padding: EdgeInsets.only(left: MediaQuery.of(context).size.height / 30),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text('${DateFormat('E, ha').format(
                  DateTime.fromMillisecondsSinceEpoch(time * 1000))}',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 12)),
            ),
          );
  }

  Padding addIcon(BuildContext context, int id, String name, double feelsLike, double temp, double maxTemp, double minTemp, int time, List<Weather> weather) {
    return Padding(
                padding: EdgeInsets.only(
                  right:  MediaQuery.of(context).size.height/50,),
                child: Center(
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.add, color: Colors.white, size: 20),
                        onPressed: (){
                          CityModel cityModel = CityModel();
                          cityModel.id = id;
                          cityModel.name = name;
                          cityModel.feelsLike = feelsLike;
                          cityModel.temp = temp;
                          cityModel.tempMax = maxTemp;
                          cityModel.tempMin = minTemp;
                          cityModel.time = time;
                          cityModel.icon = weather[0].icon;
                          final citiesWeathersSummeryBloc = BlocProvider.of<CitiesWeathersSummeryBloc>(context);
                          citiesWeathersSummeryBloc.add(SaveCityWeathersEvent(cityModel));
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => SearchScreen()));
                        },
                      )
                    ],
                  ),
                ),
              );
  }

  Row cityNameIcon(BuildContext context, String name) {
    return Row(
                children: [
                  Icon(Icons.location_on, color: Colors.white, size: 20,),
                  SizedBox(width: MediaQuery.of(context).size.height/150,),
                  Text(name, style: TextStyle(fontSize: 20, color: Colors.white,
                      fontWeight: FontWeight.w300),),
                ],
              );
  }
}
