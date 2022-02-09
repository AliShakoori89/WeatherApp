import 'package:equatable/equatable.dart';
import 'package:weather/models/hourly_weather_model.dart';

class WeatherDetailsState extends Equatable {
  @override

  List<Object> get props => throw[];
}

class WeatherDetailsIsLoadedState extends WeatherDetailsState{
  final WeatherDetailsModel _weather;

  WeatherDetailsIsLoadedState(this._weather);

  WeatherDetailsModel get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class WeatherDetailsError extends WeatherDetailsState {
  final int errorCode;

  WeatherDetailsError(this.errorCode);

}

class WeatherDetailsLoadingState extends WeatherDetailsState {}

class WeatherDetailsIsNotLoadedState extends WeatherDetailsState {}

class WeatherDetailsEmpty extends WeatherDetailsState {}