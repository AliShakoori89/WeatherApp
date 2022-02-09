import 'package:equatable/equatable.dart';

class WeatherDetailsEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class FetchWeathersDetailsWithCityName extends WeatherDetailsEvent{
  final String cityName;

  FetchWeathersDetailsWithCityName(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class FetchWeathersDetailsWithCityLocation extends WeatherDetailsEvent{
  final double lat;
  final double lon;

  FetchWeathersDetailsWithCityLocation(this.lat, this.lon);

  @override
  List<Object> get props => [lat, lon];
}