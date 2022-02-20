import 'package:equatable/equatable.dart';

class SearchResultEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class SearchCityWeatherResultEvent extends SearchResultEvent{
  final String cityName;

  SearchCityWeatherResultEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}