import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/hourly_weather_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

class WeatherDetailsEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class WeatherDetailsState extends Equatable {
  @override

  List<Object> get props => throw[];
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

class WeatherDetailsIsLoadedState extends WeatherDetailsState{
  final WeatherDetailsModel _weather;

  WeatherDetailsIsLoadedState(this._weather);

  WeatherDetailsModel get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class WeatherDetailsError extends WeatherDetailsState {
  final int errorCode;

  WeatherDetailsError(this.errorCode);

}

class WeatherDetailsLoadingState extends WeatherDetailsState {}

class WeatherDetailsIsNotLoadedState extends WeatherDetailsState {}

class WeatherDetailsEmpty extends WeatherDetailsState {}

class WeatherDetailsBloc extends Bloc<WeatherDetailsEvent, WeatherDetailsState> {
  WeatherRepository weatherRepository;
  WeatherDetailsBloc(this.weatherRepository) : super(WeatherDetailsIsNotLoadedState());

  @override
  WeatherDetailsState get initialState {
    return WeatherDetailsEmpty();
  }

  @override
  Stream<WeatherDetailsState> mapEventToState(WeatherDetailsEvent event) async* {

    if (event is FetchWeathersDetailsWithCityName) {

      yield WeatherDetailsLoadingState();
      try {
        final WeatherDetailsModel weather = await weatherRepository.getForecastForHourlyWithCityName(
            event.cityName
        );
        yield WeatherDetailsIsLoadedState(weather);
      } catch (exception) {
        if (exception is AppException) {
          yield WeatherDetailsError(300);
        } else {
          yield WeatherDetailsError(500);
        }
      }
    }

    if (event is FetchWeathersDetailsWithCityLocation) {

      yield WeatherDetailsLoadingState();
      try {
        final WeatherDetailsModel weather = await weatherRepository.getForecastForHourlyWithCityLocation(
            event.lat, event.lon
        );
        yield WeatherDetailsIsLoadedState(weather);
      } catch (exception) {
        if (exception is AppException) {
          yield WeatherDetailsError(300);
        } else {
          yield WeatherDetailsError(500);
        }
      }
    }
  }
}
