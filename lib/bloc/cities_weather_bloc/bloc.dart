import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/cities_weather_bloc/event.dart';
import 'package:weather/bloc/cities_weather_bloc/state.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';


class CitiesWeatherBloc extends Bloc<CitiesWeatherEvent, CitiesWeatherState>{
  WeatherRepository weatherRepository;

  CitiesWeatherBloc(this.weatherRepository) : super(CitiesWeatherState());

  @override
  Stream<CitiesWeatherState> mapEventToState(CitiesWeatherEvent event) async*{

    if(event is SaveCityWeathersEvent){
      await weatherRepository.saveCityWeatherDetailesRepo(event.cityWeathers);
      List<CityModel> contacts = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield CitiesWeatherIsLoadedState(contacts);
    }

    if(event is DeleteCityForWeatherEvent){
      await weatherRepository.deleteCityWeatherDetailesRepo(event.cityName);
      List<CityModel> contacts = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield CitiesWeatherIsLoadedState(contacts);
    }

    if(event is FetchAllDataEvent){
      List<CityModel> citiesWeather = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield CitiesWeatherIsLoadedState(citiesWeather);
    }

    if (event is UpdateCityWeatherEvent) {
      print(event.cityWeathers);
      await weatherRepository.updateCityWeatherRepo(event.cityWeathers);
      yield CitiesWeatherIsLoadedState(event.cityWeathers);
    }

    if (event is FetchWeatherWithCityNameForUpdateEvent) {
      yield CitiesWeatherIsLoadingState();
      try {
          await weatherRepository.getWeatherWithCityName(event.cityName);
        yield CitiesWeatherIsLoadingState();

      } catch (exception) {
        print(exception);
        if (exception is AppException) {
          yield CitiesWeatherError(300);
        } else {
          yield CitiesWeatherError(500);
        }
      }
    }
  }
}