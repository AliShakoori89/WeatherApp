import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/fetch_all_cities/event.dart';
import 'package:weather/bloc/fetch_all_cities/state.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/repositories/weather_repository.dart';

class FetchCitiesDataBloc extends Bloc<FetchCitiesDataEvent, FetchCitiesDataState>{

  WeatherRepository weatherRepository;

  FetchCitiesDataBloc(this.weatherRepository) : super(FetchCitiesDataState());

  @override
  Stream<FetchCitiesDataState> mapEventToState(FetchCitiesDataEvent event) async*{
    print('FetchCitiesDataState');
    if(event is SaveCityWeathersEvent){
      await weatherRepository.saveCityWeatherDetailesRepo(event.cityWeathers);
    }

    if(event is DeleteCityForWeatherEvent){
      await weatherRepository.deleteCityWeatherDetailesRepo(event.cityName);
      List<CityModel> citiesWeather = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield FetchCitiesDataIsLoadedState(citiesWeather);
    }

    if(event is FetchCitiesDataWeatherEvent){
      print('kkkkkkkkkkkkkkkkkkkkkkkkkkkk');
      List<CityModel> citiesWeather = await weatherRepository.fetchAllDataCityWeatherRepo();
      yield FetchCitiesDataIsLoadedState(citiesWeather);
    }

    if (event is UpdateCityWeatherEvent) {
      await weatherRepository.updateCityWeatherRepo(event.cityModel);
    }
  }
}