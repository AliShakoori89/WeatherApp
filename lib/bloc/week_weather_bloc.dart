import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/daily_weather_model.dart';
import 'package:weather/models/hourly_weather_model.dart';
// import 'package:weather/models/week_weathers_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

class DailyWeatherEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class DailyWeatherState extends Equatable {
  @override

  List<Object> get props => throw[];
}

class FetchDailyWeathersWithGetForecastEvent extends DailyWeatherEvent{
  final String cityName;

  FetchDailyWeathersWithGetForecastEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class DailyWeatherIsLoadedState extends DailyWeatherState{
  final DailyWeatherModel _weather;

  DailyWeatherIsLoadedState(this._weather);

  DailyWeatherModel get getWeather => _weather;

  // @override
  // List<Object> get props => [_weather];
}

class DailyWeatherError extends DailyWeatherState {
  final int errorCode;

  DailyWeatherError(this.errorCode);

}

class DailyWeatherLoadingState extends DailyWeatherState {}

class DailyWeatherIsNotLoadedState extends DailyWeatherState {}

class DailyWeatherEmpty extends DailyWeatherState {}

class DailyWeatherBloc extends Bloc<DailyWeatherEvent, DailyWeatherState> {
  WeatherRepository weatherRepository;
  DailyWeatherBloc(this.weatherRepository) : super(DailyWeatherIsNotLoadedState());

  @override
  DailyWeatherState get initialState {
    return DailyWeatherEmpty();
  }

  @override
  Stream<DailyWeatherState> mapEventToState(DailyWeatherEvent event) async* {

    if (event is FetchDailyWeathersWithGetForecastEvent) {
      yield DailyWeatherLoadingState();
      try {
        final DailyWeatherModel weather = await weatherRepository.getForecastForDaily(
            event.cityName);

        yield DailyWeatherIsLoadedState(weather);
      } catch (exception) {
        if (exception is AppException) {
          yield DailyWeatherError(300);
        } else {
          yield DailyWeatherError(500);
        }
      }
    }
  }
}
