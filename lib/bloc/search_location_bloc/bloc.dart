import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/bloc/search_location_bloc/event.dart';
import 'package:weather/bloc/search_location_bloc/state.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:geolocator/geolocator.dart' as Geo;

class SearchLocationsBloc extends Bloc<SearchLocationEvent, SearchLocationStat> {

  WeatherRepository weatherRepository;

  SearchLocationsBloc(this.weatherRepository) : super(SearchLocationIsNotLoadedState());

  @override
  SearchLocationStat get initialState {
    return SearchLocationEmpty();
  }

  @override
  Stream<SearchLocationStat> mapEventToState(SearchLocationEvent event) async* {

    if (event is FetchWeathersLocations) {
      yield SearchLocationLoadingState();
      try {
        final Geo.Position location = await weatherRepository.fetchCityLocationRepo();
        yield SearchLocationIsLoadedState(location);
      } catch (exception) {
        print(exception);
        if (exception is AppException) {
          yield SearchLocationError(300);
        } else {
          yield SearchLocationError(500);
        }
      }
    }
  }
}