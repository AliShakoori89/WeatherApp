import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/city_model.dart';
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

// class FetchWeatherWithLocationEvent extends WeatherEvent{
//   final double longitude;
//   final double latitude;
//
//   FetchWeatherWithLocationEvent(this.longitude, this.latitude);
//
//   @override
//   List<Object> get props => [longitude, latitude];
// }

class AddCityForWeatherEvent extends WeatherEvent {
  final CityModel cityModel;

  AddCityForWeatherEvent(this.cityModel);

  @override
  List<Object> get props => [cityModel];
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
        print('FetchWeatherWithCityNameEvent WeatherEventbloc $weather');
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

    // if(event is FetchWeatherWithLocationEvent){
    //   yield WeatherLoadingState();
    //   try {
    //     final WeatherModel weather = await weatherRepository.getWeatherWithLocation(
    //       event.latitude,
    //       event.longitude
    //     );
    //     yield WeatherIsLoadedState(weather);
    //   } catch (exception) {
    //     print(exception);
    //     if (exception is AppException) {
    //       yield WeatherError(300);
    //     } else {
    //       yield WeatherError(500);
    //     }
    //   }
    // }

    if(event is AddCityForWeatherEvent){
      await weatherRepository.saveContactRepo(event.cityModel);
      final WeatherModel weather = await weatherRepository.getWeatherWithCityName(
        event.cityModel.toString(),
      );
      yield WeatherIsLoadedState(weather);
    }
  }
}