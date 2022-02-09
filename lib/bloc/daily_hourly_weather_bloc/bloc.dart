import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/event.dart';
import 'package:weather/bloc/daily_hourly_weather_bloc/state.dart';
import 'package:weather/models/hourly_weather_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

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