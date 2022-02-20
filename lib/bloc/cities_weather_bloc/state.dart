import 'package:equatable/equatable.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/models/weather_model.dart';

class CitiesWeatherState extends Equatable {
  @override

  List<Object> get props => throw[];
}

class UpdateCitiesWeatherIsLoadedState extends CitiesWeatherState{
  final WeatherModel _weather;

  UpdateCitiesWeatherIsLoadedState(this._weather);

  WeatherModel get getWeather => _weather;


  @override
  List<Object> get props => [_weather];
}

class CitiesWeatherIsLoadedState extends CitiesWeatherState {
  final citiesWeather;

  CitiesWeatherIsLoadedState(this.citiesWeather);

  List<CityModel> get getCitiesWeathers => citiesWeather;

  @override
  List<Object> get props => [citiesWeather];
}

class CitiesWeatherIsNotLoadedState extends CitiesWeatherState{}

class CitiesWeatherIsLoadingState extends CitiesWeatherState {}

class CitiesWeatherError extends CitiesWeatherState {
  final int errorCode;

  CitiesWeatherError(this.errorCode);

}