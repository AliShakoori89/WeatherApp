import 'package:equatable/equatable.dart';
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

class UpdateCityWeatherEvent extends CitiesWeathersSummeryEvent{
  final CityModel cityModel;

  UpdateCityWeatherEvent(this.cityModel);

  @override
  List<Object> get props => [cityModel];
}