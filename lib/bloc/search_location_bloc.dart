import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather/models/locationModel.dart';
import 'package:weather/networking/http_exception.dart';
import 'package:weather/repositories/weather_repository.dart';
import 'package:geolocator/geolocator.dart' as Geo;

class SearchLocationEvent extends Equatable {
  @override

  List<Object> get props => [];
}

class SearchLocationStat extends Equatable {
  @override

  List<Object> get props => throw[];
}

class SearchLocationIsLoadedState extends SearchLocationStat{

  final Geo.Position location;

  SearchLocationIsLoadedState(this.location);

  Geo.Position get getLocations => location;

  @override
  List<Object> get props => [location];
}

class FetchWeathersLocations extends SearchLocationEvent{

  FetchWeathersLocations();

  @override
  List<Object> get props => [];
}

class SearchLocationError extends SearchLocationStat {
  final int errorCode;

  SearchLocationError(this.errorCode);
}

class SearchLocationLoadingState extends SearchLocationStat {}

class SearchLocationIsNotLoadedState extends SearchLocationStat {}

class SearchLocationEmpty extends SearchLocationStat {}

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
        print('is load1');
        final Geo.Position location = await weatherRepository.fetchCityLocationRepo();
        // print(location.longitude);
        print('is load2');
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