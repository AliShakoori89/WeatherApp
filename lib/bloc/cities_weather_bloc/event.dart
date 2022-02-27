import 'package:equatable/equatable.dart';
import 'package:weather/models/city_model.dart';

class CitiesWeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SaveCityWeathersEvent extends CitiesWeatherEvent {
  final CityModel cityWeathers;

  SaveCityWeathersEvent(this.cityWeathers);

  @override
  List<Object> get props => [cityWeathers];
}

class FetchAllDataEvent extends CitiesWeatherEvent {}

class FetchWeatherWithCityNameForUpdateEvent extends CitiesWeatherEvent {
  final String cityName;

  FetchWeatherWithCityNameForUpdateEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class DeleteCityForWeatherEvent extends CitiesWeatherEvent {
  final String cityName;

  DeleteCityForWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class UpdateCityWeatherEvent extends CitiesWeatherEvent {
  final CityModel cityWeathers;

  UpdateCityWeatherEvent(this.cityWeathers);

  @override
  List<Object> get props => [cityWeathers];
}

class WeatherError extends CitiesWeatherEvent {
  final int errorCode;

  WeatherError(this.errorCode);
}
