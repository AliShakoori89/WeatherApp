import 'package:equatable/equatable.dart';
import 'package:weather/models/city_model.dart';

class CitiesWeathersSummeryState extends Equatable {
  @override

  List<Object> get props => throw[];
}

class CitiesWeathersSummeryIsLoadedState extends CitiesWeathersSummeryState {
  final citiesWeather;

  CitiesWeathersSummeryIsLoadedState(this.citiesWeather);

  List<CityModel> get getCitiesWeathers => citiesWeather;

  @override
  List<Object> get props => [citiesWeather];
}

class CitiesWeathersSummeryIsNotLoadedState extends CitiesWeathersSummeryState{}

class CitiesWeathersSummeryIsLoadingState extends CitiesWeathersSummeryState {}