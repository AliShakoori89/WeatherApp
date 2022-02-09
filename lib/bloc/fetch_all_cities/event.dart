import 'package:equatable/equatable.dart';
import 'package:weather/models/city_model.dart';

class FetchCitiesDataEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class SaveCityWeathersEvent extends FetchCitiesDataEvent{
  final CityModel cityWeathers;

  SaveCityWeathersEvent(this.cityWeathers);

  @override
  List<Object> get props => [cityWeathers];
}

class FetchCitiesDataWeatherEvent extends FetchCitiesDataEvent{}

class DeleteCityForWeatherEvent extends FetchCitiesDataEvent {
  final String cityName;

  DeleteCityForWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class UpdateCityWeatherEvent extends FetchCitiesDataEvent{
  final CityModel cityModel;

  UpdateCityWeatherEvent(this.cityModel);

  @override
  List<Object> get props => [cityModel];
}