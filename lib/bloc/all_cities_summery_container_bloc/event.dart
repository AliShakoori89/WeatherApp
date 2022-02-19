import 'package:equatable/equatable.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/state.dart';
import 'package:weather/models/city_model.dart';

class CitiesWeathersSummeryEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class SaveCityWeathersEvent extends CitiesWeathersSummeryEvent{
  final CityModel cityWeathers;

  SaveCityWeathersEvent(this.cityWeathers);

  @override
  List<Object> get props => [cityWeathers];
}

class FetchAllDataEvent extends CitiesWeathersSummeryEvent{}

class FetchWeatherWithCityNameForUpdateEvent extends CitiesWeathersSummeryEvent{
  final String cityName;

  FetchWeatherWithCityNameForUpdateEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class DeleteCityForWeatherEvent extends CitiesWeathersSummeryEvent {
  final String cityName;

  DeleteCityForWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class UpdateCityWeatherEvent extends CitiesWeathersSummeryEvent{
  final CityModel cityWeathers;

  UpdateCityWeatherEvent(this.cityWeathers);

  @override
  List<Object> get props => [cityWeathers];
}

class WeatherError extends CitiesWeathersSummeryState {
  final int errorCode;

  WeatherError(this.errorCode);

}