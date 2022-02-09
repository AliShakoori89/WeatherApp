import 'package:equatable/equatable.dart';
import 'package:weather/models/city_model.dart';

class FetchCitiesDataState extends Equatable {
  @override

  List<Object> get props => throw[];
}

class FetchCitiesDataIsLoadedState extends FetchCitiesDataState {
  final citiesWeather;

  FetchCitiesDataIsLoadedState(this.citiesWeather);

  List<CityModel> get getCitiesWeathers => citiesWeather;

  @override
  List<Object> get props => [citiesWeather];
}

class FetchCitiesDataIsNotLoadedState extends FetchCitiesDataState{}

class FetchCitiesDataIsLoadingState extends FetchCitiesDataState {}