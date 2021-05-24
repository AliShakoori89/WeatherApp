import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/daily_weather_model.dart';
import 'package:weather/models/hourly_weather_model.dart';
// import 'package:weather/models/week_weathers_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

class HourlyWeatherEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class HourlyWeatherState extends Equatable {
  @override

  List<Object> get props => throw[];
}

class FetchHourlyWeathersWithGetForecastEvent extends HourlyWeatherEvent{
  final String cityName;

  FetchHourlyWeathersWithGetForecastEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class HourlyWeatherIsLoadedState extends HourlyWeatherState{
  final HourlyWeatherModel _weather;

  HourlyWeatherIsLoadedState(this._weather);

  HourlyWeatherModel get getWeather => _weather;

  @override
  List<Object> get props => [_weather];
}

class HourlyWeatherError extends HourlyWeatherState {
  final int errorCode;

  HourlyWeatherError(this.errorCode);

}

class HourlyWeatherLoadingState extends HourlyWeatherState {}

class HourlyWeatherIsNotLoadedState extends HourlyWeatherState {}

class HourlyWeatherEmpty extends HourlyWeatherState {}

class HourlyWeatherBloc extends Bloc<HourlyWeatherEvent, HourlyWeatherState> {
  WeatherRepository weatherRepository;
  HourlyWeatherBloc(this.weatherRepository) : super(HourlyWeatherIsNotLoadedState());

  @override
  HourlyWeatherState get initialState {
    return HourlyWeatherEmpty();
  }

  @override
  Stream<HourlyWeatherState> mapEventToState(HourlyWeatherEvent event) async* {
    if (event is FetchHourlyWeathersWithGetForecastEvent) {

      // print('FetchWeathersWithGetForecastEvent WeekWeatherEventbloc');

      yield HourlyWeatherLoadingState();
      try {
        print('FetchWeathersWithGetForecastEvent WeekWeatherEventbloc');
        final HourlyWeatherModel weather = await weatherRepository.getForecastForHourly(
            event.cityName
        );
        print('FetchWeathersWithGetForecastEvent WeekWeatherEventbloccc  $weather');

        yield HourlyWeatherIsLoadedState(weather);
      } catch (exception) {
        print(exception);
        if (exception is AppException) {
          yield HourlyWeatherError(300);
        } else {
          yield HourlyWeatherError(500);
        }
      }
    }
  }
}
