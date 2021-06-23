import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/models/city_model.dart';
import 'package:weather/repositories/weather_repository.dart';

class CitiesWeathersSummeryEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class CitiesWeathersSummeryState extends Equatable {
  @override

  List<Object> get props => throw[];
}

class CitiesWeathersSummeryIsLoadedState extends CitiesWeathersSummeryState {
  final citiesWeather;

  CitiesWeathersSummeryIsLoadedState(this.citiesWeather);

  List<CityModel> get getCitiesWeathers => citiesWeather;

  @override
  List<Object> get props => [citiesWeather];
}

class CitiesWeathersSummeryIsNotLoadedState extends CitiesWeathersSummeryState{}

class CitiesWeathersSummeryIsLoadingState extends CitiesWeathersSummeryState {}

class SaveCityWeathersEvent extends CitiesWeathersSummeryEvent{
  final CityModel cityWeathers;

  SaveCityWeathersEvent(this.cityWeathers);

  @override
  List<Object> get props => [cityWeathers];
}

class FetchAllDataEvent extends CitiesWeathersSummeryEvent{}

class DeleteCityForWeatherEvent extends CitiesWeathersSummeryEvent {
  final String cityName;

  DeleteCityForWeatherEvent(this.cityName);

  @override
  List<Object> get props => [cityName];
}

class UpdateCityWeatherEvent extends CitiesWeathersSummeryEvent{
  final CityModel cityModel;

  UpdateCityWeatherEvent(this.cityModel);

  @override
  List<Object> get props => [cityModel];
}


class CitiesWeathersSummeryBloc extends Bloc<CitiesWeathersSummeryEvent, CitiesWeathersSummeryState>{
  WeatherRepository weatherRepository;

  CitiesWeathersSummeryBloc(this.weatherRepository) : super(CitiesWeathersSummeryState());

  @override
  Stream<CitiesWeathersSummeryState> mapEventToState(CitiesWeathersSummeryEvent event) async*{
    if(event is SaveCityWeathersEvent){
      await weatherRepository.saveCityWeatherDetailesRepo(event.cityWeathers);
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
      await weatherRepository.updateCityWeatherRepo(event.cityModel);
    }
  }
}