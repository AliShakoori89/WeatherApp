import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/search_city_bloc/event.dart';
import 'package:weather/bloc/search_city_bloc/state.dart';
import 'package:weather/models/weather_model.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';

class SearchCityBloc extends Bloc<SearchResultEvent, SearchResultState>{
  WeatherRepository weatherRepository;

  SearchCityBloc(this.weatherRepository) : super(SearchResultInitialState());

  @override
  Stream<SearchResultState> mapEventToState(SearchResultEvent event) async*{


    @override
    Stream<SearchResultState> mapEventToState(SearchResultEvent event) async* {
      if (event is SearchCityWeatherResultEvent) {
        yield SearchResultLoadingState();
        try {
          final WeatherModel weather = await weatherRepository
              .getWeatherWithCityName(
            event.cityName,
          );
          yield SearchResultIsLoadedState(weather);
        } catch (exception) {
          if (exception is AppException) {
            yield SearchResultError(300);
          } else {
            yield SearchResultError(500);
          }
        }
      }
    }
  }
}