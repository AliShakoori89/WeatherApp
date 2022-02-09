import 'package:equatable/equatable.dart';
import 'package:weather/models/weather_model.dart';

class WeatherState extends Equatable {
  @override

  List<Object> get props => throw[];
}



class WeatherIsLoadedState extends WeatherState{
  final WeatherModel _weather;

  WeatherIsLoadedState(this._weather);

  WeatherModel get getWeather => _weather;


  @override
  List<Object> get props => [_weather];
}

class WeatherError extends WeatherState {
  final int errorCode;

  WeatherError(this.errorCode);

}

class WeatherLoadingState extends WeatherState {}

class WeatherIsNotLoadedState extends WeatherState {}

class WeatherEmpty extends WeatherState {}