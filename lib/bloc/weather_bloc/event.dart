import 'package:equatable/equatable.dart';

class WeatherEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class FetchWeatherWithCityNameEvent extends WeatherEvent{
  final String cityName;

  FetchWeatherWithCityNameEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}


class FetchWeatherWithCityLocationEvent extends WeatherEvent{
  final double lat;
  final double lon;

  FetchWeatherWithCityLocationEvent(this.lat, this.lon);

  @override
  List<Object> get props => [lat, lon];
}