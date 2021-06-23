import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

class WeatherEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class WeatherState extends Equatable {
  @override

  List<Object> get props => throw[];
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

class WeatherIsLoadedState extends WeatherState{
  final WeatherModel _weather;

  WeatherIsLoadedState(this._weather);

  WeatherModel get getWeather => _weather;


  @override
  List<Object> get props => [_weather];
}

class WeatherError extends WeatherState {
  final int errorCode;

  WeatherError(this.errorCode);

}

class WeatherLoadingState extends WeatherState {}

class WeatherIsNotLoadedState extends WeatherState {}

class WeatherEmpty extends WeatherState {}

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherIsNotLoadedState());

  @override
  WeatherState get initialState {
    return WeatherEmpty();
  }

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {

    if (event is FetchWeatherWithCityNameEvent) {
      yield WeatherLoadingState();
      try {
        final WeatherModel weather = await weatherRepository.getWeatherWithCityName(
            event.cityName,
        );
        yield WeatherIsLoadedState(weather);
      } catch (exception) {
        print(exception);
        if (exception is AppException) {
          yield WeatherError(300);
        } else {
          yield WeatherError(500);
        }
      }
    }

    if (event is FetchWeatherWithCityLocationEvent) {
      yield WeatherLoadingState();
      try {
        final WeatherModel weather = await weatherRepository.getCityNameFromLocation(
          event.lat, event.lon
        );
        yield WeatherIsLoadedState(weather);
      } catch (exception) {
        print(exception);
        if (exception is AppException) {
          yield WeatherError(300);
        } else {
          yield WeatherError(500);
        }
      }
    }
  }
}