import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/event.dart';
import 'package:weather/bloc/all_cities_summery_container_bloc/state.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/repositories/weather_repository.dart';

class CitiesWeathersSummeryBloc extends Bloc<CitiesWeathersSummeryEvent, CitiesWeathersSummeryState>{
  WeatherRepository weatherRepository;

  CitiesWeathersSummeryBloc(this.weatherRepository) : super(CitiesWeathersSummeryState());

  @override
  Stream<CitiesWeathersSummeryState> mapEventToState(CitiesWeathersSummeryEvent event) async*{

    if(event is SaveCityWeathersEvent){
      await weatherRepository.saveCityWeatherDetailesRepo(event.cityWeathers);
    }

    if(event is FetchAllDataEvent){
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      List<CityModel> citiesWeather = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield CitiesWeathersSummeryIsLoadedState(citiesWeather);
    }

    if (event is UpdateCityWeatherEvent) {
      await weatherRepository.updateCityWeatherRepo(event.cityModel);
    }
  }
}