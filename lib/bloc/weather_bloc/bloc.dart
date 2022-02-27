import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/weather_bloc/event.dart';
import 'package:weather/bloc/weather_bloc/state.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherRepository weatherRepository;

  WeatherBloc(this.weatherRepository) : super(WeatherInitialState());

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