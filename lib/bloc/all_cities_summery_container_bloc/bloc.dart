import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/event.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/state.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

class CitiesWeathersSummeryBloc extends Bloc<CitiesWeathersSummeryEvent, CitiesWeathersSummeryState>{
  WeatherRepository weatherRepository;

  CitiesWeathersSummeryBloc(this.weatherRepository) : super(CitiesWeathersSummeryState());

  @override
  Stream<CitiesWeathersSummeryState> mapEventToState(CitiesWeathersSummeryEvent event) async*{

    if(event is SaveCityWeathersEvent){
      await weatherRepository.saveCityWeatherDetailesRepo(event.cityWeathers);
      List<CityModel> contacts = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield CitiesWeathersSummeryIsLoadedState(contacts);
    }

    if(event is DeleteCityForWeatherEvent){
      await weatherRepository.deleteCityWeatherDetailesRepo(event.cityName);
      List<CityModel> contacts = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield CitiesWeathersSummeryIsLoadedState(contacts);
    }

    if(event is FetchAllDataEvent){
      List<CityModel> citiesWeather = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield CitiesWeathersSummeryIsLoadedState(citiesWeather);
    }

    if (event is UpdateCityWeatherEvent) {
      print(event.cityWeathers);
      await weatherRepository.updateCityWeatherRepo(event.cityWeathers);
      yield CitiesWeathersSummeryIsLoadedState(event.cityWeathers);
    }

    if (event is FetchWeatherWithCityNameForUpdateEvent) {
      print(1);
      yield CitiesWeathersSummeryIsLoadingState();
      print(2);
      try {
        print(3);
        final WeatherModel weather = await weatherRepository.getWeatherWithCityName(
          event.cityName,
        );
        print(4);
        // yield UpdateCitiesWeathersSummeryIsLoadedState(weather);
        yield CitiesWeathersSummeryIsLoadingState();

        print(5);
      } catch (exception) {
        print(6);
        print(exception);
        if (exception is AppException) {
          print(7);
          yield WeatherError(300);
        } else {
          print(8);
          yield WeatherError(500);
        }
      }
    }
  }
}