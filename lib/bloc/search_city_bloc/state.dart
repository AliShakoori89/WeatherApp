import 'package:equatable/equatable.dart';
import 'package:weather/models/weather_model.dart';

class SearchResultState extends Equatable {
  @override

  List<Object> get props => throw[];
}



class SearchResultIsLoadedState extends SearchResultState{
  final WeatherModel _weather;

  SearchResultIsLoadedState(this._weather);

  WeatherModel get getWeather => _weather;


  @override
  List<Object> get props => [_weather];
}

class SearchResultError extends SearchResultState {
  final int errorCode;

  SearchResultError(this.errorCode);

}

class SearchResultInitialState extends SearchResultState {}

class SearchResultLoadingState extends SearchResultState {}

class SearchResultIsNotLoadedState extends SearchResultState {}

class SearchResultEmpty extends SearchResultState {}